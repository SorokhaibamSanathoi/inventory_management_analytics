CREATE VIEW inventory_management_analytics.inventory_movement AS
    SELECT
        d.date AS date,
        d.site_id,
        d.client_id,
        d.item_id,

        i.item_name,
        i.category,
        i.unit,

        d.day_type,
        d.shift,
        d.effective_headcount,
        d.qty_drawn

    FROM inventory_management_analytics.daily_usage d
    INNER JOIN inventory_management_analytics.items i
    ON d.item_id = i.item_id;

