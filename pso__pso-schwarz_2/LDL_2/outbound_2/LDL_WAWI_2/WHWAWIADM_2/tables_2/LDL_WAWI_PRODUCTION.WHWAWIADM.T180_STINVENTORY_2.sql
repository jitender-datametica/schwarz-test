CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t180_stinventory_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c180_id INTEGER NOT NULL,
c180_whnr INTEGER NOT NULL,
c180_storenr INTEGER NOT NULL,
c180_inventorygrp INTEGER,
c180_status INTEGER,
c180_inventorydate DATETIME NOT NULL,
c180_importdate DATETIME NOT NULL,
c180_postingdate DATETIME,
c180_inventoryval BIGNUMERIC(30,10),
c180_inv_flag INTEGER,
c180_inventoryval_net BIGNUMERIC(30,10),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c180_id, wh_nr) NOT ENFORCED
);