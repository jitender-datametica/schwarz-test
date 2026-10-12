CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_type_pallet_hist_1 (
dispoid BIGNUMERIC(38,0) NOT NULL,
pallettypeid BIGNUMERIC(38,0) NOT NULL,
pallettypeshort STRING(250),
pallettypedesc STRING(250),
pallettypefactor BIGNUMERIC(38,10),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, pallettypeid) NOT ENFORCED
);