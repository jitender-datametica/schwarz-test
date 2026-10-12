/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_order_time_range
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_warehouse_order_time_range (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
wh_order_time_range_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key; uniquely identifies a WH Order Time Range'),
src_orig_wh_nr STRING(20) OPTIONS(description='techn. identifier of the WH within WAWI surce system'),
src_range_zone_id STRING(20) OPTIONS(description='techn. identifier of the time range within WAWI source system'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WH for which the time range is defined'),
order_time_range_name STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='name that describes the order time range'),
order_time_plan_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='order time plan to which the specific order time range belongs (master data missing)'),
order_time_from_tm TIME OPTIONS(description='begin time of the order time range'),
order_time_to_tm TIME OPTIONS(description='end time of the order time range'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (wh_order_time_range_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Time ranges defined by WH. Orders need to be placed within those time ranges, in order to guarantee a shipment in time (e.g. next day). ');