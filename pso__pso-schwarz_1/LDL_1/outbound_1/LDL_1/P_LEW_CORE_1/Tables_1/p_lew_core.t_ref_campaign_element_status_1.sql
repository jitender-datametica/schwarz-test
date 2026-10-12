CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_campaign_element_status_1 (
campaign_elem_status_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Campaign Element Status_1 Code'),
campaign_elem_status_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Campaign Element Status_1 Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);