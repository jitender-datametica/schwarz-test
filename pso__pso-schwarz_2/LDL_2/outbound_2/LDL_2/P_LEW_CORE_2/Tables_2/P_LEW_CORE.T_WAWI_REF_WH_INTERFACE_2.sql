CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_wh_interface_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
system_key BIGNUMERIC(38,0) NOT NULL,
system_desc STRING(20) COLLATE 'und:ci' NOT NULL,
interface_key BIGNUMERIC(38,0) NOT NULL,
interface_desc STRING(100) COLLATE 'und:ci' NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);