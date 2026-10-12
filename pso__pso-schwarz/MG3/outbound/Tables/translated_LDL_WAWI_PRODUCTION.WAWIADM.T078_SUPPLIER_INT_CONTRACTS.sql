CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t078_supplier_int_contracts (
c078_suppnr STRING(7) NOT NULL,
c078_contract_country STRING(3) NOT NULL,
c078_main_contractor INTEGER NOT NULL,
c078_moddate DATETIME NOT NULL,
c078_moduser STRING(30) NOT NULL,
scn INTEGER DEFAULT 0,
PRIMARY KEY (c078_suppnr, c078_contract_country) NOT ENFORCED
);