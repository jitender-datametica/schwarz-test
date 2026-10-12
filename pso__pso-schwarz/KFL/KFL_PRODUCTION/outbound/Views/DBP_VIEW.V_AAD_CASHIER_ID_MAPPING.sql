CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_cashier_id_mapping AS SELECT hashed_cashier_id,
 mandant_id,
 wup_id,
 kassierer_nr,
 hash_generation_dt
FROM kfl_production_dbp_data.aad_cashier_id_mapping;