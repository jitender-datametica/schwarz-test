CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_lc_prtcl_context_tasks_1 (
context_load_id INTEGER NOT NULL,
context_country_cd STRING(3) COLLATE 'und:ci' NOT NULL,
context_area_type STRING(30) COLLATE 'und:ci' DEFAULT '@' NOT NULL,
cluster_type STRING(30) COLLATE 'und:ci' DEFAULT '@' NOT NULL,
processcontainer STRING(300) COLLATE 'und:ci' NOT NULL,
stager_plan_state STRING(30) COLLATE 'und:ci' DEFAULT 'locked' NOT NULL,
loader_plan_state STRING(30) COLLATE 'und:ci' DEFAULT 'free' NOT NULL,
success_state STRING(50) COLLATE 'und:ci' DEFAULT 'raw' NOT NULL,
created_ts DATETIME NOT NULL,
updated_ts DATETIME NOT NULL
);