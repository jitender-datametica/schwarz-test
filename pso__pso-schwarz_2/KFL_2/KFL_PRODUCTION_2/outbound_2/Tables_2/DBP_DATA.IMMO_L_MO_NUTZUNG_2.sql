CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_mo_nutzung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mo_nutzung_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);