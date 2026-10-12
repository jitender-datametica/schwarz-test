CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anlieferung_management_det (
mandant_id BIGNUMERIC(38,0) NOT NULL,
anlieferung_id STRING(20) COLLATE 'und:ci' NOT NULL,
best_beleg_id INTEGER NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
retoure_fg BIGNUMERIC(38,0) DEFAULT 0,
palettiert_fg BIGNUMERIC(38,0) DEFAULT 0,
werbung_fg BIGNUMERIC(38,0) DEFAULT 0,
menge_palette_ist BIGNUMERIC(38,0),
menge_palette_soll BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
gp_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);