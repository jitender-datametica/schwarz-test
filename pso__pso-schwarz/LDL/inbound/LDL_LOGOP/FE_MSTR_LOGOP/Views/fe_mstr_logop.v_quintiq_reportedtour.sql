/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedtour
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDTOUR(
   CLIENT_ID COMMENT 'Client id - calculated based on the country code'
 , LIDL_COUNTRY COMMENT 'Country code. Original field name bic_zmlila'
 , SOURCE_SYSTEM COMMENT 'Source system'
 , WH_ID COMMENT 'Warehouse ID'
 , ADDRESS_ID_SEQ COMMENT 'Contains the IDs of all the non rdc addresses this tour visits in the order the are visited'
 , ADDRESS_NAME_SEQ COMMENT 'Contains the long names of all the non rdc addresses this tour visits in the order the are visited (excluding country code)'
 , CALENDAR_WEEK COMMENT 'Calenderweek of GlobalParameters.DeliveryDateEnd'
 , DELIVERY_DT COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
 , CALC_DIST COMMENT 'Distance traveled during the tour as calculated by the program'
 , CALC_DUR COMMENT 'Duration of the tour'
 , EARLIEST_START_TMSP COMMENT 'Earliest Start Time for the tour'
 , TOUR_GID COMMENT 'GID is to have a unique identifier of a tour across different delivery days for the same RDC.'
 , STORE_DLV_FG COMMENT 'At least one shipment delivery to a store is planned'
 , HAULIER COMMENT 'Stores the value of the Haulier of the lowest resources (ID) within this tour with IsMotorVehicle = TRUE Attribute HaulierName on Tour'
 , TOUR_ID COMMENT 'Quintiq generated Tour ID'
 , LICENSE_PLATE COMMENT 'User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour'
 , LICENSE_PLATE_TRAILER COMMENT 'User entered license plate number of the trailer used for this the tour Or its based on route Attribute LicensePlateTrailerCalc on Tour'
 , LOADED_SHIPMENTS COMMENT 'Pallet positions at the start of the tour Attribute LoadedQuantity1 on Tour'
 , PRODUCT_TYPES_LIST COMMENT 'List of all the product types shipped as part of this tour'
 , RESOURCE_TECH COMMENT 'Resource.ResourceTechnique.ID (if multiple Resources are used for the tour show all resoruce techniques comma separated)'
 , RESOURCE_TYPE COMMENT 'Resource.ResourceType.ID (if multiple Resources are used for the tour show all resoruce types comma separated)'
 , TOUR_STATUS COMMENT 'The status of this tour'
 , MAX_CAP_SUM COMMENT 'The sum of all max capacity 1 in the resources within this tour'
 , TOLL_COST COMMENT 'Toll cost'
 , CALC_TOLL_DIST2 COMMENT 'Toll distance of type 2 traveled during the tour as calculated by the program'
 , CALC_TOLL_DIST COMMENT 'Toll distance traveled during the tour as calculated by the program'
 , USER_DIST COMMENT 'User entered distance for the tour'
 , USER_DUR COMMENT 'User entered duration for the tour'
 , USER_SHIFT COMMENT 'The shift to which the tour belongs. In case the driver swap is after the pickup actions and therefore the tour belongs to two shifts this attribute needs to contain the later shift.'
 , USER_TOLL_DIST2 COMMENT 'User entered toll distance of type 2 for the tour'
 , USER_TOLL_DIST COMMENT 'User entered toll distance for the tour'
 , UTIL_PALLET_POS COMMENT 'Utilization of the pallet positions when leaving the RDC'
 , UTIL_PALLET_POS_ELKE COMMENT 'The utilization of the resources that are going to stores'
 , UTIL_NO_RETURN_ELKE COMMENT 'The overall utilization of pallet positions in a resource over distance driven per tour that has store deliveries excluding the returns.'
 , DWH_LOAD_ID COMMENT 'Load id'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , DWH_VALID_FROM COMMENT 'Valid from date'
 , DWH_VALID_TO COMMENT 'Valid to date'
 , DELETED_FG COMMENT 'Flag if record is deleted'
 , RESOURCESETID COMMENT 'The ID of the resource set'
 , INDICATORQUALITY COMMENT 'Name of the quality indicator'
 , USERTOLLDISTANCE3 COMMENT '[Overrule] User entered toll distance for the tour'
 , USERTRAILER1CONSUMPTION COMMENT 'Fuel/Energy consumption of trailer 1 as set by the user'
 , TOUREND COMMENT 'End of a tour. Original name: End'
 , TOTALNUM1APALLETSPLANNEDCONVERTED COMMENT 'The total quantity1 converted of 1a pallets planned on this tour which are picked up at the RDC and delivered at a store'
 , USERTRAILER2CONSUMPTION COMMENT 'Fuel/Energy consumption of trailer 2 as set by the user'
 , TOTALNUM1BPALLETSPLANNED COMMENT 'The total quantity1 of 1b pallets (returns and transfers) planned on this tour which are not delivered at a store'
 , TOLLDISTANCE3CALCULATED COMMENT 'Toll distance of type 3 travelled during the tour as calculated by the program'
 , SUMMAXCAPACITY1CONVERTED COMMENT 'The sum of all max capacity 1 converted in the resources within this tour'
 , DRIVINGDRIVETYPEID COMMENT 'ID of driving drive type'
 , TRAILER2DRIVETYPEID COMMENT 'ID of trailer 2 drive type'
 , INDICATORTIMEUSER COMMENT 'Time indicator set by the user'
 , INDICATORSHIFTID COMMENT 'The unique identifier of shift indicator'
 , TOURSEQUENCEID COMMENT 'The SeqNr of the tour'
 , HAULIERID COMMENT 'The ID of the haulier'
 , USERDRIVINGCONSUMPTION COMMENT 'Fuel/Energy consumption of the motor vehicle as set by the user'
 , TOTALNUM1BPALLETSPLANNEDCONVERTED COMMENT 'The total quantity1 converted of 1b pallets (returns and transfers) planned on this tour which are not delivered at a store'
 , TOTALNUM1APALLETSPLANNED COMMENT 'The total quantity1 of 1a pallets planned on this tour which are picked up at the RDC and delivered at a store'
 , INDICATORQUALITYCOMMENT COMMENT 'A comment of the selected quality indicator'
 , INDICATORCOST COMMENT 'Name of the cost indicator'
 , TRAILER1DRIVETYPEID COMMENT 'ID of trailer 1 drive type'
 , LICENSEPLATETRAILER2 COMMENT 'User entered license plate number of the trailer used for this the tour Or its based on route. Attribute LicensePlateTrailerCalc on Tour'
 , TOURSTART COMMENT 'Start of a tour. Original name: Start'
 , INDICATORADDRESS COMMENT 'Concatenation of all unique addresses indicators planned on this Tour'
 , TIKO COMMENT 'True if there is at least one compartment in this tour that is frozen'
 , ISONEWAY COMMENT 'True if the tour is used for one way dismount resources at the end address(not RDC)'
 , TOTALNUMPALLETSWITHISDELIVERYTOEXTERNALWAREHOUSE COMMENT 'The total number of pallets for all shipment legs on this tour which were delivered to an external warehouse'
 , TOTALNUMPALLETSWITHISDELIVERYTOINTERNALWAREHOUSE COMMENT 'The total number of pallets for all shipment legs on this tour which were delivered to an internal warehouse'
 , TOTALNUMPALLETSWITHISDELIVERYTONONFOODWAREHOUSE COMMENT 'The total number of pallets for all shipment legs on this tour which were delivered to a non food warehouse'
 , INDICATORCOSTAMOUNT COMMENT 'The amount of the cost indicator'
 , HASNONFOODWAREHOUSE COMMENT 'TRUE if at least one of the addresses visited in the tour is a non food warehouse'
 , HASINTERNALWAREHOUSE COMMENT 'TRUE if at least one of the addresses visited in the tour is an internal warehouse'
 , HASEXTERNALWAREHOUSE COMMENT 'TRUE if at least one of the addresses visited in the tour is an external warehouse'
 , MEANSOFTRANSPORTID COMMENT 'A concatenation of the means of transport ID of the driving resource trailer1 and trailer2'
 , MEANSOFTRANSPORTNAME COMMENT 'A concatenation of the means of transport name of the driving resource trailer1 and trailer2'
 , INDICATORQUALITYIDS COMMENT 'Concatenated string of the IDs of all assigned quality indicators'
 , DISTANCEDRIVENACTUAL COMMENT 'The actual distance driven received by Telematics'
) COMMENT='QUINTIQ - prepared view on raw data'
 AS 
SELECT
   CLIENT_ID
 , LIDL_COUNTRY
 , SOURCE_SYSTEM
 , WH_ID
 , ADDRESS_ID_SEQ
 , ADDRESS_NAME_SEQ
 , CALENDAR_WEEK
 , DELIVERY_DT
 , CALC_DIST
 , CALC_DUR
 , EARLIEST_START_TMSP
 , TOUR_GID
 , STORE_DLV_FG
 , HAULIER
 , TOUR_ID
 , LICENSE_PLATE
 , LICENSE_PLATE_TRAILER
 , LOADED_SHIPMENTS
 , PRODUCT_TYPES_LIST
 , RESOURCE_TECH
 , RESOURCE_TYPE
 , TOUR_STATUS
 , MAX_CAP_SUM
 , TOLLCOSTCALCULATED
 , CALC_TOLL_DIST2
 , CALC_TOLL_DIST
 , USER_DIST
 , USER_DUR
 , USER_SHIFT
 , USER_TOLL_DIST2
 , USER_TOLL_DIST
 , UTIL_PALLET_POS
 , UTIL_PALLET_POS_ELKE
 , UTIL_NO_RETURN_ELKE
 , DWH_LOAD_ID
 , DWH_CREATED
 , DWH_UPDATED
 , DWH_VALID_FROM
 , DWH_VALID_TO
 , DELETED_FG
 , RESOURCESETID
 , INDICATORQUALITY
 , USERTOLLDISTANCE3
 , USERTRAILER1CONSUMPTION
 , TOUREND
 , TOTALNUM1APALLETSPLANNEDCONVERTED
 , USERTRAILER2CONSUMPTION
 , TOTALNUM1BPALLETSPLANNED
 , TOLLDISTANCE3CALCULATED
 , SUMMAXCAPACITY1CONVERTED
 , DRIVINGDRIVETYPEID
 , TRAILER2DRIVETYPEID
 , INDICATORTIMEUSER
 , INDICATORSHIFTID
 , TOURSEQUENCEID
 , HAULIERID
 , USERDRIVINGCONSUMPTION
 , TOTALNUM1BPALLETSPLANNEDCONVERTED
 , TOTALNUM1APALLETSPLANNED
 , INDICATORQUALITYCOMMENT
 , INDICATORCOST
 , TRAILER1DRIVETYPEID
 , LICENSEPLATETRAILER2
 , TOURSTART
 , INDICATORADDRESS
 , TIKO
 , ISONEWAY
 , TOTALNUMPALLETSWITHISDELIVERYTOEXTERNALWAREHOUSE
 , TOTALNUMPALLETSWITHISDELIVERYTOINTERNALWAREHOUSE
 , TOTALNUMPALLETSWITHISDELIVERYTONONFOODWAREHOUSE
 , INDICATORCOSTAMOUNT
 , HASNONFOODWAREHOUSE
 , HASINTERNALWAREHOUSE
 , HASEXTERNALWAREHOUSE
 , MEANSOFTRANSPORTID
 , MEANSOFTRANSPORTNAME
 , INDICATORQUALITYIDS
 , DISTANCEDRIVENACTUAL
FROM DATA.T_QUINTIQ_REPORTEDTOUR;