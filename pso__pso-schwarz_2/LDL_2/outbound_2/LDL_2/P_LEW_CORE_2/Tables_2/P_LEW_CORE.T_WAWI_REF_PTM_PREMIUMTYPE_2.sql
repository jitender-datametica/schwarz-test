CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ptm_premiumtype_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
premiumtype_id BIGNUMERIC(38,0) NOT NULL,
premiumtype_short_desc STRING(4) COLLATE 'und:ci' NOT NULL,
premiumtype_desc STRING(40) COLLATE 'und:ci',
premiumtype_cd BIGNUMERIC(38,0),
sap_cd BIGNUMERIC(38,0) NOT NULL,
export_to_sap_fg BIGNUMERIC(38,0) NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);