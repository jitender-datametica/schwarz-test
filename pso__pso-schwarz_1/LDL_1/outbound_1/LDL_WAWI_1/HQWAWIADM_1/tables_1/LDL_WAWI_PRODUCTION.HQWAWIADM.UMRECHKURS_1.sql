CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.umrechkurs_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
waehrungsknz_1 INTEGER NOT NULL,
gueltig_ab DATETIME NOT NULL,
einheit NUMERIC(6,2) NOT NULL,
datum DATETIME,
bediener STRING(8),
umrechnungskurs BIGNUMERIC(30,10),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (waehrungsknz_1, gueltig_ab) NOT ENFORCED
);