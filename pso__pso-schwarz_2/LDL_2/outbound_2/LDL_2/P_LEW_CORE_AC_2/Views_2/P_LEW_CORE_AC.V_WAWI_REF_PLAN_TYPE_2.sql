CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_plan_type_2 (plantype_id, plantype_desc, dat_dayend, load_id) AS
SELECT plantype_id,
 plantype_desc,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_plan_type_2;