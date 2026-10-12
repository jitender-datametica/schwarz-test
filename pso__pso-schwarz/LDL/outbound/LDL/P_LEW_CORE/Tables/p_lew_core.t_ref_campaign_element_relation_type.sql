CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_campaign_element_relation_type (
campaign_elem_rel_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Campaign Element Relation Type Code'),
campaign_elem_rel_type_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Campaign Element Relation Type Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);