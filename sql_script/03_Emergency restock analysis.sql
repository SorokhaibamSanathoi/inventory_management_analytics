--================================
--Which site require the most emergency restock for a specific item 
--================================

SELECT 
    r.site_id,
    r.item_id,
    i.item_name,
    COUNT(r.restock_id) AS emergency_restock_count
FROM inventory_management_analytics.restock AS r
JOIN inventory_management_analytics.items AS i
    ON r.item_id = i.item_id
WHERE r.restock_type = 'emergency'
GROUP BY (r.site_id, r.item_id, i.item_name)
ORDER BY
    COUNT(r.restock_id) DESC;


--===============================
--This query counts how many emergency restocks have been made by each site
--===============================

SELECT 
    site_id,
    COUNT(*) AS total_emergency_restocks
FROM inventory_management_analytics.restock
WHERE restock_type = 'emergency'
GROUP BY site_id
ORDER BY total_emergency_restocks DESC;