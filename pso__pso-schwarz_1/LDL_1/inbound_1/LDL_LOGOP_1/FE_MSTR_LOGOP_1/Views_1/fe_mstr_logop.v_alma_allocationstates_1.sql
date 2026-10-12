/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_alma_allocationstates_1
Description		|	Prepared view on ALMA base table
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_alma_allocationstates_1 (
	client_id COMMENT 'Client id - calculated based on the country_1 code',
	lidl_ctry COMMENT 'Country_1 code. Original field name bic_zmlila',
	src_sys COMMENT 'Source system',
	wh_id COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	state_id COMMENT 'Primary Key',
	label COMMENT 'Name of the status_1',
	dwh_load_id COMMENT 'Load id',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at',
	dwh_valid_from COMMENT 'Valid from date',
	dwh_valid_to COMMENT 'Valid to date',
	deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT='ALMA - The table contains the different states for gates and lanes as fixed data. Definition of all possible states a gate or lane can take.'
 AS 
SELECT 
	client_id
	, lidl_country AS lidl_ctry
	, source_system AS src_sys
	--wh_nr
	, wh_id
	, state_id
	, label
	, dwh_load_id
	, dwh_created
	, dwh_updated
	, dwh_valid_from
	, dwh_valid_to
	, deleted_fg
FROM DATA.t_alma_allocationstates_1;