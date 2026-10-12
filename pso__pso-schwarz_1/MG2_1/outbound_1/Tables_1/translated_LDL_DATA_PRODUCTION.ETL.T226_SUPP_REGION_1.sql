CREATE OR REPLACE TABLE ldl_data_production_etl.t226_supp_region_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c226_id INTEGER NOT NULL,
c226_country STRING(3) NOT NULL,
c226_region STRING(3) NOT NULL,
c226_desc STRING(35),
c226_sap_region STRING(3),
c226_mod_date DATETIME,
c226_mod_user STRING(8),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c226_id) NOT ENFORCED
);