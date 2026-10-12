CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_campaign_activity_type (
campaign_activity_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Campaign Activity Type Code'),
campaign_activity_type_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Campaign Activity Type Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);