CREATE TABLE IF NOT EXISTS ldl_data_etl.t272_shelftime_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c272_shelft_nr INTEGER NOT NULL,
c272_shelft_desc STRING(15),
c272_shelft_lt STRING(2),
c272_shelft_calc INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c272_shelft_nr) NOT ENFORCED
);