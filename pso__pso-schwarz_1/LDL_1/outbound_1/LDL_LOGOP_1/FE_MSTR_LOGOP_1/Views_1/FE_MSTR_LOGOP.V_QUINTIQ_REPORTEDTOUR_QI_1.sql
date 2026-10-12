/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	V_QUINTIQ_REPORTEDTOUR_QI_1
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/



CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedtour_qi_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), address_id_seq
OPTIONS(description='Contains the IDs of all the non rdc addresses this tour_1 visits in the order the are visited'),
address_name_seq
OPTIONS(description='Contains the long names of all the non rdc addresses this tour_1 visits in the order the are visited (excluding country_1 code)'),
calendar_week OPTIONS(description='Calenderweek of GlobalParameters.DeliveryDateEnd'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), calc_dist
OPTIONS(description='Distance traveled during the tour_1 as calculated by the program'), calc_dur
OPTIONS(description='Duration of the tour_1'), earliest_start_tmsp OPTIONS(description='Earliest Start Time for the tour_1'),
tour_gid
OPTIONS(description='GID is to have a unique identifier of a tour_1 across different delivery days for the same RDC.'),
store_dlv_fg OPTIONS(description='At least one shipment delivery to a store is planned'), haulier
OPTIONS(description='Stores the value of the Haulier of the lowest resources (ID) within this tour_1 with IsMotorVehicle = TRUE Attribute HaulierName on Tour_1'),
tour_id OPTIONS(description='Quintiq generated Tour_1 ID'), license_plate
OPTIONS(description='User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour_1'),
license_plate_trailer
OPTIONS(description='User entered license plate number of the trailer used for this the tour_1 Or its based on route Attribute LicensePlateTrailerCalc on Tour_1'),
loaded_shipments OPTIONS(description='Pallet positions at the start of the tour_1 Attribute LoadedQuantity1 on Tour_1'),
product_types_list OPTIONS(description='List of all the product types shipped as part of this tour_1'), resource_tech
OPTIONS(description='Resource.ResourceTechnique.ID (if multiple Resources are used for the tour_1, show all resoruce techniques comma separated)'),
resource_type
OPTIONS(description='Resource.ResourceType.ID (if multiple Resources are used for the tour_1, show all resoruce types comma separated)'),
tour_status OPTIONS(description='The status_1 of this tour_1'), max_cap_sum
OPTIONS(description='The sum of all max capacity 1 in the resources within this tour_1'), toll_cost
OPTIONS(description='Toll cost'), calc_toll_dist2
OPTIONS(description='Toll distance of type 2 traveled during the tour_1 as calculated by the program'), calc_toll_dist
OPTIONS(description='Toll distance traveled during the tour_1 as calculated by the program'), user_dist
OPTIONS(description='User entered distance for the tour_1'), user_dur
OPTIONS(description='User entered duration for the tour_1'), user_shift
OPTIONS(description='The shift to which the tour_1 belongs. In case the driver swap is after the pickup actions and therefore the tour_1 belongs to two shifts this attribute needs to contain the later shift.'),
user_toll_dist2 OPTIONS(description='User entered toll distance of type 2 for the tour_1'), user_toll_dist
OPTIONS(description='User entered toll distance for the tour_1'), util_pallet_pos
OPTIONS(description='Utilization of the pallet positions when leaving the RDC'), util_pallet_pos_elke
OPTIONS(description='The utilization of the resources that are going to stores'), util_no_return_elke
OPTIONS(description='The overall utilization of pallet positions in a resource over distance driven per tour_1 that has store deliveries excluding the returns.'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'), resourcesetid
OPTIONS(description='The ID of the resource set'), indicatorquality OPTIONS(description='Name of the quality indicator'),
usertolldistance3 OPTIONS(description='[Overrule] User entered toll distance for the tour_1'), usertrailer1consumption
OPTIONS(description='Fuel/Energy consumption of trailer 1 as set by the user'), tourend
OPTIONS(description='End of a tour. Original name: End'), totalnum1apalletsplannedconverted
OPTIONS(description='The total quantity1 converted of 1a pallets planned on this tour_1 which are picked up at the RDC and delivered at a store'),
usertrailer2consumption OPTIONS(description='Fuel/Energy consumption of trailer 2 as set by the user'),
totalnum1bpalletsplanned
OPTIONS(description='The total quantity1 of 1b pallets (returns and transfers) planned on this tour_1 which are not delivered at a store'),
tolldistance3calculated
OPTIONS(description='Toll distance of type 3 travelled during the tour_1 as calculated by the program'),
summaxcapacity1converted
OPTIONS(description='The sum of all max capacity 1 converted in the resources within this tour_1'), drivingdrivetypeid
OPTIONS(description='ID of driving drive type'), trailer2drivetypeid OPTIONS(description='ID of trailer 2 drive type'),
indicatortimeuser OPTIONS(description='Time indicator set by the user'), indicatorshiftid
OPTIONS(description='The unique identifier of shift indicator'), toursequenceid
OPTIONS(description='The SeqNr of the tour_1'), haulierid OPTIONS(description='The ID of the haulier'),
userdrivingconsumption OPTIONS(description='Fuel/Energy consumption of the motor vehicle as set by the user'),
totalnum1bpalletsplannedconverted
OPTIONS(description='The total quantity1 converted of 1b pallets (returns and transfers) planned on this tour_1 which are not delivered at a store'),
totalnum1apalletsplanned
OPTIONS(description='The total quantity1 of 1a pallets planned on this tour_1 which are picked up at the RDC and delivered at a store'),
indicatorqualitycomment OPTIONS(description='A comment of the selected quality indicator'), indicatorcost
OPTIONS(description='Name of the cost indicator'), trailer1drivetypeid OPTIONS(description='ID of trailer 1 drive type'),
licenseplatetrailer2
OPTIONS(description='User entered license plate number of the trailer used for this the tour_1 Or its based on route. Attribute LicensePlateTrailerCalc on Tour_1'),
tourstart OPTIONS(description='Start of a tour. Original name: Start'), indicatoraddress
OPTIONS(description='Concatenation of all unique addresses indicators planned on this Tour_1'), tiko
OPTIONS(description='True if there is at least one compartment in this tour_1 that is frozen'), isoneway
OPTIONS(description='True if the tour_1 is used for one way, dismount resources at the end address_1(not RDC)'),
totalnumpalletswithisdeliverytoexternalwarehouse
OPTIONS(description='The total number of pallets for all shipment legs on this tour_1 which were delivered to an external warehouse'),
totalnumpalletswithisdeliverytointernalwarehouse
OPTIONS(description='The total number of pallets for all shipment legs on this tour_1 which were delivered to an internal warehouse'),
totalnumpalletswithisdeliverytononfoodwarehouse
OPTIONS(description='The total number of pallets for all shipment legs on this tour_1 which were delivered to a non food warehouse'),
indicatorcostamount OPTIONS(description='The amount of the cost indicator'), hasnonfoodwarehouse
OPTIONS(description='TRUE if at least one of the addresses visited in the tour_1 is a non food warehouse'),
hasinternalwarehouse
OPTIONS(description='TRUE if at least one of the addresses visited in the tour_1 is an internal warehouse'),
hasexternalwarehouse
OPTIONS(description='TRUE if at least one of the addresses visited in the tour_1 is an external warehouse'),
meansoftransportid
OPTIONS(description='A concatenation of the means of transport ID of the driving resource, trailer1 and trailer2'),
meansoftransportname
OPTIONS(description='A concatenation of the means of transport name of the driving resource, trailer1 and trailer2'),
indicatorqualityids OPTIONS(description='Concatenated string of the IDs of all assigned quality indicators'),
distancedrivenactual OPTIONS(description='The actual distance driven, received by Telematics'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS WITH FLTTND AS (SELECT A0.client_id,
   A0.lidl_country,
   A0.source_system,
   A0.wh_id,
   A0.tour_gid,
   A0.delivery_dt,
   A0.dwh_load_id,
   A0.dwh_created,
   A0.dwh_updated,
   A0.dwh_valid_from,
   A0.dwh_valid_to,
   A0.deleted_fg,
   B AS indicatorquality
  FROM ldl_logop_data.t_quintiq_reportedtour_1 AS A0,
   UNNEST(SPLIT(A0.INDICATORQUALITY, ';')) AS B ) (SELECT A.client_id,
   A.lidl_country,
   A.source_system,
   A.wh_id,
   A.address_id_seq,
   A.address_name_seq,
   A.calendar_week,
   A.delivery_dt,
   A.calc_dist,
   A.calc_dur,
   A.earliest_start_tmsp,
   A.tour_gid,
   A.store_dlv_fg,
   A.haulier,
   A.tour_id,
   A.license_plate,
   A.license_plate_trailer,
   A.loaded_shipments,
   A.product_types_list,
   A.resource_tech,
   A.resource_type,
   A.tour_status,
   A.max_cap_sum,
   A.tollcostcalculated,
   A.calc_toll_dist2,
   A.calc_toll_dist,
   A.user_dist,
   A.user_dur,
   A.user_shift,
   A.user_toll_dist2,
   A.user_toll_dist,
   A.util_pallet_pos,
   A.util_pallet_pos_elke,
   A.util_no_return_elke,
   A.dwh_load_id,
   A.dwh_created,
   A.dwh_updated,
   A.dwh_valid_from,
   A.dwh_valid_to,
   A.deleted_fg,
   A.resourcesetid,
    CASE
    WHEN A.indicatorquality IS NULL
    THEN A.indicatorquality
    ELSE B.indicatorquality
    END AS indicatorquality,
   A.usertolldistance3,
   A.usertrailer1consumption,
   A.tourend,
   A.totalnum1apalletsplannedconverted,
   A.usertrailer2consumption,
   A.totalnum1bpalletsplanned,
   A.tolldistance3calculated,
   A.summaxcapacity1converted,
   A.drivingdrivetypeid,
   A.trailer2drivetypeid,
   A.indicatortimeuser,
   A.indicatorshiftid,
   A.toursequenceid,
   A.haulierid,
   A.userdrivingconsumption,
   A.totalnum1bpalletsplannedconverted,
   A.totalnum1apalletsplanned,
   A.indicatorqualitycomment,
   A.indicatorcost,
   A.trailer1drivetypeid,
   A.licenseplatetrailer2,
   A.tourstart,
   A.indicatoraddress,
   A.tiko,
   A.isoneway,
   A.totalnumpalletswithisdeliverytoexternalwarehouse,
   A.totalnumpalletswithisdeliverytointernalwarehouse,
   A.totalnumpalletswithisdeliverytononfoodwarehouse,
   A.indicatorcostamount,
   A.hasnonfoodwarehouse,
   A.hasinternalwarehouse,
   A.hasexternalwarehouse,
   A.meansoftransportid,
   A.meansoftransportname,
   A.indicatorqualityids,
   A.distancedrivenactual
  FROM ldl_logop_data.t_quintiq_reportedtour_1 AS A
   LEFT JOIN FLTTND AS B ON A.client_id = B.client_id AND A.lidl_country = B.lidl_country AND A.source_system = B.source_system
               AND A.wh_id = B.wh_id AND A.tour_gid = B.tour_gid AND A.delivery_dt = B.delivery_dt AND A.dwh_load_id = B
          .dwh_load_id AND A.dwh_created = B.dwh_created AND A.dwh_updated = B.dwh_updated AND A.dwh_valid_from = B.dwh_valid_from
        AND A.dwh_valid_to = B.dwh_valid_to AND A.deleted_fg = B.deleted_fg);


