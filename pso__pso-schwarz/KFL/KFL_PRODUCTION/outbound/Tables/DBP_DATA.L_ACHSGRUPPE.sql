CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_achsgruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL,
achsgruppe_id BIGNUMERIC(38,0) NOT NULL,
produktgruppe_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);