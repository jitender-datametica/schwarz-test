CREATE TABLE IF NOT EXISTS ldl_data_etl.t197_fvstock (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
c197_date DATETIME NOT NULL,
c197_storenr INTEGER NOT NULL,
c197_itemnr STRING(18) NOT NULL,
c197_stock BIGNUMERIC(30,10),
c197_orderareanr STRING(12),
c197_moddate DATETIME,
c197_moduser STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c197_date, c197_itemnr, c197_storenr) NOT ENFORCED
);