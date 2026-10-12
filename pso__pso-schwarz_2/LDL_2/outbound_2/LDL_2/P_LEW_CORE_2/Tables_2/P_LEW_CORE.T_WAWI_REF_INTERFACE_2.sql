CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_interface_2 (
system_key BIGNUMERIC(38,0) NOT NULL,
interface_key BIGNUMERIC(38,0) NOT NULL,
process_name STRING(30) COLLATE 'und:ci' NOT NULL,
comment_string STRING(100) COLLATE 'und:ci' NOT NULL,
dat_lastedit DATE NOT NULL,
user_lastedit STRING(30) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);