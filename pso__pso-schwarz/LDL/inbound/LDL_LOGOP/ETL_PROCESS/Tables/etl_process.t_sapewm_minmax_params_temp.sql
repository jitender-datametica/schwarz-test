/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_minmax_params_temp
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_sapewm_minmax_params_temp (
client_id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
lidl_country 				VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
wh_id						NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
lgnum                       VARCHAR(4)      NOT NULL 	COMMENT 'Warehouse Number/Warehouse Complex',
lgtyp                       VARCHAR(4)      NOT NULL 	COMMENT 'Storage Type',
max_pal_ht_repack        	NUMBER(38,3)    NULL 	 	COMMENT 'Max. Pallet Height for repack in m',
min_avg_pick_per         	NUMBER(38,0)    NULL 	 	COMMENT 'Average Pick Percentile for MIN',
max_avg_pick_per         	NUMBER(38,0)    NULL 	 	COMMENT 'Average Pick Percentile for MAX',
min_thrshld_minval       	NUMBER(38,0)    NULL 	 	COMMENT 'Min. Threshold for MIN-Value in K01',
max_thrshld_minval       	NUMBER(38,0)    NULL 	 	COMMENT 'Max. Threshold for MIN-Value in K01',
min_gap                  	NUMBER(38,0)    NULL 	 	COMMENT 'Min. Gap',
pendulum_logic_active    	VARCHAR(1)      NULL 	 	COMMENT 'Is Pendulum Logic active',
dd_logic_active          	VARCHAR(1)      NULL 	 	COMMENT 'Is DD Logic active',
whs_open_time_from       	TIME(0)         NULL 	 	COMMENT 'Warehouse Opening Time (from)',
whs_open_time_to         	TIME(0)         NULL 	 	COMMENT 'Warehouse Opening Time (to)',
whs_open_day_from        	NUMBER(38,0)    NULL 	 	COMMENT 'Warehouse Opening Day (from)',
whs_open_day_to          	NUMBER(38,0)    NULL 	 	COMMENT 'Warehouse Opening Day (to)',
minmax_pull_time         	TIME(0)         NULL 	 	COMMENT 'The time at which the EWM system pulls the MIN/MAX data from myAPI to the EWM storage table',
pick_interval            	NUMBER(38,0)    NULL 	 	COMMENT 'Pick interval in min',
dq_active            		VARCHAR(1)	    NULL 	 	COMMENT 'DQ Active for MINMAX Analytics',
dq_thrshld           	 	NUMBER(38,0)    NULL 	 	COMMENT 'DQ Threshold - Capacity for the bin',
dwh_load_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created					TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated					TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
PRIMARY KEY (client_id, lgnum,lgtyp)
) COMMENT = 'SAP EWM - Input parameters for MinMax Optimizer'
;	