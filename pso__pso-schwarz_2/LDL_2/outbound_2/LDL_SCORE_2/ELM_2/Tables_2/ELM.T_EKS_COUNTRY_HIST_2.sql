CREATE TABLE IF NOT EXISTS ldl_score_elm.t_eks_country_hist_2 (
countryid INTEGER NOT NULL,
countrycode STRING(2) NOT NULL,
description STRING(80) NOT NULL,
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (countryid) NOT ENFORCED
);