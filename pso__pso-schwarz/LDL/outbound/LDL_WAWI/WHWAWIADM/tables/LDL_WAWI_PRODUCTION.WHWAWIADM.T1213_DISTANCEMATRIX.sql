--Because of limitations in bq we are changing the column name
--From PK_T1213_DISTAN$C1213_MATRI --> PK_T1213_DISTAN_C1213_MATRI


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t1213_distancematrix (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1213_matrixid INTEGER NOT NULL,
c1213_gateid INTEGER NOT NULL,
c1213_distance NUMERIC(6,2),
scn BIGNUMERIC(38,0) DEFAULT 0,
c1213_pickingbinid INTEGER,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1213_matrixid, wh_nr) NOT ENFORCED
);