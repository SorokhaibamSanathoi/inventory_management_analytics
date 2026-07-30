CREATE VIEW inventory_management_analytics.inventory_balance AS

WITH unified_timeline AS(

    SELECT
        site_id,
        item_id,
        opening_date AS movement_date,
        opening_stock AS movement_qty,
        'opening_stock' AS movement_type

    FROM inventory_management_analytics.opening_stock


    UNION ALL


    SELECT
        site_id,
        item_id,
        date AS movement_date,
        qty AS movement_qty,
        'restock' AS movement_type

    FROM inventory_management_analytics.restock


    UNION ALL


    SELECT
        site_id,
        item_id,
        date AS movement_date,
        -qty_drawn AS movement_qty,
        'consumption' AS movement_type

    FROM inventory_management_analytics.daily_usage

    WHERE is_outlier = 'FALSE'
)

SELECT
    u.site_id,
    u.item_id,
    u.movement_date,
    u.movement_qty,

    SUM(u.movement_qty) OVER(
        PARTITION BY u.site_id,u.item_id
        ORDER BY u.movement_date,
        CASE
            WHEN u.movement_qty > 0 THEN 0
            ELSE 1
        END
    ) AS balance_stock,

    u.movement_type,
    i.item_name,
    i.category,
    i.unit

FROM unified_timeline u

LEFT JOIN inventory_management_analytics.items i
ON u.item_id = i.item_id;