CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_plan_planheader (client_id, plan_id, plan_nr, dat_plan, dat_dayend,
dat_busyear_from, dat_busyear_until, plantype_id, plan_version, plan_titel, plan_desc, load_id) AS SELECT client_id,
 plan_id,
 plan_nr,
 dat_plan,
 dat_dayend,
 dat_busyear_from,
 dat_busyear_until,
 plantype_id,
 plan_version,
 plan_titel,
 plan_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_plan_planheader;