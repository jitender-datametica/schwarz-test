CREATE OR REPLACE VIEW kfl_production_dbp_view.v_teku_testkunde AS SELECT testkunde_id,
 mandant_id,
 testkunde_name,
 testkunde_vorname,
 testkunde_anrede,
 testkunde_funktion,
 testkunde_dat_bis
FROM kfl_production_dbp_data.teku_testkunde;