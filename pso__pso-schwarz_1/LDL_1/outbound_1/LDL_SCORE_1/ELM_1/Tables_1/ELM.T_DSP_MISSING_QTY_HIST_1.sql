CREATE TABLE IF NOT EXISTS ldl_score_elm.t_dsp_missing_qty_hist_1 (
importid BIGNUMERIC(38,0) NOT NULL,
itempropid BIGNUMERIC(38,0) NOT NULL,
daywhid BIGNUMERIC(38,0) NOT NULL,
lorryno BIGNUMERIC(38,0) NOT NULL,
travelrouteid BIGNUMERIC(38,0) NOT NULL,
precargoid BIGNUMERIC(38,0) NOT NULL,
missingqty BIGNUMERIC(38,10),
reasonid BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (importid, daywhid, lorryno, itempropid, precargoid, travelrouteid) NOT ENFORCED
);