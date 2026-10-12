CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_meta_load_time_fact_customer_order_line_live (max_dwh_updated_tmsp
) AS SELECT CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(CONCAT(MAX(cust_order_dt), ' ', MAX(cust_order_create_tm)) AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS max_dwh_updated_tmsp
FROM ldl_dig_fe_mstr_lidldigital.t_fact_customer_order_line_live
WHERE is_part_of_bundle_header_cnt_fg
 AND cust_order_dt = CURRENT_DATE;