CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_l_invers_kategorie_2 (
invers_kat_id BIGNUMERIC(38,0) NOT NULL,
umfrage_id BIGNUMERIC(38,0) NOT NULL,
invers_kat_sort BIGNUMERIC(38,0) DEFAULT 0,
td_insert TIMESTAMP,
td_update TIMESTAMP
);