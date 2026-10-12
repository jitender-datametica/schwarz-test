/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_quintiq_reportedshiftindicator_deleted_2
Description		|	QUINTIQ - Temporary table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_quintiq_reportedshiftindicator_deleted_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
lidl_country STRING(40) NOT NULL,
source_system STRING(30) NOT NULL,
wh_id STRING(5) NOT NULL,
address_id_seq STRING(5000),
address_name_seq STRING(5000),
calendar_week BIGNUMERIC(38,0),
costs_per_dist BIGNUMERIC(38,10),
delivery_dt DATE,
calc_dist BIGNUMERIC(38,10),
calc_dur STRING(512),
earliest_start_tmsp DATETIME,
end_tmsp DATETIME,
factor BIGNUMERIC(38,10),
tour_gid STRING(5000) NOT NULL,
haulier STRING(512),
haulier_cmnt STRING(512),
shift_ind_id STRING(512) NOT NULL,
time_ind_concat STRING(512),
box_needed_fg BOOL,
box_dlv_needed_fg BOOL,
oneway_fg BOOL,
license_plate STRING(512),
license_plate_trailer STRING(512),
loaded_shipments BIGNUMERIC(38,10),
ind_name STRING(512),
observations STRING(512),
paid_shift_fg BOOL,
resource_id STRING(512),
resource_set_id STRING(512),
resource_tech STRING(512),
resource_type STRING(512),
tour_start_tmsp DATETIME,
frozen_fg BOOL,
toll_costs BIGNUMERIC(38,10),
calc_toll_costs BIGNUMERIC(38,10),
calc_toll_dist2 BIGNUMERIC(38,10),
calc_toll_dist BIGNUMERIC(38,10),
tour_cmnt STRING(512),
tour_id STRING(512),
tour_seq_nr STRING(512),
user_dist BIGNUMERIC(38,10),
user_dur STRING(512),
user_toll_dist2 BIGNUMERIC(38,10),
user_toll_dist BIGNUMERIC(38,10),
drivingdrivetypeid STRING(512),
indicatorcost STRING(512),
licenseplatetrailer2 STRING(512),
tolldistance3calculated BIGNUMERIC(38,10),
trailer1drivetypeid STRING(512),
trailer2drivetypeid STRING(512),
usertolldistance3 BIGNUMERIC(38,10),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
update_mode STRING(2),
extraction_dt DATE NOT NULL,
extraction_ts DATETIME NOT NULL,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER NOT NULL,
record_id INTEGER NOT NULL,
filename STRING(1000) NOT NULL
) OPTIONS(description='QUINTIQ - Temporary table');