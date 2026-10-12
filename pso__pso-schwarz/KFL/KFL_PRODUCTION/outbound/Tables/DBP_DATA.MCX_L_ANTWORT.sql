CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_l_antwort (
antwort_id BIGNUMERIC(38,0) NOT NULL,
umfrage_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
frage_id BIGNUMERIC(38,0) NOT NULL,
scale_id BIGNUMERIC(38,0) NOT NULL,
antwort_gewichtung BIGNUMERIC(38,0) NOT NULL,
datzeit_aend DATETIME NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);