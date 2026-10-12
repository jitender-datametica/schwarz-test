CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_geographical_area_1 (
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geographical Area SID'),
geo_area_type_cd STRING(7) COLLATE 'und:ci' NOT NULL OPTIONS(description='Geographical Area Type Code'),
geo_area_cd STRING(5) COLLATE 'und:ci' NOT NULL OPTIONS(description='Geographical Area Code'),
geo_area_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Geographical Area Name'),
geo_area_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Geographical Area Description'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (geo_area_sid) NOT ENFORCED
);