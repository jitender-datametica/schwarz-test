CREATE OR REPLACE TABLE ldl_data_production_etl.t042_intprodgrp (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c042_prodgrpnr INTEGER NOT NULL,
c042_descshort STRING(15),
c042_desc STRING(35),
c042_sortingterm INTEGER,
c042_moduser STRING(8),
c042_moddate DATETIME,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c042_prodgrpnr) NOT ENFORCED
);