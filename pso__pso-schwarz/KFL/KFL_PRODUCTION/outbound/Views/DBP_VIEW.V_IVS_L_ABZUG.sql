CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_abzug AS SELECT mandant_id,
 abzug_id,
 abzug_bez
FROM kfl_production_dbp_data.ivs_l_abzug;