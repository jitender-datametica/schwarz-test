/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedaddressstate_kpi
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedaddressstate_kpi (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_country
OPTIONS(description='Country code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), pallet_pos_additional_dist
OPTIONS(description='The additional distance per pallet positions that had to be travelled to visit this address during the considered tour'),
address_id OPTIONS(description='Stores the address ID'), calendar_week OPTIONS(description='CalendarWeek'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), oneway_fg
OPTIONS(description='The address state where the resources are dismounted for one way tours'), temp_fg
OPTIONS(description='Indicates if this is a temporary reported address state'), pallet_pos_dlv_cnt
OPTIONS(description='This calculates the number of pallet positions that is delivered to an address during a tour'),
tour_dist_without_addr
OPTIONS(description='The resulting tour distance if the considered address was not part of the tour'), reportedtourgid
OPTIONS(description='GID of the reported tour'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'), active_fg OPTIONS(description='Flag if record is active'),
arrivalactualtelematics OPTIONS(description='Actual arrival time at this address received from Telematics'),
arrivalestimatedtelematics OPTIONS(description='Estimated arrival time at this address received from Telematics'),
departureactualtelematics OPTIONS(description='Actual departure time at this address received from Telematics'))
OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 pallet_pos_additional_dist,
 address_id,
 calendar_week,
 delivery_dt,
 oneway_fg,
 temp_fg,
 pallet_pos_dlv_cnt,
 tour_dist_without_addr,
 reportedtourgid,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg,
 arrivalactualtelematics,
 arrivalestimatedtelematics,
 departureactualtelematics
FROM ldl_logop_fe_mstr_logop.v_quintiq_reportedaddressstate;