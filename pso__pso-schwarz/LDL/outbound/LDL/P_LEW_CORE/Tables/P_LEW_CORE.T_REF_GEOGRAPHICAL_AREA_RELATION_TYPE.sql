CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_geographical_area_relation_type (
geo_area_rel_type_cd STRING(5) COLLATE 'und:ci' NOT NULL OPTIONS(description='Geographical Area Relation Type Code'),
geo_area_rel_type_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Geographical Area Relation Type Description'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);