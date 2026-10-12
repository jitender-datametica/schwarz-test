DROP TABLE IF EXISTS ldl_wawi_production_whwawiadm.t88_sformhead_2;
--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t88_sformhead_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c88_formcount BIGNUMERIC(30,10) NOT NULL,
c88_storeno INTEGER NOT NULL,
c88_formtype INTEGER NOT NULL,
c88_formdate DATETIME NOT NULL,
c88_warehouseno INTEGER,
c88_towarehouse INTEGER,
c88_tostore INTEGER,
c88_pl_pv_date DATETIME,
c88_pl_bereich STRING(8),
c88_global INTEGER,
c88_correct_count INTEGER,
c88_moddate DATETIME,
c88_moduser STRING(8),
c88_checksumvalue BIGNUMERIC(30,10),
c88_formno STRING(20),
c88_whnr INTEGER NOT NULL,
c88_adr_export_flag INTEGER NOT NULL,
c88_adr_export_date DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c88_formcount, c88_whnr, wh_nr) NOT ENFORCED
) CLUSTER BY c88_formcount, c88_whnr, wh_nr;