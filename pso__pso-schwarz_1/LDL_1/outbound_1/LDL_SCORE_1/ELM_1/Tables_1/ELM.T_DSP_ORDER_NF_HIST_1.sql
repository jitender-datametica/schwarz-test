CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_order_nf_hist_1 (
dispoid BIGNUMERIC(38,0),
itempropid BIGNUMERIC(38,0),
daywhid BIGNUMERIC(38,0),
versionid BIGNUMERIC(38,0),
locationshort STRING(100),
locationid BIGNUMERIC(38,0),
dayturnstileid BIGNUMERIC(38,0),
colli_targetqty BIGNUMERIC(38,0),
orderquantity BIGNUMERIC(38,0),
corrtypeid BIGNUMERIC(38,0),
direct_delivery_flag BIGNUMERIC(38,0),
additionalcharge_flag BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);