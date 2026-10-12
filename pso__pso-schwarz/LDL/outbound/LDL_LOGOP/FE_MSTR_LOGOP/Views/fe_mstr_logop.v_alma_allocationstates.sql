/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_allocationstates
Description		|	Prepared view on ALMA base table
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_alma_allocationstates (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_ctry
OPTIONS(description='Country code. Original field name bic_zmlila'), src_sys OPTIONS(description='Source system'), wh_id
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'), state_id
OPTIONS(description='Primary Key'), label OPTIONS(description='Name of the status'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `ALMA - THE TABLE CONTAINS THE DIFFERENT STATES FOR GATES AND LANES AS FIXED DATA. DEFINITION OF ALL POSSIBLE STATES A GATE OR LANE CAN TAKE.`)
AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_id,
 state_id,
 label,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_alma_allocationstates;