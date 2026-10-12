CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t210_case_gtin_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c210_itemno STRING(18) NOT NULL,
c210_case_gtin STRING(14) NOT NULL,
c210_desc STRING(50) NOT NULL,
c210_order_gtin INTEGER NOT NULL,
c210_moduser STRING(20) NOT NULL,
c210_moddate DATETIME NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c210_case_gtin) NOT ENFORCED
);