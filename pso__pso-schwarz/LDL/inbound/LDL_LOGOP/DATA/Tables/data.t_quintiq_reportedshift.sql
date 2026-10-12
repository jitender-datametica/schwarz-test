/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedshift
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedshift (
client_id 	   				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code',
lidl_country   				VARCHAR(3)   	NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila',
source_system  				VARCHAR(30)  	NOT NULL 	COMMENT 'Source system',
wh_id 		   				VARCHAR(5)   	NOT NULL 	COMMENT 'Warehouse ID',
address_id_seq				VARCHAR(5000)	NULL 	 	COMMENT 'Contains the IDs of all the non rdc addresses this tour visits in the order the are visited',
address_name_seq			VARCHAR(10000)	NULL 	 	COMMENT 'Contains the long names of all the non rdc addresses this tour visits in the order the are visited (excluding country code)',
calendar_week				NUMBER(38,0)	NULL	 	COMMENT 'Calenderweek of GlobalParameters.DeliveryDateEnd',
delivery_dt					DATE			NOT NULL 	COMMENT 'End of the delivery day to optimize for (max 24hrs after start).',
calc_dist					NUMBER(38,10)	NULL 	 	COMMENT 'Distance traveled during the tour as calculated by the program',
calc_dur					VARCHAR(512)	NULL     	COMMENT 'Duration of the tour',
earliest_start_tmsp			TIMESTAMP		NULL 	 	COMMENT 'Earliest Start Time for the tour',
end_tmsp					TIMESTAMP		NULL 	 	COMMENT 'End of a tour',
tour_gid					VARCHAR(5000)	NOT NULL 	COMMENT 'GID is to have a unique identifier of a tour across different delivery days for the same RDC.',
haulier_name				VARCHAR(512)	NULL 	 	COMMENT 'Stores the value of the Haulier of the lowest resources (ID) within this tour with IsMotorVehicle = TRUE Attribute HaulierName on Tour',
haulier_cmnt				VARCHAR(512)	NULL 	 	COMMENT 'User entered comment on the haulier for this route',
tour_id						VARCHAR(512)	NULL 	 	COMMENT 'Quintiq generated Tour ID',
license_plate				VARCHAR(512)	NULL 	 	COMMENT 'User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour',
license_plate_trailer		VARCHAR(512)	NULL 	 	COMMENT 'License plate of the trailer used for this tour',
loaded_shipments			NUMBER(38,10)	NULL 	 	COMMENT 'Pallet positions at the start of the tour Attribute LoadedQuantity1 on Tour',
observations            	VARCHAR(512)	NULL 	 	COMMENT 'The last change/reason which was reported when editing tour information',
resource_id             	VARCHAR(512)	NULL 	 	COMMENT 'ID of the truck driven in this shift (trailer excluded)',
resource_set_id         	VARCHAR(512)	NOT NULL 	COMMENT 'The ID of resource set used in a route',
resource_tech           	VARCHAR(512)	NULL 	 	COMMENT 'Resource.ResourceTechnique.ID (if multiple Resources are used for the tour, show all resource techniques comma separated)',
resource_type           	VARCHAR(512)	NULL 	 	COMMENT 'Resource.ResourceType.ID (if multiple Resources are used for the tour, show all resource types comma separated)',
shift                   	NUMBER(38,0)	NULL	 	COMMENT 'The shift to which the tour belongs. In case the driver swap is after the pickup actions and therefore the tour belongs to two shifts this attribute needs to contain the later shift.',
tour_start_tmsp         	TIMESTAMP		NULL 	 	COMMENT 'Start of a tour',
calc_toll_dist2         	NUMBER(38,10)	NULL 	 	COMMENT 'Toll distance of type 2 traveled during the tour as calculated by the program',
calc_toll_dist          	NUMBER(38,10)	NULL 	 	COMMENT 'Toll distance traveled during the tour as calculated by the program',
tour_cmnt               	VARCHAR(512)	NULL 	 	COMMENT 'User entered comment for the tour',
user_dist               	NUMBER(38,10)	NULL 	 	COMMENT 'User entered distance for the tour',
user_dur                	VARCHAR(512)	NULL 	 	COMMENT 'User entered duration for the tour',
user_toll_dist2         	NUMBER(38,10)	NULL 	 	COMMENT 'User entered toll distance of type 2 for the tour.',
user_toll_dist          	NUMBER(38,10)	NULL 	 	COMMENT 'User entered toll distance for the tour.',
indicatorstimetour			VARCHAR(512)	NULL 		COMMENT 'Concatenation of all unique time indicators on tours related to this Shift',
isboxrequired				BOOLEAN         NULL 		COMMENT 'True if a box is needed on tour level',
isdeliveredinneededbox		BOOLEAN         NULL 		COMMENT 'True if one of the shipment legs needs a box delivery',
isoneway					BOOLEAN         NULL 		COMMENT 'True if the tour is used for one way, dismount resources at the end address(not RDC)',
paidshift					BOOLEAN         NULL 		COMMENT 'True if the first tour in the shift is billable',
costsperdistanceunit		NUMBER(38,10)	NULL 		COMMENT 'The cost incurred per distance unit traveled',
drivingdrivetypeid			VARCHAR(512)	NULL 		COMMENT 'ID of driving drive type',
indicatorcost				VARCHAR(512)	NULL 		COMMENT 'Concatenation of all unique cost indicators on tours related to this Shift',
licenseplatetrailer2		VARCHAR(512)	NULL 		COMMENT 'License plate of the second trailer used for this tour',
tiko						BOOLEAN			NULL 		COMMENT 'True if there is at least one compartment in this tour that is frozen',
tollcost					NUMBER(38,10)	NULL 		COMMENT 'Costs spend on toll ways',
tollcostcalculated			NUMBER(38,10)	NULL 		COMMENT 'Costs spend on toll ways calculated by the system',
tolldistance3calculated		NUMBER(38,10)	NULL 		COMMENT 'Toll distance of type 3 traveled during the tour as calculated by the program',
toursequenceid				VARCHAR(512)	NULL 		COMMENT 'The SeqNr of the tour',
trailer1drivetypeid			VARCHAR(512)	NULL 		COMMENT 'ID of trailer 1 drive type',
trailer2drivetypeid			VARCHAR(512)	NULL 		COMMENT 'ID of trailer 2 drive type',
usertolldistance3			NUMBER(38,10)	NULL 		COMMENT 'User entered toll distance of type 3 for the tour',
dwh_load_id    				NUMBER(38,0)	NOT NULL 	COMMENT 'Load id',
dwh_created    				TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated    				TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 				DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to   				DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg     				BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id,wh_id,resource_set_id,delivery_dt,tour_gid,dwh_valid_from)
) COMMENT = 'Object type in quintiq is ReportedShift';