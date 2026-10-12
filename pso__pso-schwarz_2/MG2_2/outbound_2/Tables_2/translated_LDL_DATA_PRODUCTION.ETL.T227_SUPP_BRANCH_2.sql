CREATE OR REPLACE TABLE ldl_data_production_etl.t227_supp_branch_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c227_id STRING(4) NOT NULL,
c227_desc STRING(35),
c227_sap_branch STRING(4),
c227_mod_date DATETIME,
c227_mod_user STRING(8),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c227_id) NOT ENFORCED
);