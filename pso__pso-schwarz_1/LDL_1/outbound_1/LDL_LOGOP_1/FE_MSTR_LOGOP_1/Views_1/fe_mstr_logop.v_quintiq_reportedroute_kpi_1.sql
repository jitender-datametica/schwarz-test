/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedroute_kpi_1
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedroute_kpi_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), calc_dist
OPTIONS(description='Distance caluclated for the route'), calc_dur OPTIONS(description='Action.End - Action.Start'),
haulier_id OPTIONS(description='Identifier of haulier.'), haulier_name OPTIONS(description='Name of the Haulier'),
license_plate OPTIONS(description='License plate of the vechicle used for this tour_1'), shifts_cnt
OPTIONS(description='Total number of shifts in the route'), resource_id OPTIONS(description='Resource ID'),
resource_set_id OPTIONS(description='The ID of resource set used in a route'), max_cap_sum
OPTIONS(description='All capacities of the resources in the resourceSet summed'), tour_gid
OPTIONS(description='GID is to have a unique identifier of a tour_1 across different delivery days for the same RDC.'),
user_dist OPTIONS(description='User entered distance for the tour_1'), user_dur
OPTIONS(description='User entered duration for the tour_1'), user_shifts_cnt
OPTIONS(description='User entered number of shifts in the route'), calender_week_nr
OPTIONS(description='Calenderweek of GlobalParameters.DeliveryDateEnd'), changes_in_shift_costs
OPTIONS(description='Change In Shift Costs'), end_tmsp OPTIONS(description='The time of the end of the action(s)'),
haulier_cmnt_txt OPTIONS(description='User entered comment on the haulier for this route'), indicators_time_tour
OPTIONS(description='Concatenation of all unique time indicators on tours related to this route'),
temp_reported_route_fg OPTIONS(description='Indicates if this is a temporary reported route'), shift_indicator_elke_cnt
OPTIONS(description='Sum over all unique shiftIndicators which have IsStoreDelivery'), route_gid
OPTIONS(description='GID is to have a unique identifier of a Route across different delivery days for the same RDC.'),
start_tmsp OPTIONS(description='The time of the start of the action(s)'), max_cap_sum_2
OPTIONS(description='All capacities of the resources in the resourceSet summed'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'), active_fg
OPTIONS(description='Flag if record is active'), trailer2drivetypeid OPTIONS(description='ID of trailer 2 drive type'),
trailer1drivetypeid OPTIONS(description='ID of trailer 1 drive type'), summaxcapacity1converted
OPTIONS(description='The sum of all max capacity 1 converted in the resources within this tour_1'), isdummyresourceset
OPTIONS(description='TRUE if the resource set assigned to this route is dummy_1'), drivingdrivetypeid
OPTIONS(description='ID of driving drive type')) OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS
SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 delivery_dt,
 calc_dist,
 calc_dur,
 haulier_id,
 haulier_name,
 license_plate,
 shifts_cnt,
 resource_id,
 resource_set_id,
 max_cap_sum,
 tour_gid,
 user_dist,
 user_dur,
 user_shifts_cnt,
 calender_week_nr,
 changes_in_shift_costs,
 end_tmsp,
 haulier_cmnt_txt,
 indicators_time_tour,
 temp_reported_route_fg,
 shift_indicator_elke_cnt,
 route_gid,
 start_tmsp,
 max_cap_sum_2,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg,
 trailer2drivetypeid,
 trailer1drivetypeid,
 summaxcapacity1converted,
 isdummyresourceset,
 drivingdrivetypeid
FROM ldl_logop_fe_mstr_logop.v_quintiq_reportedroute_1;