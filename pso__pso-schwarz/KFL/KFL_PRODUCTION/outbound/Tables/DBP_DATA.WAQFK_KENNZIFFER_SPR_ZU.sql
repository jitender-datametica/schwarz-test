CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.waqfk_kennziffer_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
waqfk_fehler_id BIGNUMERIC(38,0) NOT NULL,
waqfk_kennziffer_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
waqfk_kennziffer_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);