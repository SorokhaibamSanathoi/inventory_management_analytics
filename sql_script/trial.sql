-- combining the restock balance and consumption data

--positive values
WITH unified_data AS (
    SELECT *
        r.item_id,
        r.site_id,
        date AS date,
        r.qty as quantity
    FROM inventory_management.restock

UNION ALL

--negative values
    SELECT *
        c.item_id,
        c.site_id,
        date AS date,
        -c.qty_drawn as quantity
    FROM inventory_management.daily_usage
    WHERE is_outlier ='False'
    
)
Daily balance as (
    SELECT item_id, site_id, date, SUM(quantity) as daily_balance
    FROM unified_data
    GROUP BY item_id, site_id, date
)