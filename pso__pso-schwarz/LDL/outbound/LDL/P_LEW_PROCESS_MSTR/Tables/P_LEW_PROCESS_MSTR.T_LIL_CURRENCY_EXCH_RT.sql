CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_currency_exch_rt (
from_currency_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
to_currency_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
rate_currency_exchange BIGNUMERIC(38,18) NOT NULL
);