CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_article_article_cluster_rel(IN P_KJWO_WW INT64, IN P_MANDANT_ID INT64, IN P_AKTION_ID STRING, IN P_ART_ID INT64, IN P_USER_ID STRING, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_article_cluster_rel (mandant_id, aktion_id, art_id, article_cluster_id, kjwo_ww, dwh_created_tmsp, user_id)
(SELECT P_MANDANT_ID , P_AKTION_ID, P_ART_ID , article_cluster_id  AS article_cluster_id, P_KJWO_WW , CAST(CURRENT_TIMESTAMP() AS DATETIME), P_USER_ID
    FROM dbp_msi_view_nfmd.mv_nfmd_latest_selected_article_cluster
    WHERE mandant_id = P_MANDANT_ID);
COMMIT TRANSACTION;
SET out_param  =  'Artikel wurde einem Cluster hinzugefuegt';
SELECT out_param;
RETURN;
END;
