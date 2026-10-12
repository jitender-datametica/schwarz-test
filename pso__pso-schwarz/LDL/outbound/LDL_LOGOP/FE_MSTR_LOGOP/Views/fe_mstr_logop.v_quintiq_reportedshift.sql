/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedshift
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedshift (client_id
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
end_tmsp OPTIONS(description='End of a tour'), tour_gid
OPTIONS(description='GID is to have a unique identifier of a tour across different delivery days for the same RDC.'),
haulier_name
OPTIONS(description='Stores the value of the Haulier of the lowest resources (ID) within this tour with IsMotorVehicle = TRUE Attribute HaulierName on Tour'),
haulier_cmnt OPTIONS(description='User entered comment on the haulier for this route'), tour_id
OPTIONS(description='Quintiq generated Tour ID'), license_plate
OPTIONS(description='User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour'),
license_plate_trailer OPTIONS(description='License plate of the trailer used for this tour'), loaded_shipments
OPTIONS(description='Pallet positions at the start of the tour Attribute LoadedQuantity1 on Tour'), observations
OPTIONS(description='The last change/reason which was reported when editing tour information'), resource_id
OPTIONS(description='ID of the truck driven in this shift (trailer excluded)'), resource_set_id
OPTIONS(description='The ID of resource set used in a route'), resource_tech
OPTIONS(description='Resource.ResourceTechnique.ID (if multiple Resources are used for the tour show all resource techniques comma separated)'),
resource_type
OPTIONS(description='Resource.ResourceType.ID (if multiple Resources are used for the tour show all resource types comma separated)'),
shift
OPTIONS(description='The shift to which the tour belongs. In case the driver swap is after the pickup actions and therefore the tour belongs to two shifts this attribute needs to contain the later shift.'),
tour_start_tmsp OPTIONS(description='Start of a tour'), calc_toll_dist2
OPTIONS(description='Toll distance of type 2 traveled during the tour as calculated by the program'), calc_toll_dist
OPTIONS(description='Toll distance traveled during the tour as calculated by the program'), tour_cmnt
OPTIONS(description='User entered comment for the tour'), user_dist
OPTIONS(description='User entered distance for the tour'), user_dur
OPTIONS(description='User entered duration for the tour'), user_toll_dist2
OPTIONS(description='User entered toll distance of type 2 for the tour'), user_toll_dist
OPTIONS(description='User entered toll distance for the tour'), indicatorstimetour
OPTIONS(description='Concatenation of all unique time indicators on tours related to this Shift'), isboxrequired
OPTIONS(description='True if a box is needed on tour level'), isdeliveredinneededbox
OPTIONS(description='True if one of the shipment legs needs a box delivery'), isoneway
OPTIONS(description='True if the tour is used for one way dismount resources at the end address(not RDC)'), paidshift
OPTIONS(description='True if the first tour in the shift is billable'), costsperdistanceunit
OPTIONS(description='The cost incurred per distance unit traveled'), drivingdrivetypeid
OPTIONS(description='ID of driving drive type'), indicatorcost
OPTIONS(description='Concatenation of all unique cost indicators on tours related to this Shift'), licenseplatetrailer2
OPTIONS(description='License plate of the second trailer used for this tour'), tiko
OPTIONS(description='True if there is at least one compartment in this tour that is frozen'), tollcost
OPTIONS(description='Costs spend on toll ways'), tollcostcalculated
OPTIONS(description='Costs spend on toll ways calculated by the system'), tolldistance3calculated
OPTIONS(description='Toll distance of type 3 traveled during the tour as calculated by the program'), toursequenceid
OPTIONS(description='The SeqNr of the tour'), trailer1drivetypeid OPTIONS(description='ID of trailer 1 drive type'),
trailer2drivetypeid OPTIONS(description='ID of trailer 2 drive type'), usertolldistance3
OPTIONS(description='User entered toll distance of type 3 for the tour'), dwh_load_id OPTIONS(description='Load id'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'),
dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted')) OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT
 *
FROM ldl_logop_data.t_quintiq_reportedshift;