CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.kassierer_decoded (
kassierer_id BIGNUMERIC(38,0) NOT NULL,
timestamp_dec DATETIME NOT NULL,
user_decoding STRING(30) COLLATE 'und:ci' NOT NULL,
encode_fg BIGNUMERIC(38,0) DEFAULT 0,
td_insert TIMESTAMP,
td_update TIMESTAMP
);