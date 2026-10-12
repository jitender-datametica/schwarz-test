CREATE OR REPLACE VIEW kfl_production_dbp_view.v_teku_einsatz_2 AS SELECT teku_einsatz_id,
 teku_tour_id,
 testkunde_id,
 dat_soll,
 dat_korr,
 dat_ist,
 storno_fg
FROM kfl_production_dbp_data.teku_einsatz_2;