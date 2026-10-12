CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gfk_hhp_wug (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gfk_wg_id BIGNUMERIC(38,0) NOT NULL,
gfk_wug_id BIGNUMERIC(38,0) NOT NULL,
gfk_wug_bez STRING(400) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);