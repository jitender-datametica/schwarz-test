CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_campaign_element_relation_hist (
client_id INTEGER NOT NULL,
campaign_elem_sid INTEGER NOT NULL OPTIONS(description='Campaign Element Sid'),
campaign_elem_sid_rel INTEGER NOT NULL OPTIONS(description='Campaign Element Sid Related'),
campaign_elem_rel_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Campaign Element Relation Type Code'),
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, campaign_elem_sid, campaign_elem_sid_rel, dwh_valid_from) NOT ENFORCED
);