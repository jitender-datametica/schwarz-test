/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedshift
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedshift (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
address_id_seq STRING(5000)
OPTIONS(description='Contains the IDs of all the non rdc addresses this tour visits in the order the are visited'),
address_name_seq STRING(10000)
OPTIONS(description='Contains the long names of all the non rdc addresses this tour visits in the order the are visited (excluding country code)'),
calendar_week BIGNUMERIC(38,0) OPTIONS(description='Calenderweek of GlobalParameters.DeliveryDateEnd'),
delivery_dt DATE NOT NULL OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'),
calc_dist BIGNUMERIC(38,10) OPTIONS(description='Distance traveled during the tour as calculated by the program'),
calc_dur STRING(512) OPTIONS(description='Duration of the tour'),
earliest_start_tmsp DATETIME OPTIONS(description='Earliest Start Time for the tour'),
end_tmsp DATETIME OPTIONS(description='End of a tour'),
tour_gid STRING(5000) NOT NULL
OPTIONS(description='GID is to have a unique identifier of a tour across different delivery days for the same RDC.'),
haulier_name STRING(512)
OPTIONS(description='Stores the value of the Haulier of the lowest resources (ID) within this tour with IsMotorVehicle = TRUE Attribute HaulierName on Tour'),
haulier_cmnt STRING(512) OPTIONS(description='User entered comment on the haulier for this route'),
tour_id STRING(512) OPTIONS(description='Quintiq generated Tour ID'),
license_plate STRING(512)
OPTIONS(description='User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour'),
license_plate_trailer STRING(512) OPTIONS(description='License plate of the trailer used for this tour'),
loaded_shipments BIGNUMERIC(38,10)
OPTIONS(description='Pallet positions at the start of the tour Attribute LoadedQuantity1 on Tour'),
observations STRING(512) OPTIONS(description='The last change/reason which was reported when editing tour information'),
resource_id STRING(512) OPTIONS(description='ID of the truck driven in this shift (trailer excluded)'),
resource_set_id STRING(512) NOT NULL OPTIONS(description='The ID of resource set used in a route'),
resource_tech STRING(512)
OPTIONS(description='Resource.ResourceTechnique.ID (if multiple Resources are used for the tour, show all resource techniques comma separated)'),
resource_type STRING(512)
OPTIONS(description='Resource.ResourceType.ID (if multiple Resources are used for the tour, show all resource types comma separated)'),
shift BIGNUMERIC(38,0)
OPTIONS(description='The shift to which the tour belongs. In case the driver swap is after the pickup actions and therefore the tour belongs to two shifts this attribute needs to contain the later shift.'),
tour_start_tmsp DATETIME OPTIONS(description='Start of a tour'),
calc_toll_dist2 BIGNUMERIC(38,10)
OPTIONS(description='Toll distance of type 2 traveled during the tour as calculated by the program'),
calc_toll_dist BIGNUMERIC(38,10)
OPTIONS(description='Toll distance traveled during the tour as calculated by the program'),
tour_cmnt STRING(512) OPTIONS(description='User entered comment for the tour'),
user_dist BIGNUMERIC(38,10) OPTIONS(description='User entered distance for the tour'),
user_dur STRING(512) OPTIONS(description='User entered duration for the tour'),
user_toll_dist2 BIGNUMERIC(38,10) OPTIONS(description='User entered toll distance of type 2 for the tour.'),
user_toll_dist BIGNUMERIC(38,10) OPTIONS(description='User entered toll distance for the tour.'),
indicatorstimetour STRING(512)
OPTIONS(description='Concatenation of all unique time indicators on tours related to this Shift'),
isboxrequired BOOL OPTIONS(description='True if a box is needed on tour level'),
isdeliveredinneededbox BOOL OPTIONS(description='True if one of the shipment legs needs a box delivery'),
isoneway BOOL
OPTIONS(description='True if the tour is used for one way, dismount resources at the end address(not RDC)'),
paidshift BOOL OPTIONS(description='True if the first tour in the shift is billable'),
costsperdistanceunit BIGNUMERIC(38,10) OPTIONS(description='The cost incurred per distance unit traveled'),
drivingdrivetypeid STRING(512) OPTIONS(description='ID of driving drive type'),
indicatorcost STRING(512)
OPTIONS(description='Concatenation of all unique cost indicators on tours related to this Shift'),
licenseplatetrailer2 STRING(512) OPTIONS(description='License plate of the second trailer used for this tour'),
tiko BOOL OPTIONS(description='True if there is at least one compartment in this tour that is frozen'),
tollcost BIGNUMERIC(38,10) OPTIONS(description='Costs spend on toll ways'),
tollcostcalculated BIGNUMERIC(38,10) OPTIONS(description='Costs spend on toll ways calculated by the system'),
tolldistance3calculated BIGNUMERIC(38,10)
OPTIONS(description='Toll distance of type 3 traveled during the tour as calculated by the program'),
toursequenceid STRING(512) OPTIONS(description='The SeqNr of the tour'),
trailer1drivetypeid STRING(512) OPTIONS(description='ID of trailer 1 drive type'),
trailer2drivetypeid STRING(512) OPTIONS(description='ID of trailer 2 drive type'),
usertolldistance3 BIGNUMERIC(38,10) OPTIONS(description='User entered toll distance of type 3 for the tour'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, resource_set_id, delivery_dt, tour_gid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Object type in quintiq is ReportedShift');