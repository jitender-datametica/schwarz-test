/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedtour
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedtour (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_country
OPTIONS(description='Country code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), address_id_seq
OPTIONS(description='Contains the IDs of all the non rdc addresses this tour visits in the order the are visited'),
address_name_seq
OPTIONS(description='Contains the long names of all the non rdc addresses this tour visits in the order the are visited (excluding country code)'),
calendar_week OPTIONS(description='Calenderweek of GlobalParameters.DeliveryDateEnd'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), calc_dist
OPTIONS(description='Distance traveled during the tour as calculated by the program'), calc_dur
OPTIONS(description='Duration of the tour'), earliest_start_tmsp OPTIONS(description='Earliest Start Time for the tour'),
tour_gid
OPTIONS(description='GID is to have a unique identifier of a tour across different delivery days for the same RDC.'),
store_dlv_fg OPTIONS(description='At least one shipment delivery to a store is planned'), haulier
OPTIONS(description='Stores the value of the Haulier of the lowest resources (ID) within this tour with IsMotorVehicle = TRUE Attribute HaulierName on Tour'),
tour_id OPTIONS(description='Quintiq generated Tour ID'), license_plate
OPTIONS(description='User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour'),
license_plate_trailer
OPTIONS(description='User entered license plate number of the trailer used for this the tour Or its based on route Attribute LicensePlateTrailerCalc on Tour'),
loaded_shipments OPTIONS(description='Pallet positions at the start of the tour Attribute LoadedQuantity1 on Tour'),
product_types_list OPTIONS(description='List of all the product types shipped as part of this tour'), resource_tech
OPTIONS(description='Resource.ResourceTechnique.ID (if multiple Resources are used for the tour show all resoruce techniques comma separated)'),
resource_type
OPTIONS(description='Resource.ResourceType.ID (if multiple Resources are used for the tour show all resoruce types comma separated)'),
tour_status OPTIONS(description='The status of this tour'), max_cap_sum
OPTIONS(description='The sum of all max capacity 1 in the resources within this tour'), toll_cost
OPTIONS(description='Toll cost'), calc_toll_dist2
OPTIONS(description='Toll distance of type 2 traveled during the tour as calculated by the program'), calc_toll_dist
OPTIONS(description='Toll distance traveled during the tour as calculated by the program'), user_dist
OPTIONS(description='User entered distance for the tour'), user_dur
OPTIONS(description='User entered duration for the tour'), user_shift
OPTIONS(description='The shift to which the tour belongs. In case the driver swap is after the pickup actions and therefore the tour belongs to two shifts this attribute needs to contain the later shift.'),
user_toll_dist2 OPTIONS(description='User entered toll distance of type 2 for the tour'), user_toll_dist
OPTIONS(description='User entered toll distance for the tour'), util_pallet_pos
OPTIONS(description='Utilization of the pallet positions when leaving the RDC'), util_pallet_pos_elke
OPTIONS(description='The utilization of the resources that are going to stores'), util_no_return_elke
OPTIONS(description='The overall utilization of pallet positions in a resource over distance driven per tour that has store deliveries excluding the returns.'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'), resourcesetid
OPTIONS(description='The ID of the resource set'), indicatorquality OPTIONS(description='Name of the quality indicator'),
usertolldistance3 OPTIONS(description='[Overrule] User entered toll distance for the tour'), usertrailer1consumption
OPTIONS(description='Fuel/Energy consumption of trailer 1 as set by the user'), tourend
OPTIONS(description='End of a tour. Original name: End'), totalnum1apalletsplannedconverted
OPTIONS(description='The total quantity1 converted of 1a pallets planned on this tour which are picked up at the RDC and delivered at a store'),
usertrailer2consumption OPTIONS(description='Fuel/Energy consumption of trailer 2 as set by the user'),
totalnum1bpalletsplanned
OPTIONS(description='The total quantity1 of 1b pallets (returns and transfers) planned on this tour which are not delivered at a store'),
tolldistance3calculated
OPTIONS(description='Toll distance of type 3 travelled during the tour as calculated by the program'),
summaxcapacity1converted
OPTIONS(description='The sum of all max capacity 1 converted in the resources within this tour'), drivingdrivetypeid
OPTIONS(description='ID of driving drive type'), trailer2drivetypeid OPTIONS(description='ID of trailer 2 drive type'),
indicatortimeuser OPTIONS(description='Time indicator set by the user'), indicatorshiftid
OPTIONS(description='The unique identifier of shift indicator'), toursequenceid
OPTIONS(description='The SeqNr of the tour'), haulierid OPTIONS(description='The ID of the haulier'),
userdrivingconsumption OPTIONS(description='Fuel/Energy consumption of the motor vehicle as set by the user'),
totalnum1bpalletsplannedconverted
OPTIONS(description='The total quantity1 converted of 1b pallets (returns and transfers) planned on this tour which are not delivered at a store'),
totalnum1apalletsplanned
OPTIONS(description='The total quantity1 of 1a pallets planned on this tour which are picked up at the RDC and delivered at a store'),
indicatorqualitycomment OPTIONS(description='A comment of the selected quality indicator'), indicatorcost
OPTIONS(description='Name of the cost indicator'), trailer1drivetypeid OPTIONS(description='ID of trailer 1 drive type'),
licenseplatetrailer2
OPTIONS(description='User entered license plate number of the trailer used for this the tour Or its based on route. Attribute LicensePlateTrailerCalc on Tour'),
tourstart OPTIONS(description='Start of a tour. Original name: Start'), indicatoraddress
OPTIONS(description='Concatenation of all unique addresses indicators planned on this Tour'), tiko
OPTIONS(description='True if there is at least one compartment in this tour that is frozen'), isoneway
OPTIONS(description='True if the tour is used for one way dismount resources at the end address(not RDC)'),
totalnumpalletswithisdeliverytoexternalwarehouse
OPTIONS(description='The total number of pallets for all shipment legs on this tour which were delivered to an external warehouse'),
totalnumpalletswithisdeliverytointernalwarehouse
OPTIONS(description='The total number of pallets for all shipment legs on this tour which were delivered to an internal warehouse'),
totalnumpalletswithisdeliverytononfoodwarehouse
OPTIONS(description='The total number of pallets for all shipment legs on this tour which were delivered to a non food warehouse'),
indicatorcostamount OPTIONS(description='The amount of the cost indicator'), hasnonfoodwarehouse
OPTIONS(description='TRUE if at least one of the addresses visited in the tour is a non food warehouse'),
hasinternalwarehouse
OPTIONS(description='TRUE if at least one of the addresses visited in the tour is an internal warehouse'),
hasexternalwarehouse
OPTIONS(description='TRUE if at least one of the addresses visited in the tour is an external warehouse'),
meansoftransportid
OPTIONS(description='A concatenation of the means of transport ID of the driving resource trailer1 and trailer2'),
meansoftransportname
OPTIONS(description='A concatenation of the means of transport name of the driving resource trailer1 and trailer2'),
indicatorqualityids OPTIONS(description='Concatenated string of the IDs of all assigned quality indicators'),
distancedrivenactual OPTIONS(description='The actual distance driven received by Telematics'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 address_id_seq,
 address_name_seq,
 calendar_week,
 delivery_dt,
 calc_dist,
 calc_dur,
 earliest_start_tmsp,
 tour_gid,
 store_dlv_fg,
 haulier,
 tour_id,
 license_plate,
 license_plate_trailer,
 loaded_shipments,
 product_types_list,
 resource_tech,
 resource_type,
 tour_status,
 max_cap_sum,
 tollcostcalculated AS toll_cost,
 calc_toll_dist2,
 calc_toll_dist,
 user_dist,
 user_dur,
 user_shift,
 user_toll_dist2,
 user_toll_dist,
 util_pallet_pos,
 util_pallet_pos_elke,
 util_no_return_elke,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 resourcesetid,
 indicatorquality,
 usertolldistance3,
 usertrailer1consumption,
 tourend,
 totalnum1apalletsplannedconverted,
 usertrailer2consumption,
 totalnum1bpalletsplanned,
 tolldistance3calculated,
 summaxcapacity1converted,
 drivingdrivetypeid,
 trailer2drivetypeid,
 indicatortimeuser,
 indicatorshiftid,
 toursequenceid,
 haulierid,
 userdrivingconsumption,
 totalnum1bpalletsplannedconverted,
 totalnum1apalletsplanned,
 indicatorqualitycomment,
 indicatorcost,
 trailer1drivetypeid,
 licenseplatetrailer2,
 tourstart,
 indicatoraddress,
 tiko,
 isoneway,
 totalnumpalletswithisdeliverytoexternalwarehouse,
 totalnumpalletswithisdeliverytointernalwarehouse,
 totalnumpalletswithisdeliverytononfoodwarehouse,
 indicatorcostamount,
 hasnonfoodwarehouse,
 hasinternalwarehouse,
 hasexternalwarehouse,
 meansoftransportid,
 meansoftransportname,
 indicatorqualityids,
 distancedrivenactual
FROM ldl_logop_data.t_quintiq_reportedtour;