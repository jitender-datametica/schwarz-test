CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods_archiv.ods_bon_segment_2 (
bon_id STRING(25) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
segment_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);