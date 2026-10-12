CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.werbe_typ_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
werbe_typ_id BIGNUMERIC(38,0) NOT NULL,
werbe_typ_bez STRING(30) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);