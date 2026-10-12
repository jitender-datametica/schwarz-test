CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_transport_gv (
mandant_id BIGNUMERIC(38,0) NOT NULL,
transport_gv_id BIGNUMERIC(38,0) NOT NULL,
abrechnung_basiseinheit_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);