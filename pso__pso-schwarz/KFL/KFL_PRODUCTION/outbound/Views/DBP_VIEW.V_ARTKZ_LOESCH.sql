CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_loesch AS SELECT loesch_id,
 mandant_id,
 spr_id,
 loesch_bez
FROM kfl_production_dbp_data.artkz_loesch;