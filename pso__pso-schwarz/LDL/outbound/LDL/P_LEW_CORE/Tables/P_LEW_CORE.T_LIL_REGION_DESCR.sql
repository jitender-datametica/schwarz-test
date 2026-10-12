--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_region_descr (
client_id BIGNUMERIC(38,0) NOT NULL,
region_sid BIGNUMERIC(38,0) NOT NULL,
lang_cd STRING COLLATE 'und:ci' NOT NULL,
region_name STRING(100) COLLATE 'und:ci',
region_long_descr STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (region_sid) NOT ENFORCED
) CLUSTER BY client_id;