CREATE OR REPLACE TABLE ldl_data_production_etl.t118_statusdesc_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c118_status INTEGER NOT NULL,
c118_statusdesc STRING(50),
c118_hq INTEGER,
c118_wh INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c118_status) NOT ENFORCED
);