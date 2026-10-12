CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.arteancodes (
artikelnr STRING(18) NOT NULL,
eancode STRING(13) NOT NULL,
datum DATETIME,
bediener STRING(8),
eancodebeschr STRING(30),
based_on_eks INTEGER,
cust_tar_no STRING(20),
cust_key STRING(10),
online_desc STRING(80),
scn INTEGER DEFAULT 0,
ebt_flag INTEGER,
pcc STRING(6),
plu_gtin INTEGER NOT NULL,
no_gtin_check INTEGER NOT NULL,
sales_limit INTEGER,
self_scanning_flag INTEGER,
PRIMARY KEY (artikelnr, eancode) NOT ENFORCED
);