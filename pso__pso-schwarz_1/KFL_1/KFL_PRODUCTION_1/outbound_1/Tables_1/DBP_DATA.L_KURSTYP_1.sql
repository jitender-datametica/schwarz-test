CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_kurstyp_1 (
kurstyp_id BIGNUMERIC(38,0) NOT NULL,
sap_kurstyp_id STRING(4) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);