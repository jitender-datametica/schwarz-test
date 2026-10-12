CREATE OR REPLACE TABLE ldl_data_production_etl.t401_nfditems_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c401_id INTEGER NOT NULL,
c401_itemnr STRING(8) NOT NULL,
c401_readvertised INTEGER,
c401_moddate DATETIME,
c401_moduser STRING(8),
c401_germandesc STRING(40),
c401_itemdesc STRING(100),
scn INTEGER DEFAULT 0,
c401_auto INTEGER,
extraction_tmsp DATETIME,
PRIMARY KEY (c401_id, c401_itemnr) NOT ENFORCED
);