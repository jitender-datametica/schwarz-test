/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedshift_2
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDSHIFT_2(
   CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code'
 , LIDL_COUNTRY COMMENT 'Country_2 code. Original field name bic_zmlila'
 , SOURCE_SYSTEM COMMENT 'Source system'
 , WH_ID COMMENT 'Warehouse ID'
 , ADDRESS_ID_SEQ COMMENT 'Contains the IDs of all the non rdc addresses this tour_2 visits in the order the are visited'
 , ADDRESS_NAME_SEQ COMMENT 'Contains the long names of all the non rdc addresses this tour_2 visits in the order the are visited (excluding country_2 code)'
 , CALENDAR_WEEK COMMENT 'Calenderweek of GlobalParameters.DeliveryDateEnd'
 , DELIVERY_DT COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
 , CALC_DIST COMMENT 'Distance traveled during the tour_2 as calculated by the program'
 , CALC_DUR COMMENT 'Duration of the tour_2'
 , EARLIEST_START_TMSP COMMENT 'Earliest Start Time for the tour_2'
 , END_TMSP COMMENT 'End of a tour_2'
 , TOUR_GID COMMENT 'GID is to have a unique identifier of a tour_2 across different delivery days for the same RDC.'
 , HAULIER_NAME COMMENT 'Stores the value of the Haulier of the lowest resources (ID) within this tour_2 with IsMotorVehicle = TRUE Attribute HaulierName on Tour_2'
 , HAULIER_CMNT COMMENT 'User entered comment on the haulier for this route'
 , TOUR_ID COMMENT 'Quintiq generated Tour_2 ID'
 , LICENSE_PLATE COMMENT 'User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour_2'
 , LICENSE_PLATE_TRAILER COMMENT 'License plate of the trailer used for this tour_2'
 , LOADED_SHIPMENTS COMMENT 'Pallet positions at the start of the tour_2 Attribute LoadedQuantity1 on Tour_2'
 , OBSERVATIONS COMMENT 'The last change/reason which was reported when editing tour_2 information'
 , RESOURCE_ID COMMENT 'ID of the truck driven in this shift (trailer excluded)'
 , RESOURCE_SET_ID COMMENT 'The ID of resource set used in a route'
 , RESOURCE_TECH COMMENT 'Resource.ResourceTechnique.ID (if multiple Resources are used for the tour_2 show all resource techniques comma separated)'
 , RESOURCE_TYPE COMMENT 'Resource.ResourceType.ID (if multiple Resources are used for the tour_2 show all resource types comma separated)'
 , SHIFT COMMENT 'The shift to which the tour_2 belongs. In case the driver swap is after the pickup actions and therefore the tour_2 belongs to two shifts this attribute needs to contain the later shift.'
 , TOUR_START_TMSP COMMENT 'Start of a tour_2'
 , CALC_TOLL_DIST2 COMMENT 'Toll distance of type 2 traveled during the tour_2 as calculated by the program'
 , CALC_TOLL_DIST COMMENT 'Toll distance traveled during the tour_2 as calculated by the program'
 , TOUR_CMNT COMMENT 'User entered comment for the tour_2'
 , USER_DIST COMMENT 'User entered distance for the tour_2'
 , USER_DUR COMMENT 'User entered duration for the tour_2'
 , USER_TOLL_DIST2 COMMENT 'User entered toll distance of type 2 for the tour_2'
 , USER_TOLL_DIST COMMENT 'User entered toll distance for the tour_2'
 , INDICATORSTIMETOUR COMMENT 'Concatenation of all unique time indicators on tours related to this Shift'
 , ISBOXREQUIRED COMMENT 'True if a box is needed on tour_2 level'
 , ISDELIVEREDINNEEDEDBOX COMMENT 'True if one of the shipment legs needs a box delivery'
 , ISONEWAY COMMENT 'True if the tour_2 is used for one way dismount resources at the end address_2(not RDC)'
 , PAIDSHIFT COMMENT 'True if the first tour_2 in the shift is billable'
 , COSTSPERDISTANCEUNIT COMMENT 'The cost incurred per distance unit_2 traveled'
 , DRIVINGDRIVETYPEID COMMENT 'ID of driving drive type'
 , INDICATORCOST COMMENT 'Concatenation of all unique cost indicators on tours related to this Shift'
 , LICENSEPLATETRAILER2 COMMENT 'License plate of the second trailer used for this tour_2'
 , TIKO COMMENT 'True if there is at least one compartment in this tour_2 that is frozen'
 , TOLLCOST COMMENT 'Costs spend on toll ways'
 , TOLLCOSTCALCULATED COMMENT 'Costs spend on toll ways calculated by the system'
 , TOLLDISTANCE3CALCULATED COMMENT 'Toll distance of type 3 traveled during the tour_2 as calculated by the program'
 , TOURSEQUENCEID COMMENT 'The SeqNr of the tour_2'
 , TRAILER1DRIVETYPEID COMMENT 'ID of trailer 1 drive type'
 , TRAILER2DRIVETYPEID COMMENT 'ID of trailer 2 drive type'
 , USERTOLLDISTANCE3 COMMENT 'User entered toll distance of type 3 for the tour_2'
 , DWH_LOAD_ID COMMENT 'Load id'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , DWH_VALID_FROM COMMENT 'Valid from date'
 , DWH_VALID_TO COMMENT 'Valid to date'
 , DELETED_FG COMMENT 'Flag if record is deleted'
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
 , END_TMSP
 , TOUR_GID
 , HAULIER_NAME
 , HAULIER_CMNT
 , TOUR_ID
 , LICENSE_PLATE
 , LICENSE_PLATE_TRAILER
 , LOADED_SHIPMENTS
 , OBSERVATIONS
 , RESOURCE_ID
 , RESOURCE_SET_ID
 , RESOURCE_TECH
 , RESOURCE_TYPE
 , SHIFT
 , TOUR_START_TMSP
 , CALC_TOLL_DIST2
 , CALC_TOLL_DIST
 , TOUR_CMNT
 , USER_DIST
 , USER_DUR
 , USER_TOLL_DIST2
 , USER_TOLL_DIST    
 , INDICATORSTIMETOUR
 , ISBOXREQUIRED
 , ISDELIVEREDINNEEDEDBOX
 , ISONEWAY
 , PAIDSHIFT
 , COSTSPERDISTANCEUNIT
 , DRIVINGDRIVETYPEID
 , INDICATORCOST
 , LICENSEPLATETRAILER2
 , TIKO
 , TOLLCOST
 , TOLLCOSTCALCULATED
 , TOLLDISTANCE3CALCULATED
 , TOURSEQUENCEID
 , TRAILER1DRIVETYPEID
 , TRAILER2DRIVETYPEID
 , USERTOLLDISTANCE3	
 , DWH_LOAD_ID
 , DWH_CREATED
 , DWH_UPDATED
 , DWH_VALID_FROM
 , DWH_VALID_TO
 , DELETED_FG
FROM DATA.T_QUINTIQ_REPORTEDSHIFT_2;