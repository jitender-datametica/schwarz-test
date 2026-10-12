CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_control_item_2 (country_2, item_nr, param_name,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT country_2,
 param_value AS item_nr,
 param_name,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_dd_parameter_2
WHERE param_name = 'CONTROL_ITEM';