/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_quintiq_reportedroute_deleted_1
Description		|	QUINTIQ - Temporary table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_quintiq_reportedroute_deleted_1 (
client_id               	NUMBER(38,0)    NOT NULL,
lidl_country            	VARCHAR(40)     NOT NULL,
source_system           	VARCHAR(30)     NOT NULL,
wh_id                   	VARCHAR(5)      NOT NULL,
delivery_dt	                DATE			NOT NULL,
calc_dist	                NUMBER(38,10)	NULL,	
calc_dur	                VARCHAR(512)	NULL,	
haulier_id	                VARCHAR(512)	NULL,
haulier_name	            VARCHAR(512) 	NULL,	
license_plate	            VARCHAR(512)    NULL,
shifts_cnt	                NUMBER(38,0) 	NULL,
resource_id	                VARCHAR(512)	NOT NULL,
resource_set_id	            VARCHAR(512)	NULL,
max_cap_sum	                NUMBER(38,10)	NULL,	
tour_gid	                VARCHAR(5000)	NULL,	
user_dist	                NUMBER(38,10)	NULL,	
user_dur	                VARCHAR(512)	NULL,
user_shifts_cnt	            NUMBER(38,0)	NULL,
calender_week_nr            NUMBER(38,0)	NULL,
changes_in_shift_costs	    NUMBER(38,10)	NULL,
end_tmsp		        	TIMESTAMP    	NULL,
haulier_cmnt_txt	        VARCHAR(512)	NULL,
indicators_time_tour	    VARCHAR(512)	NULL,
temp_reported_route_fg	    BOOLEAN     	NULL,
shift_indicator_elke_cnt    NUMBER(38,10)	NULL,
route_gid		        	VARCHAR(512)	NULL,
start_tmsp		        	TIMESTAMP   	NULL,
max_cap_sum_2   	        NUMBER(38,10)	NULL,
trailer1drivetypeid			VARCHAR(512)	NULL,
summaxcapacity1converted	NUMBER(38,10)	NULL,
drivingdrivetypeid			VARCHAR(512)	NULL,
isdummyresourceset			BOOLEAN			NULL,
trailer2drivetypeid			VARCHAR(512)	NULL,
deleted_fg              	NUMBER(38,0)    NOT NULL,
update_mode             	VARCHAR(2)      NULL,
extraction_dt           	DATE            NOT NULL,
extraction_ts           	TIMESTAMP       NOT NULL,
dwh_mapping_dt          	DATE            NOT NULL,
tf_error_fg             	NUMBER(1,0)     NOT NULL,
record_id               	NUMBER(10,0)    NOT NULL,
filename                	VARCHAR(1000)   NOT NULL
) COMMENT = 'QUINTIQ - Temporary table';