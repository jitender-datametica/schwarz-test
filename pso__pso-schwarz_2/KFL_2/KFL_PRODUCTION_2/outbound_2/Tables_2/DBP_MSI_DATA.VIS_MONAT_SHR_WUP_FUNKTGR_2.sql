CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_monat_shr_wup_funktgr_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
shr_ma_funktion_gruppe_id BIGNUMERIC(38,0) NOT NULL,
kopf_gesamt NUMERIC(9,2) DEFAULT 0 NOT NULL,
kopf_eintritte NUMERIC(9,2) DEFAULT 0 NOT NULL,
kopf_austritte NUMERIC(9,2) DEFAULT 0 NOT NULL,
kopf_teilzeit NUMERIC(9,2) DEFAULT 0 NOT NULL,
kopf_austritte_bereinigt NUMERIC(9,2) DEFAULT 0 NOT NULL,
stunden_vertrag NUMERIC(9,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);