/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lpv_lu_forklift_area_source_1
Description		|	LPV Forklift - lookup for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_lu_forklift_area_source_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'), src_area_nr
OPTIONS(description='area_number (datastore_data:area_number'), src_area_desc
OPTIONS(description='area_description (datastore_data:area_description)'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'))
OPTIONS(DESCRIPTION = `LPV FORKLIFT - LOOKUP FOR FE (PK CLIENT_ID, WH_NR, AREA_NR, DWH_VALID_FROM)`) AS SELECT client_id
 ,
 wh_id,
 area_nr AS src_area_nr,
 area_desc AS src_area_desc,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to
FROM ldl_logop_fe_mstr_logop.v_lpv_area_1
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to;