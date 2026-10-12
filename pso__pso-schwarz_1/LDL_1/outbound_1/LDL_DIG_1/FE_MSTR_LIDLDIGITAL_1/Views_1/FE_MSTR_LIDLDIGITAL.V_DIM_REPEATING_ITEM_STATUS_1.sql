CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_repeating_item_status_1 AS SELECT 0 AS is_repeated_fg,
 '' AS is_repeated_fg_name
FROM (SELECT 0 AS column1,
    '' AS column2
   UNION ALL
   SELECT 1 AS column1,
    'WDH' AS column2);