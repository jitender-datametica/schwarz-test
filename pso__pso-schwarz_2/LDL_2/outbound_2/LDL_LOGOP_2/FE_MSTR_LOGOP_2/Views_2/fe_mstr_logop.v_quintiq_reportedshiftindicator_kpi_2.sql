/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedshiftindicator_kpi_2
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedshiftindicator_kpi_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_country
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), address_id_seq
OPTIONS(description='Contains the IDs of all the non rdc addresses this tour_2 visits in the order the are visited'),
address_name_seq
OPTIONS(description='Contains the long names of all the non rdc addresses this tour_2 visits in the order the are visited (excluding country_2 code)'),
calendar_week OPTIONS(description='Calenderweek of GlobalParameters.DeliveryDateEnd'), costs_per_dist
OPTIONS(description='The cost incurred per distance unit_2 traveled'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), calc_dist
OPTIONS(description='Distance traveled during the tour_2 as calculated by the program'), calc_dur
OPTIONS(description='Duration of the tour_2'), earliest_start_tmsp OPTIONS(description='Earliest Start Time for the tour_2'),
end_tmsp OPTIONS(description='End of a tour_2'), factor
OPTIONS(description='Indication how important/costly this indicator is'), tour_gid
OPTIONS(description='GID is to have a unique identifier of a tour_2 across different delivery days for the same RDC.'),
haulier
OPTIONS(description='Stores the value of the Haulier of the lowest resources (ID) within this tour_2 with IsMotorVehicle = TRUE Attribute HaulierName on Tour_2'),
haulier_cmnt OPTIONS(description='User entered comment on the haulier for this route'), shift_ind_id
OPTIONS(description='The uniquely identifier of shift indicator'), time_ind_concat
OPTIONS(description='Concatenation of all unique time indicators on tours related to this Shift'), box_needed_fg
OPTIONS(description='True if a box is needed on tour_2 level'), box_dlv_needed_fg
OPTIONS(description='True if one of the shipment legs needs a box delivery'), oneway_fg
OPTIONS(description='True if the tour_2 is used for one way dismount resources at the end address_2(not RDC)'),
license_plate
OPTIONS(description='User entered license plate number of the vehicle used for the tour. Or its based on route Attribute LicensePlateCalc on Tour_2'),
license_plate_trailer OPTIONS(description='License plate of the trailer used for this tour_2'), loaded_shipments
OPTIONS(description='Pallet positions at the start of the tour_2 Attribute LoadedQuantity1 on Tour_2'), ind_name
OPTIONS(description='Name of the indicator'), observations
OPTIONS(description='The last change/reason which was reported when editing tour_2 information'), paid_shift_fg
OPTIONS(description='True if the first tour_2 in the shift is billable'), resource_id
OPTIONS(description='ID of the truck driven in this shift (trailer excluded)'), resource_set_id
OPTIONS(description='The ID of resource set used in a route'), resource_tech
OPTIONS(description='Resource.ResourceTechnique.ID (if multiple Resources are used for the tour_2 show all resource techniques comma separated)'),
resource_type
OPTIONS(description='Resource.ResourceType.ID (if multiple Resources are used for the tour_2 show all resource types comma separated)'),
tour_start_tmsp OPTIONS(description='Start of a tour_2'), frozen_fg
OPTIONS(description='True if there is at least one compartment in this tour_2 that is frozen'), toll_costs
OPTIONS(description='Costs spend on toll ways'), calc_toll_costs
OPTIONS(description='Costs spend on toll ways calculated by the system'), calc_toll_dist2
OPTIONS(description='Toll distance of type 2 traveled during the tour_2 as calculated by the program'), calc_toll_dist
OPTIONS(description='Toll distance traveled during the tour_2 as calculated by the program'), tour_cmnt
OPTIONS(description='User entered comment for the tour_2'), tour_id OPTIONS(description='Quintiq generated Tour_2 ID'),
tour_seq_nr OPTIONS(description='The SeqNr of the tour_2'), user_dist
OPTIONS(description='User entered distance for the tour_2'), user_dur
OPTIONS(description='User entered duration for the tour_2'), user_toll_dist2
OPTIONS(description='User entered toll distance of type 2 for the tour_2'), user_toll_dist
OPTIONS(description='User entered toll distance for the tour_2'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'), active_fg OPTIONS(description='Flag if record is active'),
drivingdrivetypeid OPTIONS(description='ID of driving drive type'), indicatorcost
OPTIONS(description='Concatenation of all unique cost indicators on tours related to this Shift'), licenseplatetrailer2
OPTIONS(description='License plate of the second trailer used for this tour_2'), tolldistance3calculated
OPTIONS(description='Toll distance of type 3 traveled during the tour_2 as calculated by the program'),
trailer1drivetypeid OPTIONS(description='ID of trailer 1 drive type'), trailer2drivetypeid
OPTIONS(description='ID of trailer 2 drive type'), usertolldistance3
OPTIONS(description='User entered toll distance of type 3 for the tour_2'))
OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 address_id_seq,
 address_name_seq,
 calendar_week,
 costs_per_dist,
 delivery_dt,
 calc_dist,
 calc_dur,
 earliest_start_tmsp,
 end_tmsp,
 factor,
 tour_gid,
 haulier,
 haulier_cmnt,
 shift_ind_id,
 time_ind_concat,
 box_needed_fg,
 box_dlv_needed_fg,
 oneway_fg,
 license_plate,
 license_plate_trailer,
 loaded_shipments,
 ind_name,
 observations,
 paid_shift_fg,
 resource_id,
 resource_set_id,
 resource_tech,
 resource_type,
 tour_start_tmsp,
 frozen_fg,
 toll_costs,
 calc_toll_costs,
 calc_toll_dist2,
 calc_toll_dist,
 tour_cmnt,
 tour_id,
 tour_seq_nr,
 user_dist,
 user_dur,
 user_toll_dist2,
 user_toll_dist,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg,
 drivingdrivetypeid,
 indicatorcost,
 licenseplatetrailer2,
 tolldistance3calculated,
 trailer1drivetypeid,
 trailer2drivetypeid,
 usertolldistance3
FROM ldl_logop_fe_mstr_logop.v_quintiq_reportedshiftindicator_2;