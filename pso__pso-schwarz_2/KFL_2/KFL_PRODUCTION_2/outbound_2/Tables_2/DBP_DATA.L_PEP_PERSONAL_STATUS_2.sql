CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_pep_personal_status_2 (
idmastatus BIGNUMERIC(38,0) NOT NULL,
personal_status_bez_k STRING(10) COLLATE 'und:ci',
personal_status_bez_l STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);