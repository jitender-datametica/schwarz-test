CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lage AS SELECT mandant_id,
 lage_id,
 lage_bez
FROM kfl_production_dbp_data.l_lage;