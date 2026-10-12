CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_altersteilzeit_zu_per (mandant_id, atz_phase_id, mitarbeiter_id,
kjmo, dat_von, dat_bis) AS SELECT mandant_id,
 atz_phase_id,
 mitarbeiter_id,
 kjmo,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.ma_altersteilzeit_zu_per;