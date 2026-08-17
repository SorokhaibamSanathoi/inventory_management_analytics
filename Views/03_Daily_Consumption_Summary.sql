DROP VIEW inventory_management_analytics.stock_status;
DROP VIEW inventory_management_analytics.daily_consumption_summary;

CREATE VIEW inventory_management_analytics.daily_consumption_summary AS
    SELECT
        d.date,
        EXTRACT(MONTH FROM d.date) AS month_number,
        TO_CHAR(d.date, 'Month') AS month_name,
        d.site_id,
        d.item_id,
        i.item_name,
        i.category,
        i.unit,
        SUM(d.qty_drawn) AS total_qty_drawn
    FROM inventory_management_analytics.daily_usage d
    INNER JOIN inventory_management_analytics.items i
        ON i.item_id = d.item_id
    WHERE d.is_outlier = 'FALSE'
    GROUP BY 
        d.date,
        d.site_id,
        d.item_id,
        i.item_name,
        i.category,
        i.unit;