CREATE TABLE IF NOT EXISTS ldl_data_etl.t045_vat_codes (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c045_vatcode INTEGER NOT NULL,
c045_countrycode STRING(3) NOT NULL,
c045_vatdesc STRING(60),
c045_moddate DATETIME,
c045_moduser STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c045_countrycode, c045_vatcode) NOT ENFORCED
);