CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_vw (
vw_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0),
vk_id BIGNUMERIC(38,0),
vw_bez STRING(40) COLLATE 'und:ci',
vwvt_bez STRING(40) COLLATE 'und:ci',
vwart_id BIGNUMERIC(38,0) NOT NULL,
sap_vw_id STRING(2) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);