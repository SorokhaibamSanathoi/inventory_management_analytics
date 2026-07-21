--=========================================
-- Calculate average daily consumption for
-- each item at each site
--=========================================

WITH daily_consumption AS (
    SELECT
        d.date,
        d.site_id,
        d.item_id,
        i.item_name AS item_name,
        SUM(qty_drawn) AS daily_qty_drawn
    FROM inventory_management_analytics.daily_usage d
    INNER JOIN inventory_management_analytics.items i
    on i.item_id = d.item_id
    WHERE is_outlier = 'FALSE'
    GROUP BY
        date,
        d.site_id,
        d.item_id,
        i.item_name
)

SELECT
    site_id,
    item_id,
    item_name,
    ROUND(AVG(daily_qty_drawn),2) AS avg_daily_consumption
FROM daily_consumption
GROUP BY
    site_id,
    item_id,
    item_name
ORDER BY site_id
