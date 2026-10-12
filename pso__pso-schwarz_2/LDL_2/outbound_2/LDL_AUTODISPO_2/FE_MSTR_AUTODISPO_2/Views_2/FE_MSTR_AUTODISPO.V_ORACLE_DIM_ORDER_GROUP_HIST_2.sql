CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_order_group_hist_2 (country_2, dog_wh, dog_name,
dog_item, dog_active, mod_date, dog_calculationmethod, dog_store, source_extraction_tmsp, dwh_valid_from_date,
dwh_valid_to_date) AS SELECT country_2,
 dog_wh AS wh,
 dog_name,
 dog_item,
 dog_active,
 mod_date,
 dog_calculationmethod,
 dog_store AS store,
 source_extraction_tmsp,
 DATE(dwh_valid_from_tmsp) AS dwh_valid_from_date,
 DATE(dwh_valid_to_tmsp + INTERVAL 1 DAY * - 1) AS dwh_valid_to_date
FROM ldl_autodispo_core.t_oracle_v_dim_order_group_2;