CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_meta_load_time_agg_sales_daily_tables (agg_table_name,
max_dwh_updated_tmsp) AS SELECT 'T_AGG_SALES_DAILY' AS agg_table_name,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(MAX(dwh_updated_tmsp) AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS max_dwh_updated_tmsp
FROM ldl_dig_lec_share.v_agg_sales_daily
UNION ALL
SELECT 'T_AGG_PRODUCT_SALES_DAILY',
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(MAX(dwh_updated_tmsp) AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS max_dwh_updated_tmsp
FROM ldl_dig_lec_share.v_agg_product_sales_daily
UNION ALL
SELECT 'T_AGG_PRODUCT_VARIANT_SALES_DAILY',
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(MAX(dwh_updated_tmsp) AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS max_dwh_updated_tmsp
FROM ldl_dig_lec_share.v_agg_product_variant_sales_daily;