CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_mietauftrag_spr_zu_2 (
mietauftrag_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
mietauftrag_bez STRING(40),
td_insert TIMESTAMP,
td_update TIMESTAMP
);