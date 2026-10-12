CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_puk_monat_kommentar_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
kennzahl_id BIGNUMERIC(38,0) NOT NULL,
puk_typ_id BIGNUMERIC(38,0) NOT NULL,
puk_id BIGNUMERIC(38,0) NOT NULL,
puk_parent_id BIGNUMERIC(38,0) NOT NULL,
ursache_kjmo STRING(2000) COLLATE 'und:ci',
massnahme_kjmo STRING(2000) COLLATE 'und:ci',
zeit_aktualisierung DATETIME NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);