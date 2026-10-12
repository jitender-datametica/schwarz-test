CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_kalk_plan_spr_zu_1 (mandant_id, plan_kalk_id, spr_id,
plan_kalk_bez) AS SELECT V01.mandant_id,
 V01.plan_kalk_id,
 V01.spr_id,
 V01.plan_kalk_bez
FROM kfl_production_dbp_view.v_flw_kalk_plan_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id;