CREATE OR REPLACE TABLE kfl_production_dbp_etl.ignore_aad_scenario_hit_delta (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
cashier_id STRING(255) NOT NULL,
bon_id STRING(100) NOT NULL,
extended_fg INTEGER DEFAULT 0 NOT NULL
);