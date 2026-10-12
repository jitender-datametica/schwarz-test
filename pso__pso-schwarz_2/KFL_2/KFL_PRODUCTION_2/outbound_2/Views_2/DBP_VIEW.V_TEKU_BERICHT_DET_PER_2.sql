CREATE OR REPLACE VIEW kfl_production_dbp_view.v_teku_bericht_det_per_2 AS SELECT teku_antwort_id,
 dat_von,
 dat_bis,
 teku_antwort_note,
 teku_antwort_bez,
 teku_bericht_id,
 teku_fragestellung_id
FROM kfl_production_dbp_data.teku_bericht_det_per_2;