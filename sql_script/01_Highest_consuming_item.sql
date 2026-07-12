--==============================
--This query is similar to the eda scrpt i did in python about finding out 
--which product is being consumed the most
--==============================

SELECT
    d.item_id,
    i.item_name,
    i.category,
    SUM(d.qty_drawn) AS total_qty_drawn
FROM inventory_management_analytics.daily_usage AS d
JOIN inventory_management_analytics.items AS i
    ON d.item_id = i.item_id
GROUP BY
    d.item_id,
    i.item_name,
    i.category
ORDER BY total_qty_drawn DESC;