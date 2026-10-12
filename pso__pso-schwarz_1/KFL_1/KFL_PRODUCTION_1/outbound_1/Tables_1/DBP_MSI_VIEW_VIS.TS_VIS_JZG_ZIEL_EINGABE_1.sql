CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_vis.ts_vis_jzg_ziel_eingabe_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
metrik_id BIGNUMERIC(38,0) NOT NULL,
typ_id BIGNUMERIC(38,0) NOT NULL,
level_id BIGNUMERIC(38,0) NOT NULL,
wert_eingabe BIGNUMERIC(38,16) DEFAULT NULL,
kommentar_eingabe STRING(16777216) DEFAULT '',
zeitstempel DATETIME NOT NULL
);