/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_minmax_params_1
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_minmax_params_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(4) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
lgtyp STRING(4) NOT NULL OPTIONS(description='Storage Type'),
max_pal_ht_repack BIGNUMERIC(38,3) OPTIONS(description='Max. Pallet Height for repack in m'),
min_avg_pick_per BIGNUMERIC(38,0) OPTIONS(description='Average Pick Percentile for MIN'),
max_avg_pick_per BIGNUMERIC(38,0) OPTIONS(description='Average Pick Percentile for MAX'),
min_thrshld_minval BIGNUMERIC(38,0) OPTIONS(description='Min. Threshold for MIN-Value in K01'),
max_thrshld_minval BIGNUMERIC(38,0) OPTIONS(description='Max. Threshold for MIN-Value in K01'),
min_gap BIGNUMERIC(38,0) OPTIONS(description='Min. Gap'),
pendulum_logic_active STRING(1) OPTIONS(description='Is Pendulum Logic active'),
dd_logic_active STRING(1) OPTIONS(description='Is DD Logic active'),
whs_open_time_from TIME OPTIONS(description='Warehouse Opening Time (from)'),
whs_open_time_to TIME OPTIONS(description='Warehouse Opening Time (to)'),
whs_open_day_from BIGNUMERIC(38,0) OPTIONS(description='Warehouse Opening Day (from)'),
whs_open_day_to BIGNUMERIC(38,0) OPTIONS(description='Warehouse Opening Day (to)'),
minmax_pull_time TIME
OPTIONS(description='The time at which the EWM system pulls the MIN/MAX data from myAPI to the EWM storage table'),
pick_interval BIGNUMERIC(38,0) OPTIONS(description='Pick interval in min'),
dq_active STRING(1) OPTIONS(description='DQ Active for MINMAX Analytics'),
dq_thrshld BIGNUMERIC(38,0) OPTIONS(description='DQ Threshold - Capacity for the bin'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, lgtyp) NOT ENFORCED
) OPTIONS(description='SAP EWM - Input parameters for MinMax Optimizer');