CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_logisticcategory_hist (
dispoid BIGNUMERIC(38,0) NOT NULL,
logisticcategoryid BIGNUMERIC(38,0) NOT NULL,
logistictypeid BIGNUMERIC(38,0),
logisticcategoryshort STRING(250),
logisticcategorydesc STRING(250),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, logisticcategoryid) NOT ENFORCED
);