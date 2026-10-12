CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_pps_planungskalender_1 AS SELECT system_id,
 mandant_id,
 pps_plan_kalender_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_data.l_pps_planungskalender_1;