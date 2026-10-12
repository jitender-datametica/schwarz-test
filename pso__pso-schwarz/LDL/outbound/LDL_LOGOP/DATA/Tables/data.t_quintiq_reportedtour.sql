/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedtour
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedtour (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
address_id_seq STRING(5000)
OPTIONS(description='Contains the IDs of all the non rdc addresses this tour visits in the order the are visited'),
address_name_seq STRING(5000)
OPTIONS(description='Contains the long names of all the non rdc addresses this tour visits in the order the are visited (excluding country code)'),
calendar_week BIGNUMERIC(38,0) OPTIONS(description='Calenderweek of GlobalParameters.DeliveryDateEnd'),
delivery_dt DATE OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'),
calc_dist BIGNUMERIC(38,10) OPTIONS(description='Distance traveled during the tour as calculated by the program'),
calc_dur STRING(512) OPTIONS(description='Duration of the tour'),
earliest_start_tmsp DATETIME OPTIONS(description='Earliest Start Time for the tour'),
tour_gid STRING(5000) NOT NULL
OPTIONS(description='GID is to have a unique identifier of a tour across different delivery days for the same RDC.'),
store_dlv_fg BOOL OPTIONS(description='At least one shipment delivery to a store is planned'),
haulier STRING(512)
OPTIONS(description='Stores the value of the Haulier of the lowest resources (ID) within this tour with IsMotorVehicle = TRUE Attribute HaulierName on Tour'),
tour_id STRING(5000) OPTIONS(description='Quintiq generated Tour ID'),
license_plate STRING(512)
OPTIONS(description='User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour'),
license_plate_trailer STRING(512)
OPTIONS(description='User entered license plate number of the trailer used for this the tour Or its based on route Attribute LicensePlateTrailerCalc on Tour'),
loaded_shipments BIGNUMERIC(38,10)
OPTIONS(description='Pallet positions at the start of the tour Attribute LoadedQuantity1 on Tour'),
product_types_list STRING(512) OPTIONS(description='List of all the product types shipped as part of this tour'),
resource_tech STRING(512)
OPTIONS(description='Resource.ResourceTechnique.ID (if multiple Resources are used for the tour, show all resoruce techniques comma separated)'),
resource_type STRING(512)
OPTIONS(description='Resource.ResourceType.ID (if multiple Resources are used for the tour, show all resoruce types comma separated)'),
tour_status STRING(512) OPTIONS(description='The status of this tour'),
max_cap_sum BIGNUMERIC(38,10) OPTIONS(description='The sum of all max capacity 1 in the resources within this tour'),
tollcostcalculated BIGNUMERIC(38,10) OPTIONS(description='Toll cost'),
calc_toll_dist2 BIGNUMERIC(38,10)
OPTIONS(description='Toll distance of type 2 traveled during the tour as calculated by the program'),
calc_toll_dist BIGNUMERIC(38,10)
OPTIONS(description='Toll distance traveled during the tour as calculated by the program'),
user_dist BIGNUMERIC(38,10) OPTIONS(description='User entered distance for the tour'),
user_dur STRING(512) OPTIONS(description='User entered duration for the tour'),
user_shift BIGNUMERIC(38,0)
OPTIONS(description='The shift to which the tour belongs. In case the driver swap is after the pickup actions and therefore the tour belongs to two shifts this attribute needs to contain the later shift.'),
user_toll_dist2 BIGNUMERIC(38,10) OPTIONS(description='User entered toll distance of type 2 for the tour'),
user_toll_dist BIGNUMERIC(38,10) OPTIONS(description='User entered toll distance for the tour'),
util_pallet_pos BIGNUMERIC(38,10) OPTIONS(description='Utilization of the pallet positions when leaving the RDC'),
util_pallet_pos_elke BIGNUMERIC(38,10) OPTIONS(description='The utilization of the resources that are going to stores'),
util_no_return_elke BIGNUMERIC(38,10)
OPTIONS(description='The overall utilization of pallet positions in a resource over distance driven per tour that has store deliveries excluding the returns.'),
resourcesetid STRING(512) OPTIONS(description='The ID of the resource set'),
indicatorquality STRING(512) OPTIONS(description='Name of the quality indicator'),
usertolldistance3 BIGNUMERIC(38,10) OPTIONS(description='[Overrule] User entered toll distance for the tour'),
usertrailer1consumption BIGNUMERIC(38,10) OPTIONS(description='Fuel/Energy consumption of trailer 1 as set by the user'),
tourend DATETIME OPTIONS(description='End of a tour. Original name: End'),
totalnum1apalletsplannedconverted BIGNUMERIC(38,10)
OPTIONS(description='The total quantity1 converted of 1a pallets planned on this tour which are picked up at the RDC and delivered at a store'),
usertrailer2consumption BIGNUMERIC(38,10) OPTIONS(description='Fuel/Energy consumption of trailer 2 as set by the user'),
totalnum1bpalletsplanned BIGNUMERIC(38,10)
OPTIONS(description='The total quantity1 of 1b pallets (returns and transfers) planned on this tour which are not delivered at a store'),
tolldistance3calculated BIGNUMERIC(38,10)
OPTIONS(description='Toll distance of type 3 travelled during the tour as calculated by the program'),
summaxcapacity1converted BIGNUMERIC(38,10)
OPTIONS(description='The sum of all max capacity 1 converted in the resources within this tour'),
drivingdrivetypeid STRING(512) OPTIONS(description='ID of driving drive type'),
trailer2drivetypeid STRING(512) OPTIONS(description='ID of trailer 2 drive type'),
indicatortimeuser STRING(512) OPTIONS(description='Time indicator set by the user'),
indicatorshiftid STRING(512) OPTIONS(description='The unique identifier of shift indicator'),
toursequenceid BIGNUMERIC(38,0) OPTIONS(description='The SeqNr of the tour'),
haulierid STRING(512) OPTIONS(description='The ID of the haulier'),
userdrivingconsumption BIGNUMERIC(38,10)
OPTIONS(description='Fuel/Energy consumption of the motor vehicle as set by the user'),
totalnum1bpalletsplannedconverted BIGNUMERIC(38,10)
OPTIONS(description='The total quantity1 converted of 1b pallets (returns and transfers) planned on this tour which are not delivered at a store'),
totalnum1apalletsplanned BIGNUMERIC(38,10)
OPTIONS(description='The total quantity1 of 1a pallets planned on this tour which are picked up at the RDC and delivered at a store'),
indicatorqualitycomment STRING(512) OPTIONS(description='A comment of the selected quality indicator'),
indicatorcost STRING(512) OPTIONS(description='Name of the cost indicator'),
trailer1drivetypeid STRING(512) OPTIONS(description='ID of trailer 1 drive type'),
licenseplatetrailer2 STRING(512)
OPTIONS(description='User entered license plate number of the trailer used for this the tour Or its based on route. Attribute LicensePlateTrailerCalc on Tour'),
tourstart DATETIME OPTIONS(description='Start of a tour. Original name: Start'),
indicatoraddress STRING(512)
OPTIONS(description='Concatenation of all unique addresses indicators planned on this Tour'),
tiko BOOL OPTIONS(description='True if there is at least one compartment in this tour that is frozen'),
isoneway BOOL
OPTIONS(description='True if the tour is used for one way, dismount resources at the end address(not RDC)'),
totalnumpalletswithisdeliverytoexternalwarehouse BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets for all shipment legs on this tour which were delivered to an external warehouse'),
totalnumpalletswithisdeliverytointernalwarehouse BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets for all shipment legs on this tour which were delivered to an internal warehouse'),
totalnumpalletswithisdeliverytononfoodwarehouse BIGNUMERIC(38,10)
OPTIONS(description='The total number of pallets for all shipment legs on this tour which were delivered to a non food warehouse'),
indicatorcostamount BIGNUMERIC(38,10) OPTIONS(description='The amount of the cost indicator'),
hasnonfoodwarehouse BOOL
OPTIONS(description='TRUE if at least one of the addresses visited in the tour is a non food warehouse'),
hasinternalwarehouse BOOL
OPTIONS(description='TRUE if at least one of the addresses visited in the tour is an internal warehouse'),
hasexternalwarehouse BOOL
OPTIONS(description='TRUE if at least one of the addresses visited in the tour is an external warehouse'),
meansoftransportid STRING(512)
OPTIONS(description='A concatenation of the means of transport ID of the driving resource, trailer1 and trailer2'),
meansoftransportname STRING(512)
OPTIONS(description='A concatenation of the means of transport name of the driving resource, trailer1 and trailer2'),
indicatorqualityids STRING(512) OPTIONS(description='Concatenated string of the IDs of all assigned quality indicators'),
distancedrivenactual BIGNUMERIC(38,10) OPTIONS(description='The actual distance driven, received by Telematics'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, tour_gid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Object type in quintiq is ReportedTour Stores tours that are reported');