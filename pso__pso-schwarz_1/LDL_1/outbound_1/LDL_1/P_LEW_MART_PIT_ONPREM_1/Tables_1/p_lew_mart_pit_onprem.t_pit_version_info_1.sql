CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_version_info_1 (
version_dt DATE DEFAULT DATE '8888-12-31' NOT NULL,
dwh_valid_from DATE DEFAULT DATE '1900-12-31' NOT NULL,
dwh_valid_to DATE DEFAULT DATE '9999-12-31' NOT NULL,
major_number BIGNUMERIC(38,0),
minor_number BIGNUMERIC(38,0),
build_number BIGNUMERIC(38,0),
revision_number BIGNUMERIC(38,0),
version_info_descr STRING(16777216)
);