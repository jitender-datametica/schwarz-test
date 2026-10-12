CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t757_cn8 (
c757_cn8code STRING(8) NOT NULL,
c757_description STRING(254),
c757_sucode STRING(15),
c757_sudesc STRING(60),
c757_current INTEGER,
c757_description1 STRING(254),
c757_description2 STRING(254),
c757_description3 STRING(254),
c757_moddate DATETIME NOT NULL,
c757_moduser STRING(8) NOT NULL,
c757_year INTEGER,
c757_idvalue BIGNUMERIC(29,10) NOT NULL,
scn INTEGER DEFAULT 0,
c757_eudr INTEGER,
PRIMARY KEY (c757_idvalue) NOT ENFORCED
);