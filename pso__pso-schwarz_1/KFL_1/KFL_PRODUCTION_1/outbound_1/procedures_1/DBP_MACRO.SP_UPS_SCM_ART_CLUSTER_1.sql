
CREATE OR REPLACE PROCEDURE dbp_macro.sp_ups_scm_art_cluster(IN P_MANDANT_ID FLOAT64, IN P_ART_CLUSTER_ID FLOAT64, IN P_ART_CLUSTER_BEZ STRING, IN P_ART_CLUSTER_DESCR STRING, IN P_ART_CLUSTER_DEL_FG FLOAT64, IN P_ART_ID FLOAT64, IN P_UPDATE_USER STRING, IN P_TRANSACTION_TYPE STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '';
 CASE P_TRANSACTION_TYPE
 
   WHEN "new_art_cluster" THEN
SET sql_stmt  =  '''INSERT INTO dbp_data.ts_scm_l_art_cluster_1 (mandant_id, art_cluster_id, art_cluster_bez, art_cluster_descr  , art_cluster_del_fg, update_timestamp, update_user, td_update, td_insert) (SELECT CAST(@P_MANDANT_ID AS INT64) AS mandant_id,    COALESCE(MAX(art_cluster_id), 0) + 1 AS art_cluster_id,   @P_ART_CLUSTER_BEZ AS art_cluster_bez,   @P_ART_CLUSTER_DESCR AS art_cluster_descr,   CAST(@P_ART_CLUSTER_DEL_FG AS INT64) AS art_cluster_del_fg,   CURRENT_TIMESTAMP() AS update_timestamp,   @P_UPDATE_USER AS update_user,   CURRENT_TIMESTAMP() AS td_update,   CURRENT_TIMESTAMP() AS td_insert  FROM dbp_data.ts_scm_l_art_cluster_1) ''';

EXECUTE IMMEDIATE (sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,  P_ART_CLUSTER_BEZ AS P_ART_CLUSTER_BEZ,  P_ART_CLUSTER_DESCR AS P_ART_CLUSTER_DESCR,  P_ART_CLUSTER_DEL_FG AS P_ART_CLUSTER_DEL_FG,  P_UPDATE_USER AS P_UPDATE_USER;


   
   WHEN  "upd_art_cluster" THEN
SET sql_stmt  =  '''UPDATE dbp_data.ts_scm_l_art_cluster_1 SET  art_cluster_bez = @P_ART_CLUSTER_BEZ,  art_cluster_descr = @P_ART_CLUSTER_DESCR,  art_cluster_del_fg = CAST(@P_ART_CLUSTER_DEL_FG AS INT64),  update_timestamp = CURRENT_TIMESTAMP() WHERE mandant_id = @P_MANDANT_ID AND art_cluster_id = @P_ART_CLUSTER_ID AND update_user = @P_UPDATE_USER ''';

EXECUTE IMMEDIATE (sql_stmt) USING P_ART_CLUSTER_BEZ AS P_ART_CLUSTER_BEZ,  P_ART_CLUSTER_DESCR AS P_ART_CLUSTER_DESCR,  P_ART_CLUSTER_DEL_FG AS P_ART_CLUSTER_DEL_FG,  P_MANDANT_ID AS P_MANDANT_ID,  P_ART_CLUSTER_ID AS P_ART_CLUSTER_ID,  P_UPDATE_USER AS P_UPDATE_USER;


   WHEN "art_cluster_zu" THEN
SET sql_stmt  =  '''INSERT INTO dbp_data.ts_scm_art_cluster_zu_1 (mandant_id, art_cluster_id, art_id, td_update, td_insert) (SELECT CAST(@P_MANDANT_ID AS INT64) AS mandant_id,   CAST(@P_ART_CLUSTER_ID AS INT64) AS art_cluster_id,   CAST(@P_ART_ID AS INT64) AS art_id,   CURRENT_TIMESTAMP() AS td_update,   CURRENT_TIMESTAMP() AS td_insert) ''';

EXECUTE IMMEDIATE (sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,  P_ART_CLUSTER_ID AS P_ART_CLUSTER_ID,  P_ART_ID AS P_ART_ID;

SET sql_stmt  =  '''DELETE FROM dbp_data.ts_scm_art_cluster_zu_1 WHERE mandant_id = @P_MANDANT_ID AND art_id = @P_ART_ID AND art_cluster_id = @P_ART_CLUSTER_ID AND 0 =   @P_ART_CLUSTER_DEL_FG ''';

EXECUTE IMMEDIATE (sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,  P_ART_ID AS P_ART_ID,  P_ART_CLUSTER_ID AS P_ART_CLUSTER_ID,  P_ART_CLUSTER_DEL_FG AS P_ART_CLUSTER_DEL_FG;

/*
   default:
   
  
*/
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END CASE;
END;


