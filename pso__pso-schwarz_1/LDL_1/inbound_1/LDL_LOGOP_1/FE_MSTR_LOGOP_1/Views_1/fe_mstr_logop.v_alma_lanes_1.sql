/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_lanes_1
Description		|	Prepared view on ALMA base table
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_alma_lanes_1 (
	client_id COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system COMMENT 'Source system',
	wh_id COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	lane_id COMMENT 'Primary Key',
	gate_id COMMENT 'Gate ID from T1214_GATES_1',
	label COMMENT 'Label of the lane visible in the application.',
	allocation_state_id COMMENT 'Status_1 ID from T1211_ALLOCATIONSTATES',
	update_user COMMENT 'The user who changed the record last. \"ALMA\" after initial master data load.',
	update_tmsp COMMENT 'Timestamp of the import for last change.',
	next_lane_id COMMENT 'ID of the next displayed lane according to the current lane ordering. NULL if the record represents the gate''s last lane.',
	info COMMENT 'Lane comment.',
	gr_capacity COMMENT 'Lane capacity used for all GR processes (Gate Calculation)',
	gi_capacity COMMENT 'Lane capacity used for all GI processes',
	laneuu_id COMMENT 'Default SYS_GUID() - Used by the ALMA webservice',
	tour_id COMMENT 'ID of the last TPP tour_1 that blocked this lane.',
	blocked_by_tour COMMENT 'Whether the lane is currently blocked by the GI process.',
	next_lane COMMENT 'Gives the order of the Lane',
	dwh_load_id COMMENT 'Load id',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at',
	dwh_valid_from COMMENT 'Valid from date',
	dwh_valid_to COMMENT 'Valid to date',
	deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT='ALMA - The table contains all lane definition data (warehouse modelling master data).'
 AS 
SELECT 
	client_id
	, lidl_country AS lidl_ctry
	, source_system AS src_sys
	, wh_id
	, lane_id
	, gate_id
	, label
	, allocation_state_id AS alloc_state_id
	, update_user
	, update_tmsp
	, next_lane_id
	, INFO
	, gr_capacity
	, gi_capacity
	, laneuu_id
	, tour_id
	, blocked_by_tour
	, next_lane
	, dwh_load_id
	, dwh_created
	, dwh_updated
	, dwh_valid_from
	, dwh_valid_to
	, deleted_fg
FROM DATA.t_alma_lanes_1
;