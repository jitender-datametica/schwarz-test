CREATE TABLE IF NOT EXISTS ldl_score_elm.t_eks_type_measureunit_hist_1 (
measureunittypeid BIGNUMERIC(38,0) NOT NULL,
measureunittypeshort STRING(250),
measureunittypedesc STRING(250),
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
PRIMARY KEY (measureunittypeid) NOT ENFORCED
);