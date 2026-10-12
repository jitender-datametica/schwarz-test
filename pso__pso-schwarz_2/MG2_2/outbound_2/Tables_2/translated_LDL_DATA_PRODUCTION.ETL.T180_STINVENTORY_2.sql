CREATE OR REPLACE TABLE ldl_data_production_etl.t180_stinventory_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c180_id INTEGER NOT NULL,
c180_whnr INTEGER NOT NULL,
c180_storenr INTEGER NOT NULL,
c180_inventorygrp INTEGER,
c180_status INTEGER,
c180_inventorydate DATETIME NOT NULL,
c180_importdate DATETIME NOT NULL,
c180_postingdate DATETIME,
c180_inventoryval BIGNUMERIC(29,10),
c180_inv_flag INTEGER,
c180_inventoryval_net BIGNUMERIC(29,10),
c180_idvalue BIGNUMERIC(29,10),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME
);