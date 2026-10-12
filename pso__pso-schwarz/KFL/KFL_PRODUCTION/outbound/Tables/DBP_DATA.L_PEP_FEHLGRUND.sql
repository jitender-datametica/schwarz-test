CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_pep_fehlgrund (
idfehlgrund BIGNUMERIC(38,0) NOT NULL,
pep_fehlgrund_id BIGNUMERIC(38,0) NOT NULL,
pep_fehlgrund_bez_k STRING(3) COLLATE 'und:ci' NOT NULL,
pep_fehlgrund_bez_l STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);