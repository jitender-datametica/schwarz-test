CREATE TABLE IF NOT EXISTS ldl_score_elm.t_eks_type_supplierlocation_hist (
supplierlocationtypeid BIGNUMERIC(38,0) NOT NULL,
supplierlocationtypeshort STRING(250),
supplierlocationtypedesc STRING(250),
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
PRIMARY KEY (supplierlocationtypeid) NOT ENFORCED
);