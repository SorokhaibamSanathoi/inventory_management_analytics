CREATE VIEW inventory_management_analytics.monthly_restock AS
    SELECT 
        TRIM(TO_CHAR(r.date, 'Month')) AS month_name,
        r.site_id,
        r.item_id,
        i.item_name,
        r.restock_type,
        sum(r.qty) AS total_restock_qty,
        COUNT(r.*) AS restock_count
    FROM inventory_management_analytics.restock r
    LEFT JOIN inventory_management_analytics.items i
    ON r.item_id = i.item_id
    GROUP BY
        EXTRACT(MONTH FROM date),
        TRIM(TO_CHAR(r.date, 'Month')),
        r.site_id,
        r.item_id,
        i.item_name,
        r.restock_type