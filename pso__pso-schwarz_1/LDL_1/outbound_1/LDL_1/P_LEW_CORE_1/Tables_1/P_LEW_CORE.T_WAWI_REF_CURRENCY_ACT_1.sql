CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_currency_act_1 (
country_id BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
currency_desc STRING(3) COLLATE 'und:ci' NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
to_currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
rate_currency_exchange NUMERIC(18,4)
);