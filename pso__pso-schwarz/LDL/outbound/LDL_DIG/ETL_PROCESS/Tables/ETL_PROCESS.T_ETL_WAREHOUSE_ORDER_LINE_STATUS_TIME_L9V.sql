/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_ORDER_LINE_STATUS_TIME_L9V
   GENERATED FROM POWERDESIGNER ON Mittwoch, 21. August 2024 14:03:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_order_line_status_time_l9v (
wh_order_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the document generated to record the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from docid + sap_client_id + sap_sys_name from the source) '),
wh_order_pos_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
scheduled_wh_order_pos_nr BIGNUMERIC NOT NULL
OPTIONS(description='Not in use, always has same value. Could be used if the items in one position from one order are NOT sent at once, but on several batches.            In such case there will be a schedule when each batch will be sent. In such case for each batch there will be a different value in this column.'),
wh_order_processing_step_timing_cd STRING(20) NOT NULL
OPTIONS(description='Code that describes the type of step that is measured (in SAP it is represented as "time type", although it indicates what is the step of the process) - For example "PTAW" stands for "Putaway", "GOODSRECPT" stands for "goods receipt"'),
wh_order_processing_step_timing_cat_cd STRING(20) NOT NULL
OPTIONS(description='Code that describes if the row has the "PLANNED" or "ACTUAL" timing values for the warehouse processing step'),
wh_order_cat_cd STRING(6)
OPTIONS(description='The code for the category of the warehouse inbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).'),
wh_order_processing_step_start_tmsp TIMESTAMP
OPTIONS(description='Timestamp indicating when the step starts'),
wh_order_processing_step_end_tmsp TIMESTAMP
OPTIONS(description='Timestamp indicating when the step ends'),
wh_order_processing_timing_calculation_cd STRING(5)
OPTIONS(description='A code that indicates how the row in the table was created.            C - Value Determined By System            M - Value Specified as Mandatory Manually; Change Value Manually            E - Value Specified as Mandatory Externally and not Changeable            P - Value Proposed Externally; Changeable Manually or by System            " " - Initial State, Value to be redetermined by System'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_order_sid, wh_order_pos_sid, scheduled_wh_order_pos_nr, wh_order_processing_step_timing_cd,
 wh_order_processing_step_timing_cat_cd) NOT ENFORCED
)
OPTIONS(description='ETL  table to support loading the data coming from L9V related to the different warehouse processing steps and the time it takes to move from one step to another.              The source of the table is /SCDL/DB_DATE table from SAP EWM module.             These statuses are highly related with data coming from /SCDL/DB_STATUS, stored in tables T_ETL_WAREHOUSE_ORDER_LINE_STATUS_XXX                          The data in this table is mainly derived data, Start/End times are automatically populated in DB_DATE when a status  (in DB_STATUS table) changes.             The values in wh_order_processing_step_timing_cd show what type of step  we have, although they are not the same values as wh_order_processing_step_cd - they are derived                           For example: At 10:00 in DB_STATUS, status was set to "Receiving goods" this means in DB_DATE we have 10:00 as start of the "timing type" "receiving of goods"             	when at 10:03 the status in DB_STATS is set to "All Goods Received", then the End of timing type of "Receiving of goods" is set 10:03             	and the new timing type is started                          The table contains rows for both PLANNED and ACTUAL values (wh_order_processing_step_timing_cat_cd)');