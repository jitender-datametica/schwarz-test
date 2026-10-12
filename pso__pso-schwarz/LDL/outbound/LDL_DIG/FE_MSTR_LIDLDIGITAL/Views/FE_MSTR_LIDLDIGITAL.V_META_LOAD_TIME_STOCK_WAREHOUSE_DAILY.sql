CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_meta_load_time_stock_warehouse_daily AS WITH CTE AS (SELECT MAX(dwh_updated_tmsp
     ) AS max_dwh_updated_tmsp
   FROM ldl_dig_lec_share.v_fact_stock_warehouse_storage_location_daily
   UNION DISTINCT
   SELECT MAX(dwh_updated_tmsp) AS max_dwh_updated_tmsp
   FROM ldl_dig_lec_share.v_fact_stock_warehouse_daily) (SELECT CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(MIN(max_dwh_updated_tmsp) AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
   AS max_dwh_updated_tmsp
  FROM CTE);