CREATE TABLE IF NOT EXISTS ldl_data_etl.t442_inv_stock_wh_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
c442_storenr INTEGER NOT NULL,
c442_date DATETIME NOT NULL,
c442_itemnr STRING(18) NOT NULL,
c442_status INTEGER,
c442_calc_stock BIGNUMERIC(30,10),
c442_diff BIGNUMERIC(30,10),
c442_inv_stock BIGNUMERIC(30,10),
c442_price BIGNUMERIC(30,10),
c442_price_diff BIGNUMERIC(30,10),
c442_moddate DATETIME,
c442_moduser STRING(8),
c442_calcdate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c442_date, c442_storenr, c442_itemnr) NOT ENFORCED
);