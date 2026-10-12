CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_travelroutepos_hist_2 (
dispoid BIGNUMERIC(38,0) NOT NULL,
travelrouteposid BIGNUMERIC(38,0) NOT NULL,
travelrouteid BIGNUMERIC(38,0),
chargetypeid BIGNUMERIC(38,0),
precargoid BIGNUMERIC(38,0),
turnstile_precargo BIGNUMERIC(38,0),
precargo_turnstile BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, travelrouteposid) NOT ENFORCED
);