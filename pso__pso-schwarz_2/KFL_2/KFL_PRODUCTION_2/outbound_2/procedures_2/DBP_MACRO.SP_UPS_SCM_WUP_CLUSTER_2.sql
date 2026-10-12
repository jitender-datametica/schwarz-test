CREATE OR REPLACE PROCEDURE dbp_macro.sp_ups_scm_wup_cluster(IN P_MANDANT_ID FLOAT64, IN P_WUP_CLUSTER_ID FLOAT64, IN P_WUP_CLUSTER_BEZ STRING, IN P_WUP_CLUSTER_DESCR STRING, IN P_WUP_CLUSTER_DEL_FG FLOAT64, IN P_WUP_ID FLOAT64, IN P_NB_ID FLOAT64, IN P_UPDATE_USER STRING, IN P_TRANSACTION_TYPE STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
-- Pruefen welcher Grund angegeben wurden ist
SET sql_stmt  =  '';
CASE P_TRANSACTION_TYPE

  WHEN "new_wup_cluster" THEN
SET sql_stmt  =  '''INSERT INTO dbp_data.ts_scm_l_wup_cluster_2 (mandant_id, wup_cluster_id, wup_cluster_bez, wup_cluster_descr  , wup_cluster_del_fg, update_timestamp, update_user, td_update, td_insert) (SELECT CAST(@P_MANDANT_ID AS INT64) AS mandant_id,    COALESCE(MAX(wup_cluster_id),0) + 1 AS wup_cluster_id,   @P_WUP_CLUSTER_BEZ AS wup_cluster_bez,   @P_WUP_CLUSTER_DESCR AS wup_cluster_descr,   CAST(@P_WUP_CLUSTER_DEL_FG AS INT64) AS wup_cluster_del_fg,   CURRENT_TIMESTAMP() AS update_timestamp,   @P_UPDATE_USER AS update_user,   CURRENT_TIMESTAMP() AS td_update,   CURRENT_TIMESTAMP() AS td_insert  FROM dbp_data.ts_scm_l_wup_cluster_2) ''';

EXECUTE IMMEDIATE (sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,  P_WUP_CLUSTER_BEZ AS P_WUP_CLUSTER_BEZ,  P_WUP_CLUSTER_DESCR AS P_WUP_CLUSTER_DESCR,  P_WUP_CLUSTER_DEL_FG AS P_WUP_CLUSTER_DEL_FG,  P_UPDATE_USER AS P_UPDATE_USER;

-- Es dürfen nur eigene Cluster aktualisiert werden, daher hier Verriegelung mit eigenem User
WHEN "upd_wup_cluster" THEN
SET sql_stmt  =  '''UPDATE dbp_data.ts_scm_l_wup_cluster_2 SET  wup_cluster_bez = @P_WUP_CLUSTER_BEZ,  wup_cluster_descr = @P_WUP_CLUSTER_DESCR,  wup_cluster_del_fg = CAST(@P_WUP_CLUSTER_DEL_FG AS INT64),  update_timestamp = CURRENT_TIMESTAMP() WHERE mandant_id = @P_MANDANT_ID AND wup_cluster_id = @P_WUP_CLUSTER_ID AND update_user = @P_UPDATE_USER ''';

EXECUTE IMMEDIATE (sql_stmt) USING P_WUP_CLUSTER_BEZ AS P_WUP_CLUSTER_BEZ,  P_WUP_CLUSTER_DESCR AS P_WUP_CLUSTER_DESCR,  P_WUP_CLUSTER_DEL_FG AS P_WUP_CLUSTER_DEL_FG,  P_MANDANT_ID AS P_MANDANT_ID,  P_WUP_CLUSTER_ID AS P_WUP_CLUSTER_ID,  P_UPDATE_USER AS P_UPDATE_USER;

WHEN "wup_cluster_zu" THEN
SET sql_stmt  =  '''INSERT INTO dbp_data.ts_scm_wup_cluster_zu_2 (mandant_id, wup_id, wup_cluster_id, nb_id, td_update,  td_insert) (SELECT CAST(@P_MANDANT_ID AS INT64) AS mandant_id,   CAST(@P_WUP_ID AS INT64) AS wup_id,   CAST(@P_WUP_CLUSTER_ID AS INT64) AS wup_cluster_id,   CAST(@P_NB_ID AS INT64) AS nb_id,   CURRENT_TIMESTAMP() AS td_update,   CURRENT_TIMESTAMP() AS td_insert) ''';

EXECUTE IMMEDIATE (sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,  P_WUP_ID AS P_WUP_ID,  P_WUP_CLUSTER_ID AS P_WUP_CLUSTER_ID,  P_NB_ID AS P_NB_ID;

SET sql_stmt  =  '''DELETE FROM dbp_data.ts_scm_wup_cluster_zu_2 WHERE mandant_id = @P_MANDANT_ID AND wup_id = @P_WUP_ID AND wup_cluster_id = @P_WUP_CLUSTER_ID AND nb_id = @P_NB_ID AND   0 = @P_WUP_CLUSTER_DEL_FG ''';

EXECUTE IMMEDIATE (sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,  P_WUP_ID AS P_WUP_ID,  P_WUP_CLUSTER_ID AS P_WUP_CLUSTER_ID,  P_NB_ID AS P_NB_ID,  P_WUP_CLUSTER_DEL_FG AS P_WUP_CLUSTER_DEL_FG;


SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END CASE;
END;



