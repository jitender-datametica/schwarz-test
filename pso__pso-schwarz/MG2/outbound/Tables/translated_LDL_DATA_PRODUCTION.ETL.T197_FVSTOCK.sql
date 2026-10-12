CREATE OR REPLACE TABLE ldl_data_production_etl.t197_fvstock (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c197_date DATETIME NOT NULL,
c197_storenr INTEGER NOT NULL,
c197_itemnr STRING(18) NOT NULL,
c197_stock BIGNUMERIC(29,10),
c197_orderareanr STRING(12),
c197_moddate DATETIME,
c197_moduser STRING(8),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c197_date, c197_itemnr, c197_storenr) NOT ENFORCED
);