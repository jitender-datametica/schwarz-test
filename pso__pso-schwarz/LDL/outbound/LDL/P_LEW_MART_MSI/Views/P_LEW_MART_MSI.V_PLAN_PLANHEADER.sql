CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_plan_planheader AS SELECT client_id,
 plan_id,
 plan_nr,
 dat_plan,
 dat_busyear_from,
 dat_busyear_until,
 plantype_id,
 plan_version,
 plan_titel,
 plan_desc,
 dat_dayend
FROM ldl_p_lew_core_ac.v_wawi_plan_planheader AS PP;