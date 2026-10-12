CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_systemstatus_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
systemstatus_id STRING(5) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
systemstatus_bez_kurz STRING(4) COLLATE 'und:ci',
systemstatus_bez STRING(30) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);