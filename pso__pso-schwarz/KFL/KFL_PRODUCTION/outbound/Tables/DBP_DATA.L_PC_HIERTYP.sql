CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_pc_hiertyp (
pc_hiertyp_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0),
system_id BIGNUMERIC(38,0),
pc_hiertyp_bez STRING(50),
td_insert TIMESTAMP,
td_update TIMESTAMP
);