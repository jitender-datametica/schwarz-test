CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t184_sic_opendocs (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c184_id INTEGER,
c184_storenr INTEGER,
c184_formtype INTEGER,
c184_formdate DATETIME,
c184_debit BIGNUMERIC(30,10),
c184_credit BIGNUMERIC(30,10),
c184_formnr STRING(20),
c184_credit_net BIGNUMERIC(30,10),
c184_debit_net BIGNUMERIC(30,10),
c184_idvalue BIGNUMERIC(38,10) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c184_idvalue, wh_nr) NOT ENFORCED
);