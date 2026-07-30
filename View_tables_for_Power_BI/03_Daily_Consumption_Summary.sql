CREATE VIEW inventory_management_analytics.daily_consumption_summary AS
    SELECT
        d.date AS date,
        d.site_id,
        d.item_id,
        SUM(d.qty_drawn) AS  total_qty_drawn,

        i.item_name,
        i.category,
        i.unit

FROM inventory_management_analytics.daily_usage d
INNER JOIN inventory_management_analytics.items i
ON i.item_id = d.item_id
GROUP BY 
    d.date,
    d.site_id,
    d.item_id,
    i.item_name,
    i.category,
    i.unit
