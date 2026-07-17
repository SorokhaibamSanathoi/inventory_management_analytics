-- combining the restock balance and consumption data

--positive values
WITH unified_data AS (
    SELECT
        r.item_id,
        r.site_id,
        date AS date,
        r.qty as quantity
    FROM inventory_management_analytics.restock r

UNION ALL

--negative values
    SELECT 
        c.item_id,
        c.site_id,
        date AS date,
        -c.qty_drawn as quantity
    FROM inventory_management_analytics.daily_usage c
    WHERE is_outlier ='False'
    
),
Daily_balance AS (
    SELECT 
        u.item_id,
        u.site_id,
        u.date,
        COALESCE(o.opening_stock,0) +
    SUM(u.quantity) OVER (
        PARTITION BY u.item_id, u.site_id
        ORDER BY u.date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS balance_stock
    FROM unified_data u
    left join inventory_management_analytics.opening_stock o
    on o.site_id = u.site_id and o.item_id = u.item_id
),
Ranked_Stocks AS (
    SELECT 
        site_id,
        item_id,
        date,
        balance_stock,
        RANK() OVER (
            PARTITION BY site_id, item_id 
            ORDER BY balance_stock ASC
        ) as stock_rank
    FROM Daily_balance
)
SELECT 
    rs.site_id,
    rs.item_id,
    i.item_name,
    rs.date AS lowest_stock_date,
    rs.balance_stock AS lowest_stock_balance
FROM Ranked_Stocks rs
JOIN inventory_management_analytics.items i
    ON rs.item_id = i.item_id
WHERE stock_rank = 1
ORDER BY rs.site_id, lowest_stock_balance ASC;