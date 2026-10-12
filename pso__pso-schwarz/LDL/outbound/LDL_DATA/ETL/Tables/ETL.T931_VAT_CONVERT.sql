CREATE TABLE IF NOT EXISTS ldl_data_etl.t931_vat_convert (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c931_storenr BIGNUMERIC(38,10) NOT NULL,
c931_vatcode_wawi BIGNUMERIC(38,10) NOT NULL,
c931_vatcode_converted BIGNUMERIC(38,10) NOT NULL,
c931_countrycode STRING(3) NOT NULL,
c931_moddate DATETIME,
c931_moduser STRING(8),
c931_type INTEGER NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c931_countrycode, c931_storenr, c931_vatcode_wawi) NOT ENFORCED
);