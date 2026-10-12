/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_gates
Description		|	Prepared view on ALMA base table
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_alma_gates (
	client_id COMMENT 'Client id - calculated based on the country code',
	lidl_ctry COMMENT 'Country code. Original field name bic_zmlila',
	src_sys COMMENT 'Source system',
	wh_id COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	gate_id COMMENT 'Primary Key',
	gateuu_id COMMENT 'Default SYS_GUID. Used by the ALMA webservice',
	label COMMENT 'Label of the gate',
	alloc_state_id COMMENT 'Status ID from T1211_ALLOCATIONSTATES',
	task_id COMMENT 'eGIN task ID if the gate has been blocked during gate calculation.',
	tour_id COMMENT 'TPP tour ID if the gate has been blocked automatically by tour status.',
	blocked_by_tour COMMENT 'Manually unblocking an automatic tour block sets this field to 0 effectively releasing the gate block. Prevents the same tour from re-blocking.',
	info COMMENT 'Comment that is displayed in the application with the gate block.',
	update_user COMMENT 'Username of the user who changed the gate status last.',
	update_tmsp COMMENT 'Time of the last status change.',
	temp_id COMMENT 'Was required for the WAMAS Areas',
	area_id COMMENT 'Indicates gate area',
	dwh_load_id COMMENT 'Load id',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at',
	dwh_valid_from COMMENT 'Valid from date',
	dwh_valid_to COMMENT 'Valid to date',
	deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT='ALMA - The table contains basic gate definition data (warehouse modelling master data)'
 AS 
SELECT 
	client_id
	, lidl_country AS lidl_ctry
	, source_system AS src_sys
	, wh_id
	, gate_id
	, gateuu_id
	, label
	, allocation_state_id AS alloc_state_id
	, task_id
	, tour_id
	, blocked_by_tour
	, INFO
	, update_user
	, update_tmsp
	, temperature_id AS temp_id
	, area_id
	, dwh_load_id
	, dwh_created
	, dwh_updated
	, dwh_valid_from
	, dwh_valid_to
	, deleted_fg
FROM DATA.t_alma_gates;
