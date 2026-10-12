CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_pit_version_info (
version_dt DATE NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
major_number BIGNUMERIC(38,0),
minor_number BIGNUMERIC(38,0),
build_number BIGNUMERIC(38,0),
revision_number BIGNUMERIC(38,0),
version_info_descr STRING(500) COLLATE 'und:ci'
);