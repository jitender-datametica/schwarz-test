CREATE OR REPLACE TABLE ldl_data_production_etl.t431_ststock_wh_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c431_storenr INTEGER NOT NULL,
c431_date DATETIME NOT NULL,
c431_itemnr STRING(14) NOT NULL,
c431_calc_stock BIGNUMERIC(29,10),
c431_diff BIGNUMERIC(29,10),
c431_inv_stock BIGNUMERIC(29,10),
c431_moddate DATETIME,
c431_moduser STRING(8),
c431_inv_type INTEGER,
c431_calc_stock_old BIGNUMERIC(29,10),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c431_date, c431_itemnr, c431_storenr, wh_nr) NOT ENFORCED
);