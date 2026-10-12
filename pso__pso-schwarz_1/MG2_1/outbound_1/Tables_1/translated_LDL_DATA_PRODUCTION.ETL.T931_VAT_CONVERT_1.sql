CREATE OR REPLACE TABLE ldl_data_production_etl.t931_vat_convert_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c931_storenr BIGNUMERIC(29,10) NOT NULL,
c931_vatcode_wawi BIGNUMERIC(29,10) NOT NULL,
c931_vatcode_converted BIGNUMERIC(29,10) NOT NULL,
c931_countrycode STRING(3) NOT NULL,
c931_moddate DATETIME,
c931_moduser STRING(8),
c931_type INTEGER NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c931_countrycode, c931_storenr, c931_vatcode_wawi) NOT ENFORCED
);