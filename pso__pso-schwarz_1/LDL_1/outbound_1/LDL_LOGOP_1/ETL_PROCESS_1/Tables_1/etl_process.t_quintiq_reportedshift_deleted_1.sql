/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_quintiq_reportedshift_deleted_1
Description		|	QUINTIQ - Temporary table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_quintiq_reportedshift_deleted_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
lidl_country STRING(40) NOT NULL,
source_system STRING(30) NOT NULL,
wh_id STRING(5) NOT NULL,
address_id_seq STRING(5000),
address_name_seq STRING(10000),
calendar_week BIGNUMERIC(38,0),
delivery_dt DATE NOT NULL,
calc_dist BIGNUMERIC(38,10),
calc_dur STRING(512),
earliest_start_tmsp DATETIME,
end_tmsp DATETIME,
tour_gid STRING(5000) NOT NULL,
haulier_name STRING(512),
haulier_cmnt STRING(512),
tour_id STRING(512),
license_plate STRING(512),
license_plate_trailer STRING(512),
loaded_shipments BIGNUMERIC(38,10),
observations STRING(512),
resource_id STRING(512),
resource_set_id STRING(512) NOT NULL,
resource_tech STRING(512),
resource_type STRING(512),
shift BIGNUMERIC(38,0),
tour_start_tmsp DATETIME,
calc_toll_dist2 BIGNUMERIC(38,10),
calc_toll_dist BIGNUMERIC(38,10),
tour_cmnt STRING(512),
user_dist BIGNUMERIC(38,10),
user_dur STRING(512),
user_toll_dist2 BIGNUMERIC(38,10),
user_toll_dist BIGNUMERIC(38,10),
indicatorstimetour STRING(512),
isboxrequired BOOL,
isdeliveredinneededbox BOOL,
isoneway BOOL,
paidshift BOOL,
costsperdistanceunit BIGNUMERIC(38,10),
drivingdrivetypeid STRING(512),
indicatorcost STRING(512),
licenseplatetrailer2 STRING(512),
tiko BOOL,
tollcost BIGNUMERIC(38,10),
tollcostcalculated BIGNUMERIC(38,10),
tolldistance3calculated BIGNUMERIC(38,10),
toursequenceid STRING(512),
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