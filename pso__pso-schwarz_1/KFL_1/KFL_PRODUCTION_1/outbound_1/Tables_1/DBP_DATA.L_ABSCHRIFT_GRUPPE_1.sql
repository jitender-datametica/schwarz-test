CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_abschrift_gruppe_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
abschriftgruppe_id BIGNUMERIC(38,0) NOT NULL,
abschriftgrp_hierarchie STRING(20) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);