/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_gintasks_2
Description		|	WAWI table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_gintasks_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_2 code'),
task_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique ID of the task.'),
view_task_id BIGNUMERIC(38,0) OPTIONS(description=''),
gin_gate BIGNUMERIC(38,0)
OPTIONS(description='Gate that has been assigned to the task. A task does not necessarily have to be assigned to a gate.'),
gate_type_id BIGNUMERIC(38,0) OPTIONS(description=''),
carrier STRING(30) OPTIONS(description='Shipping company that delivers.'),
task_status BIGNUMERIC(38,0)
OPTIONS(description='Status_2 of the task: 0: recorded / in process (not used); 10: free for counting; 20: Locked, i.e. currently counting; 21: Locked; has differences; 29: Counting data and pallet data have been transferred, but there are still differences (for WE manager processing); 30: Counting finished, free for reprocessing; 40: Not accepted for reprocessing (i.e. deleted). The task is no longer displayed; 90: deleted; 99: Completed, i.e. WE have been created.'),
priority BIGNUMERIC(38,0)
OPTIONS(description='Specifies whether the task should be given preferential treatment. Is used for display on the MDE.'),
ponr STRING(12) OPTIONS(description='Order number. Empty for bulk deliveries.'),
krednr STRING(7) OPTIONS(description='Supplier_2 number of the order, empty for bulk deliveries'),
kreddesc STRING(35) OPTIONS(description='Supplier_2 name or shipping company for bulk deliveries'),
deliverynote STRING(20) OPTIONS(description='Delivery note number; no longer used.'),
pal_eu_in BIGNUMERIC(38,0) OPTIONS(description='Number of empty pallets brought on the truck'),
pal_eu_out BIGNUMERIC(38,0) OPTIONS(description='Number of empty pallets that the truck takes back.'),
pal_eu_gs BIGNUMERIC(38,0)
OPTIONS(description='Number of empty pallets for which the driver receives a pallet voucher.'),
pal_eu_goods BIGNUMERIC(38,0) OPTIONS(description='Number of pallets delivered with goods.'),
pal_eu_broken BIGNUMERIC(38,0) OPTIONS(description='Number of defective pallets.'),
pal_dd_in BIGNUMERIC(38,0) OPTIONS(description='See C173_PAL_EU_IN'),
pal_dd_out BIGNUMERIC(38,0) OPTIONS(description='See C173_PAL_EU_OUT'),
pal_dd_gs BIGNUMERIC(38,0) OPTIONS(description='See C173_PAL_EU_GS'),
pal_dd_goods BIGNUMERIC(38,0) OPTIONS(description='See C173_PAL_EU_GOODS'),
pal_dd_broken BIGNUMERIC(38,0) OPTIONS(description='See C173_PAL_EU_BROKEN'),
create_date DATETIME
OPTIONS(description='Date and time when the task was created for the first time. If changes are made in the goal allocation mask, the task is completely deleted and recreated. The content of this column is retained!'),
mod_date DATETIME OPTIONS(description='Last change to the task'),
mod_user STRING(8) OPTIONS(description=''),
est_pallets BIGNUMERIC(38,0)
OPTIONS(description='Expected number of pallets. Will be filled from T134 when saving the task.'),
lock_id BIGNUMERIC(38,10) OPTIONS(description='IP address_2 of the MDE client that locked the task, in numerical form.'),
pal_eu_diff BIGNUMERIC(38,0) OPTIONS(description='Palette difference from the handheld'),
pal_dd_diff BIGNUMERIC(38,0) OPTIONS(description='See C173_PAL_EU_DIFF'),
task_type BIGNUMERIC(38,0) OPTIONS(description='0: eGIN task from normal order; 1: F&V task; 2: Return'),
task_flags BIGNUMERIC(38,0)
OPTIONS(description='Special task options, partly dependent on the supplier_2: 0x01: Pallet difference permitted; 0x02: FC Task: Early pallet clearing; 4 = TTT (if Palletvoucher in Lidl.ini = 1, then status_2 5'),
container STRING(20)
OPTIONS(description='Container number; only for freight forwarders with container logistics and mandatory entry of the number.'),
rcv_lanes STRING(35)
OPTIONS(description='CSV list of the WE tracks that were recorded for this task. New for SSI (comma-separated list of the WE tracks on which the article is located'),
terminaljob_id BIGNUMERIC(38,0) OPTIONS(description=''),
ttt_state BIGNUMERIC(38,0) OPTIONS(description=''),
scn BIGNUMERIC(38,0) OPTIONS(description=''),
alma_status BIGNUMERIC(38,0) OPTIONS(description=''),
lane STRING(255) OPTIONS(description=''),
device_manufacturer STRING(50) OPTIONS(description=''),
device_model STRING(16) OPTIONS(description=''),
device_os_platform STRING(16) OPTIONS(description=''),
device_os_version STRING(8) OPTIONS(description=''),
device_uuid STRING(40) OPTIONS(description=''),
evoucher BIGNUMERIC(38,0) OPTIONS(description=''),
evoucherpal_eu BIGNUMERIC(38,0) OPTIONS(description=''),
evoucherpal_dd BIGNUMERIC(38,0) OPTIONS(description=''),
evouchernr STRING(25) OPTIONS(description=''),
driver_info BIGNUMERIC(38,0) OPTIONS(description=''),
ext_wh BIGNUMERIC(38,0) OPTIONS(description=''),
lia_reference STRING(30) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, task_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.T173_GINTASKS_2 table.');