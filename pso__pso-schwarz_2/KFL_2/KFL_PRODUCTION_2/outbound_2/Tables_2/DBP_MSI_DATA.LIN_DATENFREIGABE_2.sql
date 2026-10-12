CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.lin_datenfreigabe_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
vertrieb_fg BIGNUMERIC(38,0) NOT NULL,
user_id STRING(30) COLLATE 'und:ci',
zeitstempel DATETIME,
lin_freigabe_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);