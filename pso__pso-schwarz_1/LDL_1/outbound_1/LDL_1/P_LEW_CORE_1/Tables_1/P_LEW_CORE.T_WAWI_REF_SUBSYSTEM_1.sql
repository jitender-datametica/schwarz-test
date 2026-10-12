CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_subsystem_1 (
system_key BIGNUMERIC(38,0) NOT NULL,
system_desc STRING(20) COLLATE 'und:ci',
dat_lastedit DATE NOT NULL,
user_lastedit STRING(30) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);