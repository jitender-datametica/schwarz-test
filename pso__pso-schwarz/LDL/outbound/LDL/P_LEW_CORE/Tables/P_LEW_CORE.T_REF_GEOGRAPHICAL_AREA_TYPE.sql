CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_geographical_area_type (
geo_area_type_cd STRING(7) COLLATE 'und:ci' NOT NULL OPTIONS(description='Geographical Area Type Code'),
geo_area_type_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Geographical Area Type Description'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);