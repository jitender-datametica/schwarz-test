CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_psa_report_items_2 (
env_cd STRING(1) COLLATE 'und:ci' DEFAULT 'Z' NOT NULL,
report_id BIGNUMERIC(38,0) NOT NULL,
country_iso_cd STRING(2) COLLATE 'und:ci' NOT NULL,
nat_item_nr BIGNUMERIC(38,0) NOT NULL
);