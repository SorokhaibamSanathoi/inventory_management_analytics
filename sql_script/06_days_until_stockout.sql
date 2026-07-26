
WITH unified_timeline AS(
    SELECT
        site_id,
        item_id,
        opening_date AS movement_date,
        opening_stock AS movement_qty
    FROM inventory_management_analytics.opening_stock

    UNION ALL

    SELECT
        site_id,
        item_id,
        date AS movement_date,
        qty AS movement_qty
    FROM inventory_management_analytics.restock

    UNION ALL

    SELECT
        site_id,
        item_id,
        date AS movement_date,
        -qty_drawn AS movement_qty
    FROM inventory_management_analytics.daily_usage
    WHERE is_outlier = 'FALSE'
),
inventory_balance AS(
    SELECT
        site_id,
        item_id,
        movement_date,
        movement_qty,
        SUM(movement_qty) OVER(
            PARTITION BY site_id,item_id
            ORDER BY movement_date,
            CASE
                WHEN movement_qty > 0 THEN 0 
                ELSE 1 
                END
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS balance_stock
    FROM unified_timeline
),
final_balance AS (
    SELECT
        site_id,
        item_id,
        movement_date,
        balance_stock,
        ROW_NUMBER() OVER(
            PARTITION BY site_id,item_id
            ORDER BY movement_date DESC
        ) as rnk
    FROM inventory_balance
),
avg_consumption AS(
    SELECT
        site_id,
        item_id,
        round(avg(daily_use),2) as avg_daily_consumption
    FROM(
        SELECT
            date,
            site_id,
            item_id,
            SUM(qty_drawn) AS daily_use
        FROM inventory_management_analytics.daily_usage
        WHERE is_outlier = 'FALSE'
        GROUP BY date,site_id,item_id
    ) daily_totals
    GROUP BY site_id,item_id
    ORDER BY site_id
)

--FINAL SELECT QUERY

SELECT 
    f.site_id,
    f.item_id,
    f.balance_stock,
    a.avg_daily_consumption,
    round(f.balance_stock/a.avg_daily_consumption,0) AS days_remaining
FROM final_balance f
JOIN avg_consumption a
ON f.site_id = a.site_id AND f.item_id = a.item_id
WHERE f.rnk = 1
ORDER BY days_remaining ASC;
