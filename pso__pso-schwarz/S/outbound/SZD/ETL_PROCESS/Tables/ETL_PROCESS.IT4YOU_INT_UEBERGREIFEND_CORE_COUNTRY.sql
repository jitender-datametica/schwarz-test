CREATE TABLE IF NOT EXISTS szd_etl_process.it4you_int_uebergreifend_core_country (
active STRING(500),
iana STRING(500),
iso3166_2 STRING(500),
iso3166_3 STRING(500),
name STRING(500),
`_order` BIGNUMERIC(38,0),
population BIGNUMERIC(38,0),
sys_created_on TIMESTAMP,
sys_id STRING(500),
sys_mod_count BIGNUMERIC(38,0),
sys_updated_on TIMESTAMP,
un_numeric BIGNUMERIC(38,0),
dwh_src_file_name STRING(500),
dwh_extract_tmsp TIMESTAMP
);