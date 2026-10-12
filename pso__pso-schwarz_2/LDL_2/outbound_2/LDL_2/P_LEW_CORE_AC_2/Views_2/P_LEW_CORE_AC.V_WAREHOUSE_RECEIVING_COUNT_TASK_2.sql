CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_warehouse_receiving_count_task_2 (client_id
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT.'), wh_rcv_cnt_task_sid
OPTIONS(description='Surrogate identifier to be created (country_2, warehouse, inbound delivery / TASKID and creation date is generally unique).'),
wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION.'), wh_nr
OPTIONS(description='Business identifier of warehouses in WAWI source system.'), task_nr
OPTIONS(description='Business identifier for receiving count task.'), task_created_dt
OPTIONS(description='Date when the receiving count task was created.'), task_created_tmsp
OPTIONS(description='The point in time when the receiving count task was created.'), carrier_descr
OPTIONS(description='Carrier description (used as free text in source). The carrier is the transportation company that transports the goods (Spediteur), not the supplier. It is a short free-text description written by the warehouse worker. This column shows the attempt to enter the carrier name.'),
task_status_id
OPTIONS(description='Status_2 ID of the receiving count task like GR posted, rejected, not valid, open, etc.'),
delivery_note_nr OPTIONS(description='Delivery note number that comes with the driver.'), task_completed_dt
OPTIONS(description='Date when the receiving count task was completed.'), task_completed_tmsp
OPTIONS(description='The point in time when the receiving count task was completed.'), eu_pallet_cnt
OPTIONS(description='Count of euro pallets received per task.'), dd_pallet_cnt
OPTIONS(description='Count of duesseldorfer pallets received per task.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `TABLE CONTAINS COUNTING TASK / INBOUND DELIVERY OF RECEIVING PALLET FROM SUPPLIERS, STORE RETURNS, WAREHOUSE TRANSFERS TO WAREHOUSES.SOURCE:WAWI TABLE T173_GINTASK (TASKID)EWM TABLE /SCDL/DB_PROCH_I (INBOUND DELIVERY ID - DOCID)`)
AS SELECT client_id,
 wh_rcv_cnt_task_sid,
 wh_loc_sid,
 wh_nr,
 task_nr,
 task_created_dt,
 task_created_tmsp,
 carrier_descr,
 task_status_id,
 delivery_note_nr,
 task_completed_dt,
 task_completed_tmsp,
 eu_pallet_cnt,
 dd_pallet_cnt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_warehouse_receiving_count_task_2;