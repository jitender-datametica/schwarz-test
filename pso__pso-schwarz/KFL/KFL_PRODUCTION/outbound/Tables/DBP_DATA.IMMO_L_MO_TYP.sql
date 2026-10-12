CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_mo_typ (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mo_typ_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
mo_typ_bez STRING(30),
td_insert TIMESTAMP,
td_update TIMESTAMP
);