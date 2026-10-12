CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_umfrage_bereich_zu (
ber_id BIGNUMERIC(38,0) NOT NULL,
umfrage_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);