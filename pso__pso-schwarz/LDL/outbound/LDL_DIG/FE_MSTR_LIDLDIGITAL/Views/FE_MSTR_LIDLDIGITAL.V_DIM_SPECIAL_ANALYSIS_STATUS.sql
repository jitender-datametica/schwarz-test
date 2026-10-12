CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_special_analysis_status AS SELECT 0 AS is_special_analysis_cd,
 'nein' AS is_special_analysis_cd_name
FROM (SELECT 0 AS column1,
    'nein' AS column2
   UNION ALL
   SELECT 1 AS column1,
    'ja' AS column2
   UNION ALL
   SELECT -1 AS column1,
    '' AS column2);