CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.l_ginfo_grp_2 (
grp_id BIGNUMERIC(38,0) NOT NULL,
ebene_id BIGNUMERIC(38,0) NOT NULL,
grp_bez STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);