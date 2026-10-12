/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lu_picking_user
Description		|	SAP EWM Picking User - lookup for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_picking_user (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number'), user_name
OPTIONS(description='User Name in User Master Record. Source column name: UNAME'), prsn_prf
OPTIONS(description='Personalization Profile'), wh_nr
OPTIONS(description='Warehouse Number/Warehouse Complex. Source column name: LGNUM'), rsrc
OPTIONS(description='Resource (Means of Transportation or User)'), auto_logon OPTIONS(description='Automatic Logon'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'),
dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `SAP EWM - BASE VIEW FOR RESOURCE MANAGEMENT USERS`) AS SELECT client_id,
 wh_id,
 uname AS user_name,
 prsn_prf,
 lgnum AS wh_nr,
 rsrc,
 auto_logon,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_sapewm_scwmuser;