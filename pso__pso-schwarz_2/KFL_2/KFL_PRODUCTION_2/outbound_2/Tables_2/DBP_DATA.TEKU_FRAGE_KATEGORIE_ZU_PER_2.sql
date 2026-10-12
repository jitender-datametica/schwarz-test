CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_frage_kategorie_zu_per_2 (
teku_frage_kat_zu_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
teku_kategorie_id BIGNUMERIC(38,0) NOT NULL,
teku_frage_id BIGNUMERIC(38,0) NOT NULL,
teku_frage_pos_id BIGNUMERIC(38,0) NOT NULL,
teku_frage_gewicht BIGNUMERIC(38,0) NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);