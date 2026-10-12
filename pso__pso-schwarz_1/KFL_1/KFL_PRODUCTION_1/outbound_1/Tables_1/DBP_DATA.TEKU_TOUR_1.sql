CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_tour_1 (
teku_tour_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
teku_tour_bez STRING(150) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);