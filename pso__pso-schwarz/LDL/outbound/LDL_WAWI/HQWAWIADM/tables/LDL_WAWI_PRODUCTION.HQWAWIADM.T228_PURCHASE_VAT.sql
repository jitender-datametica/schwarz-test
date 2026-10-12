CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t228_purchase_vat (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c228_krednr STRING(7) NOT NULL,
c228_purchase_vat STRING(20) NOT NULL,
c228_mod_date DATETIME,
c228_mod_user STRING(8),
based_on_eks INTEGER,
c228_supp_category STRING(25),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c228_krednr, c228_purchase_vat) NOT ENFORCED
);