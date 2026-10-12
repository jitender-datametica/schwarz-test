/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_gates_2
Description		|	Prepared view on ALMA base table
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_alma_gates_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_ctry
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), src_sys OPTIONS(description='Source system'), wh_id
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'), gate_id
OPTIONS(description='Primary Key'), gateuu_id OPTIONS(description='Default SYS_GUID. Used by the ALMA webservice'),
label OPTIONS(description='Label of the gate'), alloc_state_id
OPTIONS(description='Status_2 ID from T1211_ALLOCATIONSTATES'), task_id
OPTIONS(description='eGIN task ID if the gate has been blocked during gate calculation.'), tour_id
OPTIONS(description='TPP tour_2 ID if the gate has been blocked automatically by tour_2 status.'), blocked_by_tour
OPTIONS(description='Manually unblocking an automatic tour_2 block sets this field to 0 effectively releasing the gate block. Prevents the same tour_2 from re_2-blocking.'),
info OPTIONS(description='Comment that is displayed in the application with the gate block.'), update_user
OPTIONS(description='Username of the user who changed the gate status_2 last.'), update_tmsp
OPTIONS(description='Time of the last status_2 change.'), temp_id OPTIONS(description='Was required for the WAMAS Areas'),
area_id OPTIONS(description='Indicates gate area'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `ALMA - THE TABLE CONTAINS BASIC GATE DEFINITION DATA (WAREHOUSE MODELLING MASTER DATA)`) AS
SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_id,
 gate_id,
 gateuu_id,
 label,
 allocation_state_id AS alloc_state_id,
 task_id,
 tour_id,
 blocked_by_tour,
 info,
 update_user,
 update_tmsp,
 temperature_id AS temp_id,
 area_id,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_alma_gates_2;