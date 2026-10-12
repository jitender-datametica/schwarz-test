CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_selected_article_cluster(IN P_MANDANT_ID BIGNUMERIC, IN P_ARTICLE_CLUSTER_ID BIGNUMERIC, IN P_USER_ID STRING, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
INSERT INTO dbp_msi_view_nfmd.ts_nfmd_selected_article_cluster_2 (mandant_id, dwh_created_tmsp, article_cluster_id, user_id)
(SELECT CAST(P_MANDANT_ID AS INTEGER) AS mandant_id, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp, CAST(P_ARTICLE_CLUSTER_ID AS INTEGER) AS article_cluster_id, P_USER_ID AS user_id);
COMMIT TRANSACTION;
SET out_param  =  'Artikelcluster ausgewaehlt';
SELECT out_param;
RETURN;
END;