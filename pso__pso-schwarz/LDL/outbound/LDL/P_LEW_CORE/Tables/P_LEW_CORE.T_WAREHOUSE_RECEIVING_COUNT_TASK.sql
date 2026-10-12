/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_receiving_count_task
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 11:48:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_warehouse_receiving_count_task (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT.'),
wh_rcv_cnt_task_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate identifier to be created (country, warehouse, inbound delivery / TASKID and creation date is generally unique).'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_nr STRING(100) NOT NULL OPTIONS(description='Business identifier of warehouses in WAWI source system.'),
task_nr STRING(100) NOT NULL OPTIONS(description='Business identifier for receiving count task.'),
task_created_dt DATE NOT NULL OPTIONS(description='Date when the receiving count task was created.'),
task_created_tmsp DATETIME OPTIONS(description='The point in time when the receiving count task was created.'),
carrier_descr STRING(250)
OPTIONS(description='Carrier description (used as free text in source). The carrier is the transportation company that transports the goods (Spediteur), not the supplier. It is a short free-text description written by the warehouse worker. This column shows the attempt to enter the carrier name.'),
task_status_id BIGNUMERIC(38,0)
OPTIONS(description='Status ID of the receiving count task like GR posted, rejected, not valid, open, etc.'),
delivery_note_nr STRING(100) OPTIONS(description='Delivery note number that comes with the driver.'),
task_completed_dt DATE OPTIONS(description='Date when the receiving count task was completed.'),
task_completed_tmsp DATETIME OPTIONS(description='The point in time when the receiving count task was completed.'),
eu_pallet_cnt BIGNUMERIC(38,0) OPTIONS(description='Count of euro pallets received per task.'),
dd_pallet_cnt BIGNUMERIC(38,0) OPTIONS(description='Count of duesseldorfer pallets received per task.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_rcv_cnt_task_sid) NOT ENFORCED
)
OPTIONS(description='Table contains counting task / inbound delivery of receiving pallet from suppliers, store returns, warehouse transfers to warehouses.             Source:             WAWI table T173_GinTask (TASKID)             EWM table /SCDL/DB_PROCH_I (Inbound Delivery ID - DOCID)');