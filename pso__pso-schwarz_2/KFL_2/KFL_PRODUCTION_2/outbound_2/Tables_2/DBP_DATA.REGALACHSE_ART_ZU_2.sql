CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.regalachse_art_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
regalachse_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
fachboden_nr BIGNUMERIC(38,0) NOT NULL,
fachboden_pos BIGNUMERIC(38,0) NOT NULL,
regional_kz BIGNUMERIC(38,0) NOT NULL,
kapazitaet NUMERIC(18,3) NOT NULL,
kapazitaet_menge_einh_id STRING(3) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);