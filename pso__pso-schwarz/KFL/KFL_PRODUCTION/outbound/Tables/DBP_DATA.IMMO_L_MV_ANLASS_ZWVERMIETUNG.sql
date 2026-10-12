CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_mv_anlass_zwvermietung (
mandant_id BIGNUMERIC(38,0) NOT NULL,
anlass_zwvermietung_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
anlass_zwvermietung_bez STRING(50) DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);