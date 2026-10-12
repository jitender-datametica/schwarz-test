CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_wawi_currency_desc_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
currency_desc STRING(35) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);