CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPS_SCM_WUP_CLUSTER (P_MANDANT_ID FLOAT, P_WUP_CLUSTER_ID FLOAT, P_WUP_CLUSTER_BEZ VARCHAR(16777216), P_WUP_CLUSTER_DESCR VARCHAR(16777216), P_WUP_CLUSTER_DEL_FG FLOAT, P_WUP_ID FLOAT, P_NB_ID FLOAT, P_UPDATE_USER VARCHAR(16777216), P_TRANSACTION_TYPE VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '

// Pruefen welcher Grund angegeben wurden ist 
var sql_stmt = "";

switch (P_TRANSACTION_TYPE)
{
  case "new_wup_cluster": 
  var sql_stmt = `INSERT INTO DBP_DATA.ts_scm_l_wup_cluster_2 
                  (
                    mandant_id 
                   ,wup_cluster_id
                   ,wup_cluster_bez
                   ,wup_cluster_descr
                   ,wup_cluster_del_fg
                   ,update_timestamp
                   ,update_user
                   ,td_update
                   ,td_insert
                   )
                   SELECT
                          ? AS mandant_id
                         ,Coalesce(Max(WUP_CLUSTER_ID),0) + 1 AS wup_cluster_id
                         ,? AS wup_cluster_bez
                         ,? AS wup_cluster_descr
                         ,? AS wup_cluster_del_fg
                         ,CURRENT_TIMESTAMP AS update_timestamp
                         ,? AS update_user
                         ,CURRENT_TIMESTAMP AS td_update
                         ,CURRENT_TIMESTAMP AS td_insert
                   FROM DBP_DATA.ts_scm_l_wup_cluster_2
                 `;
  
  snowflake.createStatement({
  sqlText : sql_stmt,
  binds : [P_MANDANT_ID, P_WUP_CLUSTER_BEZ, P_WUP_CLUSTER_DESCR, P_WUP_CLUSTER_DEL_FG, P_UPDATE_USER]
  }).execute();
  break;
  
  // Es dürfen nur eigene Cluster aktualisiert werden, daher hier Verriegelung mit eigenem User
  case "upd_wup_cluster": 
  var sql_stmt = `UPDATE DBP_DATA.ts_scm_l_wup_cluster_2
                     SET wup_cluster_bez    = ?
                        ,wup_cluster_descr  = ?
                        ,wup_cluster_del_fg = ?
                        ,update_timestamp   = CURRENT_TIMESTAMP
                   WHERE mandant_id         = ?
                     AND wup_cluster_id     = ?
	                 AND update_user        = ?
                 `;

  snowflake.createStatement({
  sqlText : sql_stmt,
  binds : [P_WUP_CLUSTER_BEZ, P_WUP_CLUSTER_DESCR, P_WUP_CLUSTER_DEL_FG, P_MANDANT_ID, P_WUP_CLUSTER_ID, P_UPDATE_USER]
  }).execute();
  break;

  case "wup_cluster_zu": 
  var sql_stmt = `INSERT INTO DBP_DATA.ts_scm_wup_cluster_zu_2
                  VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
                 `;
  snowflake.createStatement({
  sqlText : sql_stmt,
  binds : [P_MANDANT_ID, P_WUP_ID, P_WUP_CLUSTER_ID, P_NB_ID]
  }).execute();

  var sql_stmt = `DELETE FROM DBP_DATA.ts_scm_wup_cluster_zu_2
                   WHERE mandant_id     = ?
                     AND wup_id         = ?
                     AND wup_cluster_id = ?
                     AND nb_id          = ?
                     AND 0              = ?
                 `;

  snowflake.createStatement({
  sqlText : sql_stmt,
  binds : [P_MANDANT_ID, P_WUP_ID, P_WUP_CLUSTER_ID, P_NB_ID, P_WUP_CLUSTER_DEL_FG]
  }).execute();
  break;

  default:
  break;

}

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();	
';
