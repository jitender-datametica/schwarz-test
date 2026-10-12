CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pc_pc_grp_zu_2 (
pc_id STRING(10) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
pc_grp_id STRING(100) COLLATE 'und:ci' NOT NULL,
pc_hiertyp_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);