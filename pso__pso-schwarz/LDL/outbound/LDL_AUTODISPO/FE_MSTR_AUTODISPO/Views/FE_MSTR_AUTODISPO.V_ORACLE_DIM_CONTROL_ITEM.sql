CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_control_item (country, item_nr, param_name,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT country,
 param_value AS item_nr,
 param_name,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_dd_parameter
WHERE param_name = 'CONTROL_ITEM';