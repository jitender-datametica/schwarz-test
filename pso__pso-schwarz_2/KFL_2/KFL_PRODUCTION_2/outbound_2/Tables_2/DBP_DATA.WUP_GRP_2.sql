CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_grp_2 (
wupgrp_id BIGNUMERIC(38,0) NOT NULL,
wupgrp_bez STRING(40) COLLATE 'und:ci',
wupgrptyp_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);