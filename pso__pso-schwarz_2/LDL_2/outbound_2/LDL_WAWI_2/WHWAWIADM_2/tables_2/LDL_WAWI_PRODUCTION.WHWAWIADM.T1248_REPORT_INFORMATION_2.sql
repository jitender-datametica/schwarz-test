--Because of limitations in bq we are changing the column name
--From PK_T1248_RI$C1248_ID --> PK_T1248_RI_C1248_ID


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t1248_report_information_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1248_id INTEGER NOT NULL,
c1248_timestamp DATETIME NOT NULL,
c1248_type STRING(200) NOT NULL,
c1248_key STRING(200) NOT NULL,
c1248_value STRING(16777216) NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1248_id, wh_nr) NOT ENFORCED
);