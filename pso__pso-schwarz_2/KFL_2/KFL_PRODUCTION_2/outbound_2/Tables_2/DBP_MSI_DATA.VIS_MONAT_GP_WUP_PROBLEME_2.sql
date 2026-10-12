CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_monat_gp_wup_probleme_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
problemcode_id STRING(7) COLLATE 'und:ci' NOT NULL,
anz_fehler BIGNUMERIC(38,0) NOT NULL,
anz_fehler_kum BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);