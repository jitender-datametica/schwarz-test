CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_travelroute_hist_2 (
dispoid BIGNUMERIC(38,0) NOT NULL,
travelrouteid BIGNUMERIC(38,0) NOT NULL,
logisticrouteid BIGNUMERIC(38,0),
chargetypeid BIGNUMERIC(38,0),
travelrouteshort STRING(250),
travelroutedesc STRING(250),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, travelrouteid) NOT ENFORCED
);