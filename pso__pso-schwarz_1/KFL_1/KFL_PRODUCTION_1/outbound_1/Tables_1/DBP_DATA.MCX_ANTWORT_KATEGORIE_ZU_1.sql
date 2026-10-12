CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_antwort_kategorie_zu_1 (
antwort_id BIGNUMERIC(38,0) NOT NULL,
umfrage_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
kat_id BIGNUMERIC(38,0) NOT NULL,
gesamt_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);