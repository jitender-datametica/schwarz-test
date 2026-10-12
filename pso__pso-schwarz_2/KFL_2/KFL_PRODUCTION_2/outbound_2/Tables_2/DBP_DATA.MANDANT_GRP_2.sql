CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mandant_grp_2 (
mandantgrp_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mandant_grp_bez STRING(40) COLLATE 'und:ci',
mandant_grp_bez_kurz STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);