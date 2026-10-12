CREATE OR REPLACE TABLE idq_production_kfl_pmr.dmf_ofr_exp_sts_1 (
mandt STRING(3) NOT NULL,
offer_id STRING(255) NOT NULL,
retail_event_id STRING(10),
export_status NUMERIC(2,0),
offer_status NUMERIC(2,0),
export_tstmp NUMERIC(16,0),
ppo_id STRING(255),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, offer_id) NOT ENFORCED
);