CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t197_fvstock_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c197_date DATETIME NOT NULL,
c197_storenr INTEGER NOT NULL,
c197_itemnr STRING(18) NOT NULL,
c197_stock BIGNUMERIC(30,10),
c197_orderareanr STRING(8),
c197_moddate DATETIME,
c197_moduser STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c197_date, c197_storenr, c197_itemnr, wh_nr) NOT ENFORCED
);