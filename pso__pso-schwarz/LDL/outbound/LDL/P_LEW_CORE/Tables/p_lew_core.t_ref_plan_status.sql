CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_plan_status (
plan_status_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Plan Status Code'),
plan_status_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Plan Status Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);