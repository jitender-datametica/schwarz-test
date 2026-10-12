/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_quintiq_reportedroute_1
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedroute_1 (
client_id 	   				NUMBER(38,0) 	NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
lidl_country   				VARCHAR(3)   	NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
source_system  				VARCHAR(30)  	NOT NULL COMMENT 'Source system',
wh_id 		   				VARCHAR(5)   	NOT NULL COMMENT 'Warehouse ID',
delivery_dt			        DATE		 	NOT NULL COMMENT 'End of the delivery day to optimize for (max 24hrs after start).',
calc_dist			        NUMBER(38,10)	NULL 	 COMMENT 'Distance caluclated for the route',
calc_dur			        VARCHAR(512)	NULL 	 COMMENT 'Action.End - Action.Start',
haulier_id			        VARCHAR(512)	NULL 	 COMMENT 'Identifier of haulier.',
haulier_name		        VARCHAR(512) 	NULL 	 COMMENT 'Name of the Haulier',
license_plate		        VARCHAR(512)    NULL     COMMENT 'License plate of the vechicle used for this tour_1',
shifts_cnt			        NUMBER(38,0) 	NULL 	 COMMENT 'Total number of shifts in the route',
resource_id			        VARCHAR(512)	NOT NULL COMMENT 'Resource ID',
resource_set_id		        VARCHAR(512)	NULL 	 COMMENT 'The ID of resource set used in a route',
max_cap_sum			        NUMBER(38,10)	NULL 	 COMMENT 'All capacities of the resources in the resourceSet summed',
tour_gid			        VARCHAR(5000)	NULL 	 COMMENT 'GID is to have a unique identifier of a tour_1 across different delivery days for the same RDC.',
user_dist			        NUMBER(38,10)	NULL 	 COMMENT 'User entered distance for the tour_1',
user_dur			        VARCHAR(512)	NULL 	 COMMENT 'User entered duration for the tour_1',
user_shifts_cnt		        NUMBER(38,0)	NULL 	 COMMENT 'User entered number of shifts in the route',
calender_week_nr		    NUMBER(38,0)	NULL 	 COMMENT 'Calenderweek of GlobalParameters.DeliveryDateEnd',
changes_in_shift_costs	    NUMBER(38,10)	NULL 	 COMMENT 'Change In Shift Costs',
end_tmsp		            TIMESTAMP    	NULL 	 COMMENT 'The time of the end of the action(s)',
haulier_cmnt_txt		    VARCHAR(512)	NULL 	 COMMENT 'User entered comment on the haulier for this route',
indicators_time_tour	    VARCHAR(512)	NULL 	 COMMENT 'Concatenation of all unique time indicators on tours related to this route',
temp_reported_route_fg	    BOOLEAN     	NULL 	 COMMENT 'Indicates if this is a temporary reported route',
shift_indicator_elke_cnt	NUMBER(38,10)	NULL 	 COMMENT 'Sum over all unique shiftIndicators which have IsStoreDelivery',
route_gid		            VARCHAR(512)	NULL 	 COMMENT 'GID is to have a unique identifier of a Route across different delivery days for the same RDC.',
start_tmsp		            TIMESTAMP   	NULL 	 COMMENT 'The time of the start of the action(s)',
max_cap_sum_2		    	NUMBER(38,10)	NULL 	 COMMENT 'All capacities of the resources in the resourceSet summed',
trailer1drivetypeid		    VARCHAR(512)	NULL 	 COMMENT 'ID of trailer 1 drive type',
summaxcapacity1converted	NUMBER(38,10)	NULL 	 COMMENT 'The sum of all max capacity 1 converted in the resources within this tour_1',
drivingdrivetypeid		    VARCHAR(512)	NULL 	 COMMENT 'ID of driving drive type',
isdummyresourceset		    BOOLEAN			NULL 	 COMMENT 'TRUE if the resource set assigned to this route is dummy_1',
trailer2drivetypeid		    VARCHAR(512)	NULL 	 COMMENT 'ID of trailer 2 drive type',
dwh_load_id    				NUMBER(38,0) 	NOT NULL COMMENT 'Load id',
dwh_created    				TIMESTAMP 		NOT NULL COMMENT 'Record created at',
dwh_updated   			 	TIMESTAMP 		NOT NULL COMMENT 'Record updated at',
dwh_valid_from 				DATE 			NOT NULL COMMENT 'Valid from date',
dwh_valid_to   				DATE 			NOT NULL COMMENT 'Valid to date',
deleted_fg     				BOOLEAN 		NOT NULL COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id,wh_id,resource_id,delivery_dt,dwh_valid_from)
) COMMENT = 'The object ReportedRoute in the RDCMatrix dataset gathers all relevant data for this object from the Route and Tour_1 objects in the RDCDay dataset.';