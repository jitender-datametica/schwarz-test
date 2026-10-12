CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_planung_gik_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
psp_id BIGNUMERIC(38,0) NOT NULL,
gesamt_investitions_kosten NUMERIC(18,3) DEFAULT 0 NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);