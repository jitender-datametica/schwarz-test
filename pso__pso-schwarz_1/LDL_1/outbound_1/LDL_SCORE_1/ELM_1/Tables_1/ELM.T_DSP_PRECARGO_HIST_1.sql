CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_precargo_hist_1 (
dispoid BIGNUMERIC(38,0) NOT NULL,
precargoid BIGNUMERIC(38,0) NOT NULL,
logistictypeid BIGNUMERIC(38,0),
loadlocationid BIGNUMERIC(38,0),
supplierid BIGNUMERIC(38,0),
unloadlocationid BIGNUMERIC(38,0),
precargodesc STRING(250),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, precargoid) NOT ENFORCED
);