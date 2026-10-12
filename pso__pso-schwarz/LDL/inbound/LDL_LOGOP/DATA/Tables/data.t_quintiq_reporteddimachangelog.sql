/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reporteddimachangelog
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reporteddimachangelog (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_id VARCHAR(5) NOT NULL COMMENT 'Warehouse ID',
	changed_attr VARCHAR(512) NOT NULL COMMENT 'The attribute that was changed',
	changed_tmsp timestamp_ntz(9) COMMENT 'Time when the ok button was pressed to trigger the change',
	delivery_dt DATE COMMENT 'End of the delivery day to optimize for (max 24hrs after start).',
	change_id VARCHAR(512) NOT NULL COMMENT 'Combination of AddressFrom, To, ResourceType and timeProfile',
	new_val VARCHAR(512) COMMENT 'The new value of the attribute',
	old_val VARCHAR(512) COMMENT 'The old value of the attribute',
	user_nr VARCHAR(512) COMMENT 'Employee number of the user that made the change',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created timestamp_ntz(9) NOT NULL COMMENT 'Record created at',
	dwh_updated timestamp_ntz(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, changed_attr, change_id, dwh_valid_from)
	)
COMMENT = 'QUINTIQ - Object type in quintiq is ReportedDiMaChangeLog Object tracking user entered changes to specific attributes'
;
