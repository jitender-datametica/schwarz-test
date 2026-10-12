CREATE OR REPLACE TABLE ldl_data_production_etl.t216_int_supplier (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c216_int_suppnr STRING(10) NOT NULL,
c216_suppnr STRING(7) NOT NULL,
c216_int_suppdesc STRING(35),
c216_moddate DATETIME,
c216_moduser STRING(8),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c216_int_suppnr, c216_suppnr) NOT ENFORCED
);