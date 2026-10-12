CREATE OR REPLACE TABLE ldl_data_production_etl.t442_inv_stock_wh (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c442_storenr INTEGER NOT NULL,
c442_date DATETIME NOT NULL,
c442_itemnr STRING(18) NOT NULL,
c442_status INTEGER,
c442_calc_stock BIGNUMERIC(29,10),
c442_diff BIGNUMERIC(29,10),
c442_inv_stock BIGNUMERIC(29,10),
c442_price BIGNUMERIC(29,10),
c442_price_diff BIGNUMERIC(29,10),
c442_moddate DATETIME,
c442_moduser STRING(8),
c442_calcdate DATETIME,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c442_date, c442_storenr, c442_itemnr) NOT ENFORCED
);