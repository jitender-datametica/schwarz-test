CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.auftrag_grund_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
auftrag_grund_id STRING(3),
auftrag_grund_bez STRING(40),
td_update TIMESTAMP,
td_insert TIMESTAMP
);