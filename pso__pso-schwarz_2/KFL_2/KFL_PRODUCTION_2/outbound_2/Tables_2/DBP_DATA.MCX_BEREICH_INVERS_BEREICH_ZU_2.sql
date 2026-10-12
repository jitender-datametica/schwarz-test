CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_bereich_invers_bereich_zu_2 (
ber_id BIGNUMERIC(38,0) NOT NULL,
invers_ber_id BIGNUMERIC(38,0) NOT NULL,
umfrage_id BIGNUMERIC(38,0) NOT NULL,
filter_fg BIGNUMERIC(38,0) NOT NULL,
ber_sort BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);