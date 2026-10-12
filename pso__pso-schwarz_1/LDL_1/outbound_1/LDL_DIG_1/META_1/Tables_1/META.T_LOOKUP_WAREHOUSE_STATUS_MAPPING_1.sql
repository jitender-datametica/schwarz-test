CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_warehouse_status_mapping_1 (
wh_cd STRING(5) OPTIONS(description='Warehouse Code'),
statustype STRING(10) OPTIONS(description='Status_1 Type'),
statuscode STRING(3) OPTIONS(description='Status_1 Type Code'),
processtype STRING(10) OPTIONS(description='Process Type'),
is_in_progress_task_fg BOOL
OPTIONS(description='This field indicates whether the warehouse order number and its associated tasks and waves are currently in progress. Based on this flag, the values are being taken into consideration within the Lager Cockpit or not'),
tmsp_insert TIMESTAMP OPTIONS(description='The point in time when this record was inserted.'),
tmsp_update TIMESTAMP OPTIONS(description='The point in time when this record was last updated.')
);