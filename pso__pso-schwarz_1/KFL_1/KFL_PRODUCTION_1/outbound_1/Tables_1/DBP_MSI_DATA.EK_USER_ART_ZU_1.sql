CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ek_user_art_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
user_id STRING(30) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);