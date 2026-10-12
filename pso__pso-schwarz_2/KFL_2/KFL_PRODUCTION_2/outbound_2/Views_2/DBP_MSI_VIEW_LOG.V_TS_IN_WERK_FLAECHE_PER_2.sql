CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.v_ts_in_werk_flaeche_per_2 AS SELECT mandant_id,
 werk_id,
 gebaeude_bez,
 gebaeudeteil_bez,
 flaeche_qm,
 dat_von,
 dat_bis
FROM kfl_production_dbp_msi_view_log.ts_in_werk_flaeche_per_2;