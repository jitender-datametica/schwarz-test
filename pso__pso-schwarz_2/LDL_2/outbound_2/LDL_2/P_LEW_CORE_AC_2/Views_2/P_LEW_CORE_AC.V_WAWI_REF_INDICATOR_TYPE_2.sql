CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_indicator_type_2 (indicator_type_id, indicator_type_desc, dat_dayend,
load_id) AS SELECT indicator_type_id,
 indicator_type_desc,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_indicator_type_2;