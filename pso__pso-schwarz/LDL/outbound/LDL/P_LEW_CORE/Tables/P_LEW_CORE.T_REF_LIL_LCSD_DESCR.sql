--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_lil_lcsd_descr (
lcsd_id BIGNUMERIC(38,0) NOT NULL,
lang_cd STRING COLLATE 'und:ci' NOT NULL,
lcsd_descr STRING(100) COLLATE 'und:ci',
lcsd_short_descr STRING(100) COLLATE 'und:ci',
lcsd_explain STRING(300) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (lcsd_id) NOT ENFORCED
);