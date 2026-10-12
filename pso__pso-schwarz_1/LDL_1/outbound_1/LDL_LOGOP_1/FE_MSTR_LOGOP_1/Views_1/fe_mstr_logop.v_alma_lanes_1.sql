/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_lanes_1
Description		|	Prepared view on ALMA base table
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_alma_lanes_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'), lane_id
OPTIONS(description='Primary Key'), gate_id OPTIONS(description='Gate ID from T1214_GATES_1'), label
OPTIONS(description='Label of the lane visible in the application.'), allocation_state_id
OPTIONS(description='Status_1 ID from T1211_ALLOCATIONSTATES'), update_user
OPTIONS(description='The user who changed the record last.\"ALMA\" after initial master data load.'), update_tmsp
OPTIONS(description='Timestamp of the import for last change.'), next_lane_id
OPTIONS(description='ID of the next displayed lane according to the current lane ordering. NULL if the record represents the gate\'s last lane.'),
info OPTIONS(description='Lane comment.'), gr_capacity
OPTIONS(description='Lane capacity used for all GR processes (Gate Calculation)'), gi_capacity
OPTIONS(description='Lane capacity used for all GI processes'), laneuu_id
OPTIONS(description='Default SYS_GUID() - Used by the ALMA webservice'), tour_id
OPTIONS(description='ID of the last TPP tour_1 that blocked this lane.'), blocked_by_tour
OPTIONS(description='Whether the lane is currently blocked by the GI process.'), next_lane
OPTIONS(description='Gives the order of the Lane'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `ALMA - THE TABLE CONTAINS ALL LANE DEFINITION DATA (WAREHOUSE MODELLING MASTER DATA).`) AS SELECT
 client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_id,
 lane_id,
 gate_id,
 label,
 allocation_state_id AS alloc_state_id,
 update_user,
 update_tmsp,
 next_lane_id,
 info,
 gr_capacity,
 gi_capacity,
 laneuu_id,
 tour_id,
 blocked_by_tour,
 next_lane,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_alma_lanes_1;