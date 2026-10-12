CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_measureunit_hist_2 (
dispoid BIGNUMERIC(38,0) NOT NULL,
measureunitid BIGNUMERIC(38,0) NOT NULL,
measureunittypeid BIGNUMERIC(38,0),
measureunitshort STRING(250),
measureunitdesc STRING(250),
measureunitfactor BIGNUMERIC(38,20),
measureunitscale BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, measureunitid) NOT ENFORCED
);