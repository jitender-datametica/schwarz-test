CREATE TABLE IF NOT EXISTS ldl_data_etl.t043_intitemgrp (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
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
extraction_tmsp DATETIME,
PRIMARY KEY (c043_itemgrpnr, c043_prodgrpnr) NOT ENFORCED
);