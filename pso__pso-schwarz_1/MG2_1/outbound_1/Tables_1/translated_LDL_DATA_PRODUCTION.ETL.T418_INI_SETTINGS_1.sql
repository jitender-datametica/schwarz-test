CREATE OR REPLACE TABLE ldl_data_production_etl.t418_ini_settings_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c418_section STRING(100),
c418_setting STRING(100),
c418_value STRING(1000),
c418_idvalue BIGNUMERIC(29,10) NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c418_idvalue) NOT ENFORCED
);