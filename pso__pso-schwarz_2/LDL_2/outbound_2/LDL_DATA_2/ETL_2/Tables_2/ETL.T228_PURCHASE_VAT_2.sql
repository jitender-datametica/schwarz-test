CREATE TABLE IF NOT EXISTS ldl_data_etl.t228_purchase_vat_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c228_krednr STRING(7) NOT NULL,
c228_purchase_vat STRING(20) NOT NULL,
c228_mod_date DATETIME,
c228_mod_user STRING(8),
based_on_eks INTEGER,
c228_supp_category STRING(25),
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c228_krednr, c228_purchase_vat) NOT ENFORCED
);