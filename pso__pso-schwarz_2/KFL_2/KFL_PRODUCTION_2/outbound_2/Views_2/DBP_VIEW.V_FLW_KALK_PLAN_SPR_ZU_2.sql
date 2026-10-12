CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kalk_plan_spr_zu_2 AS SELECT plan_kalk_id,
 spr_id,
 mandant_id,
 system_id,
 plan_kalk_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kalk_plan_spr_zu_2;