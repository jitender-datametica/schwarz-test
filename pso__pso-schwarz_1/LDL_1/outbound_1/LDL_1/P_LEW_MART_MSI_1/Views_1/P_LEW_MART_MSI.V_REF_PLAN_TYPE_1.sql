CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_plan_type_1 AS SELECT plantype_id,
 plantype_desc,
 dat_dayend
FROM ldl_p_lew_core_ac.v_wawi_ref_plan_type_1 AS RPT;