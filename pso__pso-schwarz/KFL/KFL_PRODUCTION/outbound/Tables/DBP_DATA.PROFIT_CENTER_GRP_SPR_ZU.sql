CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.profit_center_grp_spr_zu (
pc_grp_id STRING(100) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
pc_hiertyp_id BIGNUMERIC(38,0) NOT NULL,
pc_grp_bez STRING(60),
td_insert TIMESTAMP,
td_update TIMESTAMP
);