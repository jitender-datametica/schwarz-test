CREATE TABLE IF NOT EXISTS ldl_data_etl.t180_stinventory_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
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
c180_idvalue BIGNUMERIC(38,10),
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME
);