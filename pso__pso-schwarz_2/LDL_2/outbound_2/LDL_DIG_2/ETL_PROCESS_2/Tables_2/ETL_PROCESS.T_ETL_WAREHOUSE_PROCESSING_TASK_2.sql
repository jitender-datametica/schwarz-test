/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_TASK_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 28. Februar 2023 13:09:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_task_2 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
who_id BIGNUMERIC OPTIONS(description='Identifier'),
rdoc_id STRING(64) OPTIONS(description='Identifier'),
ritm_id STRING(64) OPTIONS(description='Identifier'),
hu_id STRING(64) OPTIONS(description='Identifier'),
wh_task_status_cd STRING(5) NOT NULL OPTIONS(description='Task status_2 code'),
tapos_nr STRING(20) NOT NULL OPTIONS(description='Source Field'),
nlpla_cd STRING(36) OPTIONS(description='Code'),
tostat_cd STRING(5) OPTIONS(description='Code'),
rdoccat_cd STRING(10) OPTIONS(description='Code'),
created_at_tmsp TIMESTAMP OPTIONS(description='Created timestamp'),
who_status_cd STRING(2) OPTIONS(description='Code'),
who_queue_cd STRING(20) OPTIONS(description='Code'),
vlpla_cd STRING(36) OPTIONS(description='Code'),
task_cd STRING(20) NOT NULL OPTIONS(description='Code'),
procty_cd STRING(20) OPTIONS(description='Code'),
doc_id STRING(64) OPTIONS(description='Document ID'),
item_id STRING(64) OPTIONS(description='Item_2 Id '),
qdoc_id STRING(64) OPTIONS(description='Document ID'),
qitem_id STRING(64) OPTIONS(description='Item_2 Id '),
sguid_hu_cd STRING(64) OPTIONS(description='Identifier'),
dguid_hu_cd STRING(64) OPTIONS(description='Identifier'),
flghuto_cd STRING(5) OPTIONS(description='Identifier'),
sap_client_id STRING(20) OPTIONS(description='Code'),
sap_sys_name STRING(20) OPTIONS(description='Code'),
nlenr_cd STRING(20) OPTIONS(description='The column contains the information of Destination Handling Unit_2'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, wh_task_status_cd, tapos_nr, task_cd) NOT ENFORCED
) OPTIONS(description='ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2');