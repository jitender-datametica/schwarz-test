CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t227_supp_branch (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c227_id STRING(4) NOT NULL,
c227_desc STRING(35),
c227_sap_branch STRING(4),
c227_mod_date DATETIME,
c227_mod_user STRING(8),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c227_id) NOT ENFORCED
);