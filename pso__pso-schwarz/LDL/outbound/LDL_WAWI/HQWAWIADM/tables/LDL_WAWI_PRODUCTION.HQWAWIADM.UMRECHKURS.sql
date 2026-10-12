CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.umrechkurs (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
waehrungsknz INTEGER NOT NULL,
gueltig_ab DATETIME NOT NULL,
einheit NUMERIC(6,2) NOT NULL,
datum DATETIME,
bediener STRING(8),
umrechnungskurs BIGNUMERIC(30,10),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (waehrungsknz, gueltig_ab) NOT ENFORCED
);