CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_unter_kategorie (
kmr_unter_kategorie_id BIGNUMERIC(38,0) NOT NULL,
kmr_kategorie_id BIGNUMERIC(38,0),
kmr_teilbereich_uk_id BIGNUMERIC(38,0),
kmr_count_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
uk_sw NUMERIC(9,4) DEFAULT 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);