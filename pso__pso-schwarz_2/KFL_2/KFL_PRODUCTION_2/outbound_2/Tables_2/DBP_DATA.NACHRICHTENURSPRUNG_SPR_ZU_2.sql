CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nachrichtenursprung_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
nachrichtenursprung_id STRING(1) NOT NULL,
nachrichtenursprung_bez STRING(60),
td_update TIMESTAMP,
td_insert TIMESTAMP
);