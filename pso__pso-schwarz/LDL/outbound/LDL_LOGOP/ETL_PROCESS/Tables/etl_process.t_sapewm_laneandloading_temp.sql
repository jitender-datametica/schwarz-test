/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_laneandloading_temp
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_sapewm_laneandloading_temp (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
tu_num STRING(18) NOT NULL OPTIONS(description='Internal Number of Transportation Unit'),
status STRING(5) OPTIONS(description='Status Type'),
zz_stage_date DATE OPTIONS(description='Stage date'),
zz_stage_time TIME OPTIONS(description='Stage time'),
store STRING(10) NOT NULL OPTIONS(description='Business Partner Number'),
stp_description STRING(40) OPTIONS(description='Name 1 of organization'),
real_hus_ep BIGNUMERIC(38,2) OPTIONS(description='FLS Real HUs'),
planned_hus_ep BIGNUMERIC(38,2) OPTIONS(description='FLS PSHUs'),
lane1 STRING(18) OPTIONS(description='Lane 1'),
lane2 STRING(18) OPTIONS(description='Lane 2'),
lane3 STRING(18) OPTIONS(description='Lane 3'),
staging_status_icon STRING(4) OPTIONS(description='Staging Status'),
reshuffle STRING(4) OPTIONS(description='Reshuffle necessary'),
reshuffle_task STRING(4) OPTIONS(description='Open reshuffle tasks'),
overall_picking_status_icon STRING(4) OPTIONS(description='Picking Status'),
assigned_doors STRING(48) OPTIONS(description='Assigned Doors'),
lgnum STRING(4) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
tu_sr_act_num BIGNUMERIC(38,0) OPTIONS(description='Shipping and Receiving Activity Number: Transportation Unit'),
lic_plate STRING(20) OPTIONS(description='License Plate Number for Transportation Unit'),
tsp_curr STRING(10) OPTIONS(description='Carrier'),
frd_num STRING(35) OPTIONS(description='Freight Document Number'),
fixed_pallets BIGNUMERIC(38,2) OPTIONS(description='FLS Fix Pallets'),
real_hus BIGNUMERIC(38,2) OPTIONS(description='Amount of Real HUs'),
planned_hus BIGNUMERIC(38,2) OPTIONS(description='Amount of PSHUs'),
ca_active BOOL OPTIONS(description='Chiller-ambient active'),
stag STRING(4) NOT NULL OPTIONS(description='Staging Area Group'),
lane4 STRING(18) OPTIONS(description='Lane 4'),
stag_capacity_status_icon STRING(4) OPTIONS(description='Stage capacity status'),
stag_bay_change_icon STRING(4) OPTIONS(description='Staging Bay Change Indicator'),
total_fls BIGNUMERIC(38,2) OPTIONS(description='FLS Total'),
fs_offset BIGNUMERIC(38,2) OPTIONS(description='FLS Offset'),
overall_staging_status STRING(4) OPTIONS(description='Overall Staging Status'),
overall_picking_status STRING(4) OPTIONS(description='Overall Picking Status'),
gi_status STRING(4) OPTIONS(description='GI Status'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, tu_num, store, stag) NOT ENFORCED
) OPTIONS(description='SAP EWM - Header for CAP2 monitor node lane and loading');