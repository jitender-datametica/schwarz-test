CREATE TABLE IF NOT EXISTS szd_etl_process.t_etl_country_group_rel_1 (
country_business_cd STRING(50) NOT NULL,
country_group_name STRING(100) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_src_file_name STRING(500),
dwh_src_1_tmsp TIMESTAMP NOT NULL
);