CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t108_euro_umrechk_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c108_waehrungsknz INTEGER NOT NULL,
c108_gueltig_ab DATETIME NOT NULL,
c108_einheit NUMERIC(6,2) NOT NULL,
c108_datum DATETIME,
c108_bediener STRING(8),
c108_umrechkurs BIGNUMERIC(30,10),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c108_waehrungsknz, c108_gueltig_ab) NOT ENFORCED
);