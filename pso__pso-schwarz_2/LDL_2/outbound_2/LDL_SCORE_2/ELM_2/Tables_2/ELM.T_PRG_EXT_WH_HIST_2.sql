CREATE TABLE IF NOT EXISTS ldl_score_elm.t_prg_ext_wh_hist_2 (
ext_wh_id BIGNUMERIC(38,0) NOT NULL,
warehouse_id BIGNUMERIC(38,0),
interno STRING(250),
ext_wh_short STRING(250),
ext_wh_desc STRING(250),
ext_wh_zipcode STRING(250),
ext_wh_city STRING(250),
crdate DATE,
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (ext_wh_id) NOT ENFORCED
);