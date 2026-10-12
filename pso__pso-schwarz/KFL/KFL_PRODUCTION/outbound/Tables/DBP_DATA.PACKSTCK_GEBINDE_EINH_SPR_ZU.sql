CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.packstck_gebinde_einh_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
packstueck_gebinde_einh_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
packstueck_gebinde_einh_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);