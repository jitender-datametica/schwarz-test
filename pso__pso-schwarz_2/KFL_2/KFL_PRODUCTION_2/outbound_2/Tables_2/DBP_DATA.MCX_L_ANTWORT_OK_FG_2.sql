CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_l_antwort_ok_fg_2 (
antwort_id BIGNUMERIC(38,0) NOT NULL,
umfrage_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
ok_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);