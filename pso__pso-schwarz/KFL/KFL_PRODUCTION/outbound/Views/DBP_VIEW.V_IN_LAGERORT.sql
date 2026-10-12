CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_lagerort AS SELECT mandant_id,
 werk_id,
 in_lagerort_id,
 in_lagerort_bez
FROM kfl_production_dbp_data.in_lagerort;