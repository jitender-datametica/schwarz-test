--Because of limitations in bq we are changing the column name
--From PK_T1253$C1253_ID --> PK_T1253_C1253_ID


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t1253_pickingbins_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1253_id INTEGER NOT NULL,
c1253_uuid STRING(16777216),
c1253_name STRING(200) NOT NULL,
c1253_aisle_id INTEGER,
c1253_orientation INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1253_id, wh_nr) NOT ENFORCED
);