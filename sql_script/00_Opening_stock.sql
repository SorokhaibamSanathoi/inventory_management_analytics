-- Display the opening stock quantity for every inventory item
-- across all sites.

SELECT
    o.site_id,
    i.item_name,
    i.unit,
    SUM(o.opening_stock) AS total_opening_stock
FROM inventory_management_analytics.opening_stock AS o
JOIN inventory_management_analytics.items AS i
    ON o.item_id = i.item_id
GROUP BY
    o.site_id,
    i.item_name,
    i.unit
ORDER BY site_id, total_opening_stock DESC;