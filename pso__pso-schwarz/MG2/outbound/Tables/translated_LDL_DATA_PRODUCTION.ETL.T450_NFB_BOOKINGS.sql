CREATE OR REPLACE TABLE ldl_data_production_etl.t450_nfb_bookings (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c450_itemnr STRING(18) NOT NULL,
c450_posnr INTEGER NOT NULL,
c450_linkposnr INTEGER,
c450_type INTEGER NOT NULL,
c450_qtycases BIGNUMERIC(29,10),
c450_date DATETIME,
c450_moddate DATETIME,
c450_moduser STRING(8),
c450_whnr INTEGER NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c450_whnr, c450_itemnr, c450_posnr) NOT ENFORCED
);