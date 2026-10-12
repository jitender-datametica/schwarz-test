CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_standort_typ_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
standort_typ_id BIGNUMERIC(38,0) NOT NULL,
standort_typ_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);