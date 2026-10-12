CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_indicator_2 (
indicator_id BIGNUMERIC(38,0) NOT NULL,
indicator_desc STRING(200) COLLATE 'und:ci' NOT NULL,
indicator_valuetype STRING(15) COLLATE 'und:ci',
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);