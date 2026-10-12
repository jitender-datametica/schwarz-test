CREATE OR REPLACE TABLE ldl_data_production_etl.t184_sic_opendocs_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c184_id INTEGER,
c184_storenr INTEGER,
c184_formtype INTEGER,
c184_formdate DATETIME,
c184_debit BIGNUMERIC(29,10),
c184_credit BIGNUMERIC(29,10),
c184_formnr STRING(20),
c184_credit_net BIGNUMERIC(29,10),
c184_debit_net BIGNUMERIC(29,10),
c184_idvalue BIGNUMERIC(29,10) NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c184_idvalue) NOT ENFORCED
);