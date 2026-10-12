CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_herkunft_verfolgung_2 AS SELECT mandant_id,
 werk_id,
 aenderung_id,
 datzeit_erstellung,
 dat_produktion,
 alt_identifikation_id,
 neu_identifikation_id,
 alt_wechsel_id,
 neu_wechsel_id
FROM kfl_production_dbp_data.flw_herkunft_verfolgung_2;