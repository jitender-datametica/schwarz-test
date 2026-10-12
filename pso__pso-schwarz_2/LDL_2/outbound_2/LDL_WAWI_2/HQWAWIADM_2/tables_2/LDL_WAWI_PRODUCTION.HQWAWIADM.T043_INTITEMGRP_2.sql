CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t043_intitemgrp_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c043_itemgrpnr INTEGER NOT NULL,
c043_prodgrpnr INTEGER NOT NULL,
c043_descshort STRING(15),
c043_desc STRING(35),
c043_sortingterm INTEGER,
c043_moduser STRING(8),
c043_moddate DATETIME,
c043_temp_min INTEGER,
c043_temp_max INTEGER,
c043_traceability_level INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c043_itemgrpnr, c043_prodgrpnr) NOT ENFORCED
);