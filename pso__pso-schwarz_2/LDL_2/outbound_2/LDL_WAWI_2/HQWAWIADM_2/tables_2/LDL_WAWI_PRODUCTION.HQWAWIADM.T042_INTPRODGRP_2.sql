CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t042_intprodgrp_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c042_prodgrpnr INTEGER NOT NULL,
c042_descshort STRING(15),
c042_desc STRING(35),
c042_sortingterm INTEGER,
c042_moduser STRING(8),
c042_moddate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c042_prodgrpnr) NOT ENFORCED
);