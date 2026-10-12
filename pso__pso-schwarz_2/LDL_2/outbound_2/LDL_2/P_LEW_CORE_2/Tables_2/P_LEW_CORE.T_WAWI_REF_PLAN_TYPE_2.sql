CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_plan_type_2 (
plantype_id BIGNUMERIC(38,0) NOT NULL,
plantype_desc STRING(100) COLLATE 'und:ci' NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38,0) NOT NULL
);