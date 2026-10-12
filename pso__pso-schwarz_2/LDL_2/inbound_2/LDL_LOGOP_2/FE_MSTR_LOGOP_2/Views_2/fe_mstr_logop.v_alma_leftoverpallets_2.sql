/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_leftoverpallets_2
Description		|	Prepared view on ALMA base table
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_alma_leftoverpallets_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code',
	lidl_country COMMENT 'Country_2 code. Original field name bic_zmlila',
	source_system COMMENT 'Source system',
	wh_id COMMENT 'wh_nr as a digit Source warehouse number,(datastore_data:lagernummer)',
	id COMMENT 'Primary Key',
	uu_id COMMENT 'Default SYS_GUID() Used by the ALMA webservice',
	lane_id COMMENT 'ID of the selected lane References T1216_LANES.C1216_ID',
	store COMMENT 'Entered store number',
	ambient COMMENT 'Number saved for the column Ambient',
	bulk COMMENT 'Number saved for the column Bulk',
	nf COMMENT 'Number saved for the column Ambient',
	relocations COMMENT 'Number saved for the column Relocations',
	others COMMENT 'Number saved for the column Others',
	COMMENT COMMENT 'Entered comment (optional, may be null)',
	unblocking_fg COMMENT 'Displays if a Leftover Pallet is inactive /greyed out',
	dwh_load_id COMMENT 'Load id',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at',
	dwh_valid_from COMMENT 'Valid from date',
	dwh_valid_to COMMENT 'Valid to date',
	deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT='ALMA - This table saves all leftover pallet records'
 AS 
SELECT 
	client_id
	, lidl_country AS lidl_ctry
	, source_system AS src_sys
	, wh_id
	, id
	, uu_id
	, lane_id
	, store
	, ambient
	, bulk
	, nf
	, relocations
	, others
	, COMMENT
	, unblocking_fg
	, dwh_load_id
	, dwh_created
	, dwh_updated
	, dwh_valid_from
	, dwh_valid_to
	, deleted_fg
FROM DATA.t_alma_leftoverpallets_2
;