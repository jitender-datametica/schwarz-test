CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kunde_2 (
flw_kunde_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
kunde_nr STRING(10) COLLATE 'und:ci' NOT NULL,
kunde_name STRING(40) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
frueh_spaet_kz STRING(1) COLLATE 'und:ci' DEFAULT '0' NOT NULL,
wup_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
kunde_land STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL,
kunde_plz STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
kunde_ort STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);