CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kunde_vkorg_vw_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
flw_kunde_id BIGNUMERIC(38,0) NOT NULL,
flw_verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL,
flw_vw_id BIGNUMERIC(38,0) NOT NULL,
versand_bedingung_id STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL,
dat_erfasst DATE NOT NULL,
loesch_fg BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);