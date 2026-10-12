CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_supplierlocation_hist (
dispoid BIGNUMERIC(38,0) NOT NULL,
supplierlocationid BIGNUMERIC(38,0) NOT NULL,
supplierid BIGNUMERIC(38,0),
supplierlocationtypeid BIGNUMERIC(38,0),
gln STRING(250),
supplierlocationdesc STRING(250),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, supplierlocationid) NOT ENFORCED
);