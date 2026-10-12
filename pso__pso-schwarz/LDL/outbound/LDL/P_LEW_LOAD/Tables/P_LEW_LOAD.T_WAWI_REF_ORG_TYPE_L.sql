CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_ref_org_type_l (
org_type_id BIGNUMERIC(38) NOT NULL,
org_type_desc STRING(100) COLLATE 'und:ci' NOT NULL,
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);