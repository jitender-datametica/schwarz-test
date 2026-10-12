CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_currency_hist (
dispoid BIGNUMERIC(38,0) NOT NULL,
currencyid BIGNUMERIC(38,0) NOT NULL,
visibleflag BIGNUMERIC(38,0),
isonum STRING(250),
isochar STRING(250),
description STRING(250),
uppersign STRING(250),
lowersign STRING(250),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, currencyid) NOT ENFORCED
);