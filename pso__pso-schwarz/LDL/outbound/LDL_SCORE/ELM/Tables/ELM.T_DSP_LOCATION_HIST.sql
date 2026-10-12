CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_location_hist (
dispoid BIGNUMERIC(38,0) NOT NULL,
locationid BIGNUMERIC(38,0) NOT NULL,
parentid BIGNUMERIC(38,0),
locationtypeid BIGNUMERIC(38,0),
interno STRING(250),
locationshort STRING(250),
locationdesc STRING(250),
gln STRING(250),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, locationid) NOT ENFORCED
);