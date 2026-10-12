CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_partner_2 (
partner_id STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
anrede STRING(4) COLLATE 'und:ci' NOT NULL,
vorname STRING(80) COLLATE 'und:ci' NOT NULL,
nachname STRING(80) COLLATE 'und:ci' NOT NULL,
gebiet_id BIGNUMERIC(38,0) DEFAULT 0,
verbund_kz STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
strasse STRING(60) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
haus_nr STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
plz STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
ort STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
land_2 STRING(3) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);