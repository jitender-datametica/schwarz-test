CREATE TABLE IF NOT EXISTS ldl_score_elm.t_eks_type_trans_hist_2 (
transtypeid BIGNUMERIC(38,0) NOT NULL,
transtypeshort STRING(250),
transtypedesc STRING(250),
crdate DATE,
moddate DATE,
eksstatus BIGNUMERIC(38,0),
elmstatus BIGNUMERIC(38,0),
changedate DATE,
changeuser BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (transtypeid) NOT ENFORCED
);