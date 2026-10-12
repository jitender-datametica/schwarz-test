/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_lane_tasks_2
Description		|	Prepared view on ALMA base table
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_alma_lane_tasks_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_ctry
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), src_sys OPTIONS(description='Source system'), wh_id
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'), lane_id
OPTIONS(description='ID of the lane'), task_id OPTIONS(description='eGIN task ID'), gr_allocation
OPTIONS(description='Default 0. Type of eGIN Task Assignment.'), update_tmsp OPTIONS(description='Shows the Timestamp'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `ALMA - THIS TABLE SAVES ALL EGIN TASKS ASSIGNED TO LANES FOR THE GR PROCESS.`) AS SELECT
 client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_id,
 lane_id,
 task_id,
 gr_allocation,
 update_tmsp,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_alma_lane_tasks_2;