CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktion_wme_ame_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
aktionsart_id STRING(4) COLLATE 'und:ci' NOT NULL,
zusatzinfo STRING(40) COLLATE 'und:ci',
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);