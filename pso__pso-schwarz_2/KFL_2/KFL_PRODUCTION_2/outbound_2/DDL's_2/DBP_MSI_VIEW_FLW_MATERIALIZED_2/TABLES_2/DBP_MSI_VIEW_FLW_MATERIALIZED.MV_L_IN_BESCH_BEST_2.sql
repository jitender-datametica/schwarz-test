CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_besch_best_2 (
mandant_id INTEGER,
best_beleg_id INTEGER,
in_lief_id INTEGER,
bestellart_id STRING(4) COLLATE 'und:ci',
bestell_typ_id STRING(1) COLLATE 'und:ci',
artikelart_id STRING(4) COLLATE 'und:ci',
abweichung_fg INTEGER,
einkaufsorganisation_id INTEGER
);