CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_geographical_area_relation_hist (
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geographical Area SID'),
geo_area_type_cd STRING(7) COLLATE 'und:ci' NOT NULL OPTIONS(description='Geographical Area Type Code'),
geo_area_cd STRING(5) COLLATE 'und:ci' NOT NULL OPTIONS(description='Geographical Area Code'),
geo_area_rel_type_cd STRING(5) COLLATE 'und:ci' NOT NULL OPTIONS(description='Geographical Area Relation Type Code'),
rel_geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Related Geographical Area SID'),
rel_geo_area_type_cd STRING(7) COLLATE 'und:ci' NOT NULL OPTIONS(description='Related Geographical Area Type Code'),
rel_geo_area_cd STRING(5) COLLATE 'und:ci' NOT NULL OPTIONS(description='Related Geographical Area Code'),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (geo_area_sid, rel_geo_area_sid, dwh_valid_from) NOT ENFORCED
);