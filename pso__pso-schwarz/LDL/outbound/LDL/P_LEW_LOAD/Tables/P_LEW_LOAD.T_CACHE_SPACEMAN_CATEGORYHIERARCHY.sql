CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_spaceman_categoryhierarchy (
section_group_level_1_nr BIGNUMERIC(38,0),
section_group_level_1_name STRING(200),
section_group_level_2_nr BIGNUMERIC(38,0),
section_group_level_2_name STRING(200),
section_group_level_3_nr BIGNUMERIC(38,0),
section_group_level_3_name STRING(200),
section_group_level_4_nr BIGNUMERIC(38,0),
section_group_level_4_name STRING(200),
section_group_level_5_nr BIGNUMERIC(38,0),
section_group_level_5_name STRING(200),
extraction_dt DATETIME,
deleted_fg BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_load_id BIGNUMERIC(38,0)
);