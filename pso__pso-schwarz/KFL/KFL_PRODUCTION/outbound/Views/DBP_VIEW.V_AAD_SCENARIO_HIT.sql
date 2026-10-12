CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_scenario_hit AS SELECT scenario_id,
 bon_id,
 bon_dat,
 wup_id,
 mandant_id,
 wrg_id,
 bon_nr,
 bon_booking,
 kasse_nr,
 hashed_cashier_id,
 fraud_value_gross_local_val,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM kfl_production_dbp_data.aad_scenario_hit;