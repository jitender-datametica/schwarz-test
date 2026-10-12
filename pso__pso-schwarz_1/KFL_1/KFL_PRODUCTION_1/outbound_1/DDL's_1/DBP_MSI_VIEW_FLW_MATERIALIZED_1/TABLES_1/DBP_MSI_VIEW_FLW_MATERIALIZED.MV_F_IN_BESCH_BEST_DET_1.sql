CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_in_besch_best_det_1 (
mandant_id INTEGER,
best_beleg_id INTEGER,
best_beleg_pos_id INTEGER,
in_art_id INTEGER,
loesch_id STRING(1) COLLATE 'und:ci',
werk_id INTEGER,
menge_best_bme NUMERIC(29,3),
best_menge_einh_id STRING(3) COLLATE 'und:ci',
retourenpos_fg INTEGER,
dupli_fg INTEGER,
besch_pos_typ_id STRING(1) COLLATE 'und:ci',
nettopreis NUMERIC(29,4)
);