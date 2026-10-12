/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_resource
Description		|	SAP EWM Gruppenleiter Resource
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_gpl_resource (client_id OPTIONS(description='Client id (PK)'),
wh_id OPTIONS(description='Warehouse ID (PK)'), rsrc OPTIONS(description='Resource (Means of Transportation or User)'),
rsrc_type OPTIONS(description='Resource Type'), user OPTIONS(description='User Name'), queue
OPTIONS(description='Queue'), type_fg OPTIONS(description='Flag for PTWY and Repl.'), conf_dt
OPTIONS(description='Logon Date on RF'), conf_tm OPTIONS(description='Logon Time on RF'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `SAP EWM RESOURCE VIEW (BASED ON V_SAPEWM_RESOURCE)`) AS SELECT client_id,
 wh_id,
 rsrc,
 rsrc_type,
 uname AS user,
 act_queue AS queue,
  CASE
  WHEN act_queue LIKE '%REPL%'
  THEN 'REPL'
  WHEN act_queue LIKE '%INB%'
  THEN 'PTWY'
  ELSE NULL
  END AS type_fg,
 logon_date AS conf_dt,
 logon_time AS conf_tm,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_sapewm_resource
WHERE logon_date = DATE(CURRENT_TIMESTAMP())
 AND (act_queue LIKE '%REPL%' OR act_queue LIKE '%INB%');