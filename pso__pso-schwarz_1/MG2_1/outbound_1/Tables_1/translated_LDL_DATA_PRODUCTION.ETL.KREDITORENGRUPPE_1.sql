CREATE OR REPLACE TABLE ldl_data_production_etl.kreditorengruppe_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
kreditorgruppennr INTEGER NOT NULL,
kreditorgruppenbez STRING(35) NOT NULL,
datum DATETIME,
bediener STRING(8),
globalkreditor INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (kreditorgruppennr) NOT ENFORCED
);