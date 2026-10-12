CREATE TABLE IF NOT EXISTS ldl_score_elm.t_eks_sortingorder_hist (
sortingorderid BIGNUMERIC(38,0) NOT NULL,
position BIGNUMERIC(38,0),
locationid BIGNUMERIC(38,0),
competitorid BIGNUMERIC(38,0),
sortingtypeid BIGNUMERIC(38,0),
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
PRIMARY KEY (sortingorderid) NOT ENFORCED
);