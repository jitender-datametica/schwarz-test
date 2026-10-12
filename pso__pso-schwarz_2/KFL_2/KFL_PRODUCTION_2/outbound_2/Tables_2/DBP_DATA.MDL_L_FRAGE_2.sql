CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_l_frage_2 (
frage_id BIGNUMERIC(38,0) NOT NULL,
mdl_frage_id STRING(100),
hauptfrage_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);