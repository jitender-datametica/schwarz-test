CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPS_SCM_ART_CLUSTER (P_MANDANT_ID FLOAT, P_ART_CLUSTER_ID FLOAT, P_ART_CLUSTER_BEZ VARCHAR(16777216), P_ART_CLUSTER_DESCR VARCHAR(16777216), P_ART_CLUSTER_DEL_FG FLOAT, P_ART_ID FLOAT, P_UPDATE_USER VARCHAR(16777216), P_TRANSACTION_TYPE VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '

// Pruefen welcher Grund angegeben wurden ist 
var sql_stmt = "";

switch (P_TRANSACTION_TYPE)
{
  case "new_art_cluster": 
  var sql_stmt = `INSERT INTO DBP_DATA.ts_scm_l_art_cluster_2 
                  (
                    mandant_id 
                   ,art_cluster_id
                   ,art_cluster_bez
                   ,art_cluster_descr
                   ,art_cluster_del_fg
                   ,update_timestamp
                   ,update_user
                   ,td_update
                   ,td_insert
                   )
                   SELECT
                          ? AS mandant_id
                         ,Coalesce(Max(ART_CLUSTER_ID),0) + 1 AS art_cluster_id
                         ,? AS art_cluster_bez
                         ,? AS art_cluster_descr
                         ,? AS art_cluster_del_fg
                         ,CURRENT_TIMESTAMP AS update_timestamp
                         ,? AS update_user
                         ,CURRENT_TIMESTAMP AS td_update
                         ,CURRENT_TIMESTAMP AS td_insert
                   FROM DBP_DATA.ts_scm_l_art_cluster_2
                 `;
  
  snowflake.createStatement({
  sqlText : sql_stmt,
  binds : [P_MANDANT_ID, P_ART_CLUSTER_BEZ, P_ART_CLUSTER_DESCR, P_ART_CLUSTER_DEL_FG, P_UPDATE_USER]
  }).execute();
  break;
  
  // Es dürfen nur eigene Cluster aktualisiert werden, daher hier Verriegelung mit eigenem User
  case "upd_art_cluster": 
  var sql_stmt = `UPDATE DBP_DATA.ts_scm_l_art_cluster_2
                     SET art_cluster_bez    = ?
                        ,art_cluster_descr  = ?
                        ,art_cluster_del_fg = ?
                        ,update_timestamp   = CURRENT_TIMESTAMP
                   WHERE mandant_id         = ?
                     AND art_cluster_id     = ?
	                 AND update_user        = ?
                 `;

  snowflake.createStatement({
  sqlText : sql_stmt,
  binds : [P_ART_CLUSTER_BEZ, P_ART_CLUSTER_DESCR, P_ART_CLUSTER_DEL_FG, P_MANDANT_ID, P_ART_CLUSTER_ID, P_UPDATE_USER]
  }).execute();
  break;

  case "art_cluster_zu": 
  var sql_stmt = `INSERT INTO DBP_DATA.ts_scm_art_cluster_zu_2
                  VALUES (?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
                 `;
  snowflake.createStatement({
  sqlText : sql_stmt,
  binds : [MANDANT_ID, ART_CLUSTER_ID, ART_ID]
  }).execute();

  var sql_stmt = `DELETE FROM DBP_DATA.ts_scm_art_cluster_zu_2
                   WHERE mandant_id     = ?
                     AND art_id         = ?
                     AND art_cluster_id = ?
                     AND 0              = ?
                 `;

  snowflake.createStatement({
  sqlText : sql_stmt,
  binds : [P_MANDANT_ID, P_ART_ID, P_ART_CLUSTER_ID, P_ART_CLUSTER_DEL_FG]
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