/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_stagingtollcell_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_stagingtollcell_2 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_2 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_2 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_id VARCHAR(5) NOT NULL COMMENT 'Warehouse ID',
	src_address_id VARCHAR(512) NOT NULL COMMENT 'Identifier of the origin address_2',
	new_mod_fg BOOLEAN COMMENT 'Indicator whether it\"s newly imported/created or it has fields updated',
	soft_dlv_fg BOOLEAN COMMENT 'True if the instance is removed from external system\"',
	time_profile_id VARCHAR(512) NOT NULL COMMENT 'Identifier of time profile',
	tgt_address_id VARCHAR(512) NOT NULL COMMENT 'Identifier of the destination address_2',
	toll_cat_id NUMBER(38,0) NOT NULL COMMENT 'The identifier for toll category',
	toll_cost NUMBER(38,10) COMMENT 'The toll cost from origin to destination address_2',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created timestamp_ntz(9) NOT NULL COMMENT 'Record created at',
	dwh_updated timestamp_ntz(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, src_address_id, tgt_address_id, toll_cat_id, time_profile_id, dwh_valid_from)
	)
COMMENT = 'QUINTIQ - Object type in quintiq is StagingTollCell'
;
