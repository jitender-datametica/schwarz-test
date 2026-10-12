CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_dayturnstile_hist (
dispoid BIGNUMERIC(38,0) NOT NULL,
dayturnstileid BIGNUMERIC(38,0) NOT NULL,
orderdayid BIGNUMERIC(38,0),
day_from DATE,
day_until DATE,
parentid BIGNUMERIC(38,0),
dayname STRING(250),
elmstatus BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
daylocked BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (dispoid, dayturnstileid) NOT ENFORCED
);