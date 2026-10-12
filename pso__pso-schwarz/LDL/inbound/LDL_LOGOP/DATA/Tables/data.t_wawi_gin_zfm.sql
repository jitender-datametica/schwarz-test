/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_gin_zfm
Description		|	WAWI table
====================================================================================================
*/

CREATE TABLE DATA.t_wawi_gin_zfm (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	wh_nr 				NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse number',
	wawi_instanz_kzl 	VARCHAR(3) 		NOT NULL	COMMENT 'Country code',
	id 					NUMBER(10,0) 	NOT NULL	COMMENT 'Unique ID. Sequential number',
	zfm_id 				VARCHAR(30) 	NULL 		COMMENT 'ZFM booking number',
	task_id 			NUMBER(38,0)	NULL 		COMMENT 'Internal Task ID (from T173 and T174)',
	gin_status 			NUMBER(38,0)	NULL 		COMMENT 'eGIN status',
	return_code 		NUMBER(38,0)	NULL 		COMMENT 'Status from ZFM (filled by WCI)',
	errormessage 		VARCHAR(1000)	NULL 		COMMENT 'Error message from ZFM (filled by WCI)',
	mod_date 			TIMESTAMP		NULL 		COMMENT 'Modification date of the corresponding line',
	created 			TIMESTAMP		NULL 		COMMENT 'Creation date of the corresponding line',
	scn 				NUMBER(38,0)	NULL 		COMMENT '',
	date_zfm 			TIMESTAMP		NULL 		COMMENT '',
	type_of_goods 		VARCHAR(200)	NULL 		COMMENT '',
	main_type_of_goods 	VARCHAR(200)	NULL 		COMMENT '',
	arrival_date 		TIMESTAMP		NULL 		COMMENT '',
	licence_plate 		VARCHAR(32)		NULL 		COMMENT '',
	dwh_load_id    		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   		DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     		BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_nr, id, dwh_valid_from)
) COMMENT = 'WAWI - WHWAWIADM.T1046_GIN_ZFM table.'
;