/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_quintiq_reportedroute_deleted_1
Description		|	QUINTIQ - Temporary table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_quintiq_reportedroute_deleted_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
lidl_country STRING(40) NOT NULL,
source_system STRING(30) NOT NULL,
wh_id STRING(5) NOT NULL,
delivery_dt DATE NOT NULL,
calc_dist BIGNUMERIC(38,10),
calc_dur STRING(512),
haulier_id STRING(512),
haulier_name STRING(512),
license_plate STRING(512),
shifts_cnt BIGNUMERIC(38,0),
resource_id STRING(512) NOT NULL,
resource_set_id STRING(512),
max_cap_sum BIGNUMERIC(38,10),
tour_gid STRING(5000),
user_dist BIGNUMERIC(38,10),
user_dur STRING(512),
user_shifts_cnt BIGNUMERIC(38,0),
calender_week_nr BIGNUMERIC(38,0),
changes_in_shift_costs BIGNUMERIC(38,10),
end_tmsp DATETIME,
haulier_cmnt_txt STRING(512),
indicators_time_tour STRING(512),
temp_reported_route_fg BOOL,
shift_indicator_elke_cnt BIGNUMERIC(38,10),
route_gid STRING(512),
start_tmsp DATETIME,
max_cap_sum_2 BIGNUMERIC(38,10),
trailer1drivetypeid STRING(512),
summaxcapacity1converted BIGNUMERIC(38,10),
drivingdrivetypeid STRING(512),
isdummyresourceset BOOL,
trailer2drivetypeid STRING(512),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
update_mode STRING(2),
extraction_dt DATE NOT NULL,
extraction_ts DATETIME NOT NULL,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER NOT NULL,
record_id INTEGER NOT NULL,
filename STRING(1000) NOT NULL
) OPTIONS(description='QUINTIQ - Temporary table');