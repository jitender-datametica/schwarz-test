/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	V_QUINTIQ_REPORTEDTOUR_QI_1
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDTOUR_QI_1(
	 CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code'
	,LIDL_COUNTRY COMMENT 'Country_1 code. Original field name bic_zmlila'
	,SOURCE_SYSTEM COMMENT 'Source system'
	,WH_ID COMMENT 'Warehouse ID'
	,ADDRESS_ID_SEQ COMMENT 'Contains the IDs of all the non rdc addresses this tour_1 visits in the order the are visited'
	,ADDRESS_NAME_SEQ COMMENT 'Contains the long names of all the non rdc addresses this tour_1 visits in the order the are visited (excluding country_1 code)'
	,CALENDAR_WEEK COMMENT 'Calenderweek of GlobalParameters.DeliveryDateEnd'
	,DELIVERY_DT COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
	,CALC_DIST COMMENT 'Distance traveled during the tour_1 as calculated by the program'
	,CALC_DUR COMMENT 'Duration of the tour_1'
	,EARLIEST_START_TMSP COMMENT 'Earliest Start Time for the tour_1'
	,TOUR_GID COMMENT 'GID is to have a unique identifier of a tour_1 across different delivery days for the same RDC.'
	,STORE_DLV_FG COMMENT 'At least one shipment delivery to a store is planned'
	,HAULIER COMMENT 'Stores the value of the Haulier of the lowest resources (ID) within this tour_1 with IsMotorVehicle = TRUE Attribute HaulierName on Tour_1'
	,TOUR_ID COMMENT 'Quintiq generated Tour_1 ID'
	,LICENSE_PLATE COMMENT 'User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour_1'
	,LICENSE_PLATE_TRAILER COMMENT 'User entered license plate number of the trailer used for this the tour_1 Or its based on route Attribute LicensePlateTrailerCalc on Tour_1'
	,LOADED_SHIPMENTS COMMENT 'Pallet positions at the start of the tour_1 Attribute LoadedQuantity1 on Tour_1'
	,PRODUCT_TYPES_LIST COMMENT 'List of all the product types shipped as part of this tour_1'
	,RESOURCE_TECH COMMENT 'Resource.ResourceTechnique.ID (if multiple Resources are used for the tour_1, show all resoruce techniques comma separated)'
	,RESOURCE_TYPE COMMENT 'Resource.ResourceType.ID (if multiple Resources are used for the tour_1, show all resoruce types comma separated)'
	,TOUR_STATUS COMMENT 'The status_1 of this tour_1'
	,MAX_CAP_SUM COMMENT 'The sum of all max capacity 1 in the resources within this tour_1'
	,TOLL_COST COMMENT 'Toll cost'
	,CALC_TOLL_DIST2 COMMENT 'Toll distance of type 2 traveled during the tour_1 as calculated by the program'
	,CALC_TOLL_DIST COMMENT 'Toll distance traveled during the tour_1 as calculated by the program'
	,USER_DIST COMMENT 'User entered distance for the tour_1'
	,USER_DUR COMMENT 'User entered duration for the tour_1'
	,USER_SHIFT COMMENT 'The shift to which the tour_1 belongs. In case the driver swap is after the pickup actions and therefore the tour_1 belongs to two shifts this attribute needs to contain the later shift.'
	,USER_TOLL_DIST2 COMMENT 'User entered toll distance of type 2 for the tour_1'
	,USER_TOLL_DIST COMMENT 'User entered toll distance for the tour_1'
	,UTIL_PALLET_POS COMMENT 'Utilization of the pallet positions when leaving the RDC'
	,UTIL_PALLET_POS_ELKE COMMENT 'The utilization of the resources that are going to stores'
	,UTIL_NO_RETURN_ELKE COMMENT 'The overall utilization of pallet positions in a resource over distance driven per tour_1 that has store deliveries excluding the returns.'
	,DWH_LOAD_ID COMMENT 'Load id'
	,DWH_CREATED COMMENT 'Record created at'
	,DWH_UPDATED COMMENT 'Record updated at'
	,DWH_VALID_FROM COMMENT 'Valid from date'
	,DWH_VALID_TO COMMENT 'Valid to date'
	,DELETED_FG COMMENT 'Flag if record is deleted'
	,RESOURCESETID COMMENT 'The ID of the resource set'
	,INDICATORQUALITY COMMENT 'Name of the quality indicator'
	,USERTOLLDISTANCE3 COMMENT '[Overrule] User entered toll distance for the tour_1'
	,USERTRAILER1CONSUMPTION COMMENT 'Fuel/Energy consumption of trailer 1 as set by the user'
	,TOUREND COMMENT 'End of a tour. Original name: End'
	,TOTALNUM1APALLETSPLANNEDCONVERTED COMMENT 'The total quantity1 converted of 1a pallets planned on this tour_1 which are picked up at the RDC and delivered at a store'
	,USERTRAILER2CONSUMPTION COMMENT 'Fuel/Energy consumption of trailer 2 as set by the user'
	,TOTALNUM1BPALLETSPLANNED COMMENT 'The total quantity1 of 1b pallets (returns and transfers) planned on this tour_1 which are not delivered at a store'
	,TOLLDISTANCE3CALCULATED COMMENT 'Toll distance of type 3 travelled during the tour_1 as calculated by the program'
	,SUMMAXCAPACITY1CONVERTED COMMENT 'The sum of all max capacity 1 converted in the resources within this tour_1'
	,DRIVINGDRIVETYPEID COMMENT 'ID of driving drive type'
	,TRAILER2DRIVETYPEID COMMENT 'ID of trailer 2 drive type'
	,INDICATORTIMEUSER COMMENT 'Time indicator set by the user'
	,INDICATORSHIFTID COMMENT 'The unique identifier of shift indicator'
	,TOURSEQUENCEID COMMENT 'The SeqNr of the tour_1'
	,HAULIERID COMMENT 'The ID of the haulier'
	,USERDRIVINGCONSUMPTION COMMENT 'Fuel/Energy consumption of the motor vehicle as set by the user'
	,TOTALNUM1BPALLETSPLANNEDCONVERTED COMMENT 'The total quantity1 converted of 1b pallets (returns and transfers) planned on this tour_1 which are not delivered at a store'
	,TOTALNUM1APALLETSPLANNED COMMENT 'The total quantity1 of 1a pallets planned on this tour_1 which are picked up at the RDC and delivered at a store'
	,INDICATORQUALITYCOMMENT COMMENT 'A comment of the selected quality indicator'
	,INDICATORCOST COMMENT 'Name of the cost indicator'
	,TRAILER1DRIVETYPEID COMMENT 'ID of trailer 1 drive type'
	,LICENSEPLATETRAILER2 COMMENT 'User entered license plate number of the trailer used for this the tour_1 Or its based on route. Attribute LicensePlateTrailerCalc on Tour_1'
	,TOURSTART COMMENT 'Start of a tour. Original name: Start'
	,INDICATORADDRESS COMMENT 'Concatenation of all unique addresses indicators planned on this Tour_1'
	,TIKO COMMENT 'True if there is at least one compartment in this tour_1 that is frozen'
	,ISONEWAY COMMENT 'True if the tour_1 is used for one way, dismount resources at the end address_1(not RDC)'
	,TOTALNUMPALLETSWITHISDELIVERYTOEXTERNALWAREHOUSE COMMENT 'The total number of pallets for all shipment legs on this tour_1 which were delivered to an external warehouse'
	,TOTALNUMPALLETSWITHISDELIVERYTOINTERNALWAREHOUSE COMMENT 'The total number of pallets for all shipment legs on this tour_1 which were delivered to an internal warehouse'
	,TOTALNUMPALLETSWITHISDELIVERYTONONFOODWAREHOUSE COMMENT 'The total number of pallets for all shipment legs on this tour_1 which were delivered to a non food warehouse'
	,INDICATORCOSTAMOUNT COMMENT 'The amount of the cost indicator'
	,HASNONFOODWAREHOUSE COMMENT 'TRUE if at least one of the addresses visited in the tour_1 is a non food warehouse'
	,HASINTERNALWAREHOUSE COMMENT 'TRUE if at least one of the addresses visited in the tour_1 is an internal warehouse'
	,HASEXTERNALWAREHOUSE COMMENT 'TRUE if at least one of the addresses visited in the tour_1 is an external warehouse'
	,MEANSOFTRANSPORTID COMMENT 'A concatenation of the means of transport ID of the driving resource, trailer1 and trailer2'
	,MEANSOFTRANSPORTNAME COMMENT 'A concatenation of the means of transport name of the driving resource, trailer1 and trailer2'
	,INDICATORQUALITYIDS COMMENT 'Concatenated string of the IDs of all assigned quality indicators'
	,DISTANCEDRIVENACTUAL COMMENT 'The actual distance driven, received by Telematics'
) COMMENT='QUINTIQ - prepared view on raw data'
 AS
WITH FLTTND AS (
SELECT 
	 a.CLIENT_ID
	,a.LIDL_COUNTRY
	,a.SOURCE_SYSTEM
	,a.WH_ID
    ,a.TOUR_GID
	,a.DELIVERY_DT
	,a.DWH_LOAD_ID
	,a.DWH_CREATED
	,a.DWH_UPDATED
	,a.DWH_VALID_FROM
	,a.DWH_VALID_TO
	,a.DELETED_FG
    ,TO_VARCHAR(VALUE) AS INDICATORQUALITY
FROM DATA.T_QUINTIQ_REPORTEDTOUR_1 AS a,
LATERAL FLATTEN(INPUT => SPLIT(a.INDICATORQUALITY,';')) AS b
)
SELECT
	 A.CLIENT_ID
	,A.LIDL_COUNTRY
	,A.SOURCE_SYSTEM
	,A.WH_ID
	,A.ADDRESS_ID_SEQ
	,A.ADDRESS_NAME_SEQ
	,A.CALENDAR_WEEK
	,A.DELIVERY_DT
	,A.CALC_DIST
	,A.CALC_DUR
	,A.EARLIEST_START_TMSP
	,A.TOUR_GID
	,A.STORE_DLV_FG
	,A.HAULIER
	,A.TOUR_ID
	,A.LICENSE_PLATE
	,A.LICENSE_PLATE_TRAILER
	,A.LOADED_SHIPMENTS
	,A.PRODUCT_TYPES_LIST
	,A.RESOURCE_TECH
	,A.RESOURCE_TYPE
	,A.TOUR_STATUS
	,A.MAX_CAP_SUM
	,A.TOLLCOSTCALCULATED
	,A.CALC_TOLL_DIST2
	,A.CALC_TOLL_DIST
	,A.USER_DIST
	,A.USER_DUR
	,A.USER_SHIFT
	,A.USER_TOLL_DIST2
	,A.USER_TOLL_DIST
	,A.UTIL_PALLET_POS
	,A.UTIL_PALLET_POS_ELKE
	,A.UTIL_NO_RETURN_ELKE
	,A.DWH_LOAD_ID
	,A.DWH_CREATED
	,A.DWH_UPDATED
	,A.DWH_VALID_FROM
	,A.DWH_VALID_TO
	,A.DELETED_FG
	,A.RESOURCESETID
    ,CASE WHEN A.INDICATORQUALITY IS NULL THEN A.INDICATORQUALITY ELSE B.INDICATORQUALITY END AS INDICATORQUALITY
	,A.USERTOLLDISTANCE3
	,A.USERTRAILER1CONSUMPTION
	,A.TOUREND
	,A.TOTALNUM1APALLETSPLANNEDCONVERTED
	,A.USERTRAILER2CONSUMPTION
	,A.TOTALNUM1BPALLETSPLANNED
	,A.TOLLDISTANCE3CALCULATED
	,A.SUMMAXCAPACITY1CONVERTED
	,A.DRIVINGDRIVETYPEID
	,A.TRAILER2DRIVETYPEID
	,A.INDICATORTIMEUSER
	,A.INDICATORSHIFTID
	,A.TOURSEQUENCEID
	,A.HAULIERID
	,A.USERDRIVINGCONSUMPTION
	,A.TOTALNUM1BPALLETSPLANNEDCONVERTED
	,A.TOTALNUM1APALLETSPLANNED
	,A.INDICATORQUALITYCOMMENT
	,A.INDICATORCOST
	,A.TRAILER1DRIVETYPEID
	,A.LICENSEPLATETRAILER2
	,A.TOURSTART
	,A.INDICATORADDRESS
	,A.TIKO
	,A.ISONEWAY
	,A.TOTALNUMPALLETSWITHISDELIVERYTOEXTERNALWAREHOUSE
	,A.TOTALNUMPALLETSWITHISDELIVERYTOINTERNALWAREHOUSE
	,A.TOTALNUMPALLETSWITHISDELIVERYTONONFOODWAREHOUSE
	,A.INDICATORCOSTAMOUNT
	,A.HASNONFOODWAREHOUSE
	,A.HASINTERNALWAREHOUSE
	,A.HASEXTERNALWAREHOUSE
	,A.MEANSOFTRANSPORTID
	,A.MEANSOFTRANSPORTNAME
    ,A.INDICATORQUALITYIDS
    ,A.DISTANCEDRIVENACTUAL
FROM DATA.T_QUINTIQ_REPORTEDTOUR_1 A
LEFT JOIN FLTTND B
 ON  a.CLIENT_ID        = b.CLIENT_ID
 AND a.LIDL_COUNTRY     = b.LIDL_COUNTRY
 AND a.SOURCE_SYSTEM    = b.SOURCE_SYSTEM
 AND a.WH_ID            = b.WH_ID
 AND a.TOUR_GID         = b.TOUR_GID
 AND a.DELIVERY_DT      = b.DELIVERY_DT
 AND a.DWH_LOAD_ID      = b.DWH_LOAD_ID
 AND a.DWH_CREATED      = b.DWH_CREATED
 AND a.DWH_UPDATED      = b.DWH_UPDATED
 AND a.DWH_VALID_FROM   = b.DWH_VALID_FROM
 AND a.DWH_VALID_TO     = b.DWH_VALID_TO
 AND a.DELETED_FG       = b.DELETED_FG
;