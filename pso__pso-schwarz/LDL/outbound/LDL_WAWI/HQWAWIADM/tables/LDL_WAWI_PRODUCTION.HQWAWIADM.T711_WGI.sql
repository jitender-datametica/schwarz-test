CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t711_wgi (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c711_wgi_id INTEGER NOT NULL,
c711_nat_wgi_id INTEGER NOT NULL,
c711_item_group INTEGER NOT NULL,
c711_date_from DATETIME NOT NULL,
c711_date_to DATETIME NOT NULL,
c711_version INTEGER NOT NULL,
c711_int_desc STRING(35) NOT NULL,
c711_nat_desc STRING(35),
c711_remarks STRING(60),
c711_moduser STRING(8),
c711_moddate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c711_wgi_id, c711_nat_wgi_id, c711_item_group, c711_date_from) NOT ENFORCED
);