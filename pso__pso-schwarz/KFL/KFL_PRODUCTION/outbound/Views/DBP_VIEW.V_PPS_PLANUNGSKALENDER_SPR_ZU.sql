CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pps_planungskalender_spr_zu AS SELECT pps_plan_kalender_id,
 system_id,
 spr_id,
 mandant_id,
 pps_plan_kalender_bez
FROM kfl_production_dbp_data.pps_planungskalender_spr_zu;