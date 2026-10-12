CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_l_frage_1 (
frage_id BIGNUMERIC(38,0) NOT NULL,
umfrage_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
frage_ex_typ BIGNUMERIC(38,0) NOT NULL,
frage_status BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);