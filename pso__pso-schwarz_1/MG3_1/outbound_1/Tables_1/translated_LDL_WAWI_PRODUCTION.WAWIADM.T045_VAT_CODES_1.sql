CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t045_vat_codes_1 (
c045_vatcode INTEGER NOT NULL,
c045_countrycode STRING(3) NOT NULL,
c045_vatdesc STRING(60),
c045_moddate DATETIME,
c045_moduser STRING(8),
scn INTEGER DEFAULT 0,
PRIMARY KEY (c045_vatcode, c045_countrycode) NOT ENFORCED
);