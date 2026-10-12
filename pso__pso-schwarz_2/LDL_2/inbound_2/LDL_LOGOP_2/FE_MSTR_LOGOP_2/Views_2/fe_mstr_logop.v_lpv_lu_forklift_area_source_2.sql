/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lpv_lu_forklift_area_source_2
Description		|	LPV Forklift - lookup for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_lpv_lu_forklift_area_source_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,wh_id COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'
	,src_area_nr COMMENT 'area_number (datastore_data:area_number'
	,src_area_desc COMMENT 'area_description (datastore_data:area_description)'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	)
COMMENT = 'LPV Forklift - lookup for FE (PK client_id, wh_nr, area_nr, dwh_valid_from)'
AS
SELECT
	client_id
	,wh_id
	,area_nr
	,area_desc
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
FROM fe_mstr_logop.v_lpv_area_2
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
;
