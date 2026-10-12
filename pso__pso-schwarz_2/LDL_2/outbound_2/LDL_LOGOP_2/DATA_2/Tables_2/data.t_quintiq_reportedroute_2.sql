/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_quintiq_reportedroute_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedroute_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
delivery_dt DATE NOT NULL OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'),
calc_dist BIGNUMERIC(38,10) OPTIONS(description='Distance caluclated for the route'),
calc_dur STRING(512) OPTIONS(description='Action.End - Action.Start'),
haulier_id STRING(512) OPTIONS(description='Identifier of haulier.'),
haulier_name STRING(512) OPTIONS(description='Name of the Haulier'),
license_plate STRING(512) OPTIONS(description='License plate of the vechicle used for this tour_2'),
shifts_cnt BIGNUMERIC(38,0) OPTIONS(description='Total number of shifts in the route'),
resource_id STRING(512) NOT NULL OPTIONS(description='Resource ID'),
resource_set_id STRING(512) OPTIONS(description='The ID of resource set used in a route'),
max_cap_sum BIGNUMERIC(38,10) OPTIONS(description='All capacities of the resources in the resourceSet summed'),
tour_gid STRING(5000)
OPTIONS(description='GID is to have a unique identifier of a tour_2 across different delivery days for the same RDC.'),
user_dist BIGNUMERIC(38,10) OPTIONS(description='User entered distance for the tour_2'),
user_dur STRING(512) OPTIONS(description='User entered duration for the tour_2'),
user_shifts_cnt BIGNUMERIC(38,0) OPTIONS(description='User entered number of shifts in the route'),
calender_week_nr BIGNUMERIC(38,0) OPTIONS(description='Calenderweek of GlobalParameters.DeliveryDateEnd'),
changes_in_shift_costs BIGNUMERIC(38,10) OPTIONS(description='Change In Shift Costs'),
end_tmsp DATETIME OPTIONS(description='The time of the end of the action(s)'),
haulier_cmnt_txt STRING(512) OPTIONS(description='User entered comment on the haulier for this route'),
indicators_time_tour STRING(512)
OPTIONS(description='Concatenation of all unique time indicators on tours related to this route'),
temp_reported_route_fg BOOL OPTIONS(description='Indicates if this is a temporary reported route'),
shift_indicator_elke_cnt BIGNUMERIC(38,10)
OPTIONS(description='Sum over all unique shiftIndicators which have IsStoreDelivery'),
route_gid STRING(512)
OPTIONS(description='GID is to have a unique identifier of a Route across different delivery days for the same RDC.'),
start_tmsp DATETIME OPTIONS(description='The time of the start of the action(s)'),
max_cap_sum_2 BIGNUMERIC(38,10) OPTIONS(description='All capacities of the resources in the resourceSet summed'),
trailer1drivetypeid STRING(512) OPTIONS(description='ID of trailer 1 drive type'),
summaxcapacity1converted BIGNUMERIC(38,10)
OPTIONS(description='The sum of all max capacity 1 converted in the resources within this tour_2'),
drivingdrivetypeid STRING(512) OPTIONS(description='ID of driving drive type'),
isdummyresourceset BOOL OPTIONS(description='TRUE if the resource set assigned to this route is dummy_2'),
trailer2drivetypeid STRING(512) OPTIONS(description='ID of trailer 2 drive type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, resource_id, delivery_dt, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='The object ReportedRoute in the RDCMatrix dataset gathers all relevant data for this object from the Route and Tour_2 objects in the RDCDay dataset.');