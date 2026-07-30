CREATE VIEW inventory_management_analytics.stock_status AS

-- Get the latest stock record for each item at each site
WITH latest_stock AS(
    SELECT 
        site_id,
        item_id,
        movement_date,
        balance_stock,
        item_name,
        category,
        unit,

        ROW_NUMBER() OVER (
    PARTITION BY site_id, item_id
    ORDER BY movement_date DESC
    ) AS rnk
     FROM inventory_management_analytics.inventory_balance
),

-- Calculate average daily consumption for each item at each site
average_consumption AS(
    SELECT
        site_id,
        item_id,
        avg(total_qty_drawn) AS avg_consumption

    FROM inventory_management_analytics.daily_consumption_summary
    GROUP BY site_id,item_id
)
SELECT
    l.site_id,
    l.item_id,
    l.item_name,
    l.category,
    l.unit,
    l.movement_date,
    l.balance_stock,
    ROUND(a.avg_consumption,2) AS avg_consumption,
    ROUND(l.balance_stock/a.avg_consumption,2) AS days_remaining,
    CASE
        WHEN ROUND(l.balance_stock / a.avg_consumption, 2) < 7 THEN 'Critical'
        WHEN ROUND(l.balance_stock / a.avg_consumption, 2) < 30 THEN 'Low'
        ELSE 'Healthy'
    END AS stock_status
FROM latest_stock l
LEFT JOIN average_consumption a
ON l.site_id = a.site_id
    AND l.item_id = a.item_id
WHERE l.rnk = 1