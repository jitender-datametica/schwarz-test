CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t216_int_supplier_1 (
c216_int_suppnr STRING(10) NOT NULL,
c216_suppnr STRING(7) NOT NULL,
c216_int_suppdesc STRING(35),
c216_moddate DATETIME,
c216_moduser STRING(8),
scn INTEGER DEFAULT 0,
PRIMARY KEY (c216_int_suppnr, c216_suppnr) NOT ENFORCED
);