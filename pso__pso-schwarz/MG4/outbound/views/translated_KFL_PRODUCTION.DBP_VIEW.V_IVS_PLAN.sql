CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_plan (plandetail_id, mandant_id, plantyp_id, plan_objekt_id, kjmo,
plan_wert, plan_wert_konz, kostenstelle_id, dat_extrakt, wrg_id) AS SELECT plandetail_id,
 mandant_id,
 plantyp_id,
 plan_objekt_id,
 kjmo,
 plan_wert,
 plan_wert_konz,
 kostenstelle_id,
 dat_extrakt,
 wrg_id
FROM kfl_production_dbp_data.ivs_plan;