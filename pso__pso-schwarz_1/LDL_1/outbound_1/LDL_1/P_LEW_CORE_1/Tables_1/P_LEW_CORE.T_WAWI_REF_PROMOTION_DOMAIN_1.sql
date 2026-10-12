CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_promotion_domain_1 (
orig_promotion_domain_nr BIGNUMERIC(38,0) NOT NULL,
orig_promotion_domain_sh_desc STRING(40) COLLATE 'und:ci' NOT NULL,
orig_promotion_domain_desc STRING(80) COLLATE 'und:ci' NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
timestamp_load DATETIME NOT NULL
);