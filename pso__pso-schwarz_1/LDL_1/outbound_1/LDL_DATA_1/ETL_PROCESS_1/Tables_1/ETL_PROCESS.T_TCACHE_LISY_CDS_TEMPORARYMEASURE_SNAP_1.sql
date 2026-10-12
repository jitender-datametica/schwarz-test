CREATE TABLE IF NOT EXISTS ldl_data_etl_process.t_tcache_lisy_cds_temporarymeasure_snap_1 (
extraction_ts DATETIME,
deleted STRING(3000),
id STRING(3000),
sinkcreatedon DATETIME,
sinkmodifiedon DATETIME,
igl_accountid STRING(3000),
igl_closingdatefrom STRING(3000),
igl_closingdateto STRING(3000),
igl_measurereasoncode NUMERIC(38,9),
igl_name STRING(3000),
igl_opportunityid STRING(3000),
igl_reopeningdate STRING(3000),
statecode NUMERIC(38,9),
igl_reasondescription STRING(3000),
igl_accounttypecode NUMERIC(38,9),
igl_propertytypecode NUMERIC(38,9),
igl_migrated STRING(3000),
account_statecode NUMERIC(38,9),
igl_countrycode NUMERIC(38,9),
igl_isocode2 STRING(3000),
igl_number STRING(3000),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED IN THE DATA WAREHOUSE.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS LAST UPDATED.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='THE UNIQUE IDENTIFIER OF THE BATCH LOAD WHICH HAS DONE THE LAST UPDATE TO THIS RECORD. (CLOSING A RECORD IN HISTORY WITHOUT UPDATING ANY PAYLOAD COLUMNS DOES NOT TRIGGER AN UPDATE OF THE DWH_LOAD_ID.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='THE CODE FOR THE SOURCE SYSTEM (OR SLICE OF SOURCE SYSTEM) FROM WHICH THIS RECORD WAS LOADED.')
);