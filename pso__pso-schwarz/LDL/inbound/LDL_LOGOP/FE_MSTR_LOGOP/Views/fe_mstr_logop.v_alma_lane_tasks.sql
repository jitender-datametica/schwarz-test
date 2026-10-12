/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_lane_tasks
Description		|	Prepared view on ALMA base table
====================================================================================================
*/


CREATE OR REPLACE VIEW fe_mstr_logop.v_alma_lane_tasks (
	client_id COMMENT 'Client id - calculated based on the country code',
	lidl_ctry COMMENT 'Country code. Original field name bic_zmlila',
	src_sys COMMENT 'Source system',
	wh_id COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	lane_id COMMENT 'ID of the lane',
	task_id COMMENT 'eGIN task ID',
	gr_allocation COMMENT 'Default 0. Type of eGIN Task Assignment.',
	update_tmsp COMMENT 'Shows the Timestamp',
	dwh_load_id COMMENT 'Load id',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at',
	dwh_valid_from COMMENT 'Valid from date',
	dwh_valid_to COMMENT 'Valid to date',
	deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT='ALMA - This table saves all eGIN tasks assigned to lanes for the GR process.'
 AS 
SELECT 
	client_id
	, lidl_country AS lidl_ctry
	, source_system AS src_sys
	, wh_id
	, lane_id
	, task_id
	, gr_allocation
	, update_tmsp
	, dwh_load_id
	, dwh_created
	, dwh_updated
	, dwh_valid_from
	, dwh_valid_to
	, deleted_fg
FROM DATA.t_alma_lane_tasks;
