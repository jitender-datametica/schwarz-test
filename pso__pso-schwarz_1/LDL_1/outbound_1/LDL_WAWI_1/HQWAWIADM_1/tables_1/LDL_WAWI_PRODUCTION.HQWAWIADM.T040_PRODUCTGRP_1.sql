CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t040_productgrp_1 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c040_prodgrpnr INTEGER NOT NULL,
c040_descshort STRING(15),
c040_desc STRING(35) NOT NULL,
c040_sortingterm INTEGER NOT NULL,
c040_moduser STRING(8),
c040_moddate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
c040_can_edit_casesize INTEGER,
c040_can_edit_price INTEGER,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c040_prodgrpnr) NOT ENFORCED
);