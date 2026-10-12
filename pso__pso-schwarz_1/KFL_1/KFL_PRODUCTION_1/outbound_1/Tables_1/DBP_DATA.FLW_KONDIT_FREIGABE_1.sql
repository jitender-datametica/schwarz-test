CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kondit_freigabe_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
flw_verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL,
flw_vw_id BIGNUMERIC(38,0) NOT NULL,
flw_art_id BIGNUMERIC(38,0) NOT NULL,
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL,
applikation_id STRING(2) COLLATE 'und:ci' NOT NULL,
preisliste_typ_id STRING(2) COLLATE 'und:ci' NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
freigabe_status_id STRING(1) COLLATE 'und:ci' NOT NULL,
dat_bis DATE NOT NULL,
dat_von DATE NOT NULL,
kondition_id INTEGER,
bearbeitung_status_id STRING(2) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);