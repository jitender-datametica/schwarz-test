CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpw_l_belastungsart_vd_2 (
belastungsart_vd_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
belastungsart_vd_bez STRING(30) DEFAULT '-1' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);