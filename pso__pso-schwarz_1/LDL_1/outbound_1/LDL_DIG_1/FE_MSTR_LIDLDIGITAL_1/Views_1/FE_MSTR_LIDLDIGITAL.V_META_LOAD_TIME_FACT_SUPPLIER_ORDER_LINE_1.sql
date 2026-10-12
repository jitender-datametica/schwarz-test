CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_meta_load_time_fact_supplier_order_line_1 (max_dwh_updated_tmsp) AS
SELECT CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(MAX(dwh_updated_tmsp) AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS max_dwh_updated_tmsp
FROM ldl_dig_lec_share.v_fact_supplier_order_line_1;