CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_objectstatus_desc (
objectstatus_id BIGNUMERIC(38,0) NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
objectstatus_desc STRING(100) COLLATE 'und:ci' NOT NULL,
dat_lastedit DATE NOT NULL,
user_lastedit STRING(30) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);