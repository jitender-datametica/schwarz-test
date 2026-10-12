CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_engine_config_2 AS SELECT mandant_id,
 config_id,
 config_val,
 config_descr
FROM kfl_production_dbp_data.aad_engine_config_2;