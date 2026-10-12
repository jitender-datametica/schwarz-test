CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.mis_lieferquote (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lieferquote NUMERIC(9,2) NOT NULL,
datenquote NUMERIC(9,2) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);