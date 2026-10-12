CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cancellation_status_2 AS SELECT 0 AS is_after_cancellation_fg,
 'Vor Storno' AS is_after_cancellation_fg_name
FROM (SELECT 0 AS column1,
    'Vor Storno' AS column2
   UNION ALL
   SELECT 1 AS column1,
    'Nach Storno' AS column2);