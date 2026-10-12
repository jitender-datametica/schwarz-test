CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_country (
client_id BIGNUMERIC(38,0),
country_iso STRING(20),
country_name STRING(100) COLLATE 'und:ci',
lang_sid BIGNUMERIC(38,0),
lang_cd STRING(20),
country_cluster_id BIGNUMERIC(38,0),
country_cluster_name STRING(40),
timestamp_load_bcbi TIMESTAMP
);