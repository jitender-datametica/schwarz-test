CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t309_pricecond_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c309_pricecondnr INTEGER NOT NULL,
c309_spsubnr INTEGER NOT NULL,
c309_validfrom DATETIME NOT NULL,
c309_validuntil DATETIME NOT NULL,
c309_value BIGNUMERIC(30,10) NOT NULL,
c309_currency INTEGER NOT NULL,
c309_moddate DATETIME,
c309_moduser STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c309_pricecondnr) NOT ENFORCED
);