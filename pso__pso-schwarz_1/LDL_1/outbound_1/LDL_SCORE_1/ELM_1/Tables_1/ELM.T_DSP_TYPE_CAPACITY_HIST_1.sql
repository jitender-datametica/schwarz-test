CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_type_capacity_hist_1 (
dispoid BIGNUMERIC(38,0) NOT NULL,
transtypecapacityid BIGNUMERIC(38,0) NOT NULL,
transtypeid BIGNUMERIC(38,0),
transtypecapacityshort STRING(250),
transtypecapacitydesc STRING(250),
transtypecapacitycapacity BIGNUMERIC(38,0),
measureunitid BIGNUMERIC(38,0),
palettcount BIGNUMERIC(38,0),
pallettypeid BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, transtypecapacityid) NOT ENFORCED
);