CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_type_package_hist_1 (
dispoid BIGNUMERIC(38,0) NOT NULL,
packagetypeid BIGNUMERIC(38,0) NOT NULL,
packagetypeshort STRING(250),
packagetypedesc STRING(250),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, packagetypeid) NOT ENFORCED
);