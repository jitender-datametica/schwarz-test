CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_indicator_1 (indicator_id, indicator_desc, indicator_valuetype,
dat_dayend, load_id) AS SELECT indicator_id,
 indicator_desc,
 indicator_valuetype,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_indicator_1;