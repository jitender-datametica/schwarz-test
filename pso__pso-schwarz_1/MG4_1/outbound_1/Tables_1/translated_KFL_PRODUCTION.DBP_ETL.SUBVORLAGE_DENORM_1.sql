CREATE OR REPLACE TABLE kfl_production_dbp_etl.subvorlage_denorm_1 (
nachricht_vorlage_id STRING(100) NOT NULL,
nachricht_subvorlage_txt STRING(4000),
nachricht_subvorlage_id INTEGER NOT NULL,
nachricht_subvorlage_name STRING(100),
td_update TIMESTAMP,
td_insert TIMESTAMP,
PRIMARY KEY (nachricht_vorlage_id, nachricht_subvorlage_id) NOT ENFORCED
);