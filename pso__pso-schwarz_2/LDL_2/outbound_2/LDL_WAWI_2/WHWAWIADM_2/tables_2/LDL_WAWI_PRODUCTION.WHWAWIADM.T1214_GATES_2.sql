--Because of limitations in bq we are changing the column name
--From PK_T1214_GATES$C1214_GATEID --> PK_T1214_GATES_C1214_GATEID


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t1214_gates_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1214_gateid INTEGER NOT NULL,
c1214_label STRING(200) NOT NULL,
c1214_allocationstateid INTEGER NOT NULL,
c1214_info STRING(500),
c1214_updateuser STRING(50),
c1214_updatedatetime DATETIME,
c1214_taskid INTEGER,
c1214_tourid INTEGER,
c1214_blockedbytour INTEGER NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
c1214_gateuuid STRING(16777216),
c1214_temperatureid INTEGER,
c1214_next_gate STRING(16777216),
c1214_gioverlapping INTEGER NOT NULL,
c1214_groverlapping INTEGER NOT NULL,
c1214_areaid INTEGER,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1214_gateid, wh_nr) NOT ENFORCED
);