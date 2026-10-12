/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lu_picking_user
Description		|	SAP EWM Picking User - lookup for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_picking_user (
	client_id COMMENT 'Client id - calculated based on the country code',
	wh_id COMMENT 'Warehouse ID. Subset of Warehouse Number',
	user_name COMMENT 'User Name in User Master Record. Source column name: UNAME',
	prsn_prf COMMENT 'Personalization Profile',
	wh_nr COMMENT 'Warehouse Number/Warehouse Complex. Source column name: LGNUM',
	rsrc COMMENT 'Resource (Means of Transportation or User)',
	auto_logon COMMENT 'Automatic Logon',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at',
	dwh_valid_from COMMENT 'Valid from date',
	dwh_valid_to COMMENT 'Valid to date',
	deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT='SAP EWM - base view for resource management users'
 AS
SELECT
	client_id
	, wh_id
	, uname AS user_name
	, prsn_prf
	, lgnum AS wh_nr
	, rsrc
	, auto_logon
	, dwh_created
	, dwh_updated
	, dwh_valid_from
	, dwh_valid_to
	, deleted_fg
FROM DATA.t_sapewm_scwmuser -- PK (client_id, lgnum, uname, dwh_valid_from)
;