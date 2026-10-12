CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ptm_workingtype (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
workingtype_id STRING(5) COLLATE 'und:ci' NOT NULL,
workingtype_short_desc STRING(10) COLLATE 'und:ci' NOT NULL,
workingtype_desc STRING(50) COLLATE 'und:ci',
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);