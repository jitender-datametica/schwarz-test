CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.autodispo_dif_tag_1 (
mandant_id INTEGER NOT NULL,
kunde_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
dat DATE NOT NULL,
dat_ausfuehrung DATE NOT NULL,
dif_typ_id INTEGER NOT NULL,
dif_status_id INTEGER,
dif_wert NUMERIC(18,3),
dif_kommentar STRING(100) COLLATE 'und:ci',
sap_returncode STRING(255) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);