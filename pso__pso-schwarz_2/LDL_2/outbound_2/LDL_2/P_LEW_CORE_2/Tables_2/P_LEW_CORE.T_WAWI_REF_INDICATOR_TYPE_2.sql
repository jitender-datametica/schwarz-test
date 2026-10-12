CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_indicator_type_2 (
indicator_type_id BIGNUMERIC(38,0) NOT NULL,
indicator_type_desc STRING(100) COLLATE 'und:ci' NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);