CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.buchungsschluessel_spr_zu_1 (
buchungsschluessel_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
buchungsschluessel_bez STRING(200) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);