CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_nfmd_article_cluster(IN P_MANDANT_ID INT64, IN P_ARTICLE_CLUSTER STRING, IN P_ARTICLE_CLUSTER_EN STRING, IN P_ARTICLE_CLUSTER_LANDESSPRACHE STRING, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
CASE P_MANDANT_ID 
WHEN 1 THEN
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_cluster (mandant_id, article_cluster_id, article_cluster_descr, article_cluster_descr_bg, article_cluster_descr_cz, article_cluster_descr_en, article_cluster_descr_hr, article_cluster_descr_pl, article_cluster_descr_ro, article_cluster_descr_sk, article_cluster_descr_native, active_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(article_cluster_id) = 97 THEN 100 ELSE MAX(article_cluster_id) + 1 END AS article_cluster_id, P_ARTICLE_CLUSTER_LANDESSPRACHE, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, 1
    FROM dbp_msi_view_nfmd.ts_nfmd_article_cluster
    WHERE mandant_id = P_MANDANT_ID AND article_cluster_id NOT IN (98, 99));
WHEN 2 THEN
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_cluster (mandant_id, article_cluster_id, article_cluster_descr, article_cluster_descr_bg, article_cluster_descr_cz, article_cluster_descr_en, article_cluster_descr_hr, article_cluster_descr_pl, article_cluster_descr_ro, article_cluster_descr_sk, article_cluster_descr_native, active_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(article_cluster_id) = 97 THEN 100 ELSE MAX(article_cluster_id) + 1 END AS article_cluster_id, P_ARTICLE_CLUSTER, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, 1
    FROM dbp_msi_view_nfmd.ts_nfmd_article_cluster
    WHERE mandant_id = P_MANDANT_ID AND article_cluster_id NOT IN (98, 99));
WHEN 3 THEN
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_cluster (mandant_id, article_cluster_id, article_cluster_descr, article_cluster_descr_bg, article_cluster_descr_cz, article_cluster_descr_en, article_cluster_descr_hr, article_cluster_descr_pl, article_cluster_descr_ro, article_cluster_descr_sk, article_cluster_descr_native, active_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(article_cluster_id) = 97 THEN 100 ELSE MAX(article_cluster_id) + 1 END AS article_cluster_id, P_ARTICLE_CLUSTER, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, 1
    FROM dbp_msi_view_nfmd.ts_nfmd_article_cluster
    WHERE mandant_id = P_MANDANT_ID AND article_cluster_id NOT IN (98, 99));
WHEN 4 THEN
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_cluster (mandant_id, article_cluster_id, article_cluster_descr, article_cluster_descr_bg, article_cluster_descr_cz, article_cluster_descr_en, article_cluster_descr_hr, article_cluster_descr_pl, article_cluster_descr_ro, article_cluster_descr_sk, article_cluster_descr_native, active_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(article_cluster_id) = 97 THEN 100 ELSE MAX(article_cluster_id) + 1 END AS article_cluster_id, P_ARTICLE_CLUSTER, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, 1
    FROM dbp_msi_view_nfmd.ts_nfmd_article_cluster
    WHERE mandant_id = P_MANDANT_ID AND article_cluster_id NOT IN (98, 99));
WHEN 5 THEN
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_cluster (mandant_id, article_cluster_id, article_cluster_descr, article_cluster_descr_bg, article_cluster_descr_cz, article_cluster_descr_en, article_cluster_descr_hr, article_cluster_descr_pl, article_cluster_descr_ro, article_cluster_descr_sk, article_cluster_descr_native, active_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(article_cluster_id) = 97 THEN 100 ELSE MAX(article_cluster_id) + 1 END AS article_cluster_id, P_ARTICLE_CLUSTER, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, P_ARTICLE_CLUSTER_LANDESSPRACHE, 1
    FROM dbp_msi_view_nfmd.ts_nfmd_article_cluster
    WHERE mandant_id = P_MANDANT_ID AND article_cluster_id NOT IN (98, 99));
WHEN 6 THEN
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_cluster (mandant_id, article_cluster_id, article_cluster_descr, article_cluster_descr_bg, article_cluster_descr_cz, article_cluster_descr_en, article_cluster_descr_hr, article_cluster_descr_pl, article_cluster_descr_ro, article_cluster_descr_sk, article_cluster_descr_native, active_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(article_cluster_id) = 97 THEN 100 ELSE MAX(article_cluster_id) + 1 END AS article_cluster_id, P_ARTICLE_CLUSTER, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, 1
    FROM dbp_msi_view_nfmd.ts_nfmd_article_cluster
    WHERE mandant_id = P_MANDANT_ID AND article_cluster_id NOT IN (98, 99));
WHEN 7 THEN
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_cluster (mandant_id, article_cluster_id, article_cluster_descr, article_cluster_descr_bg, article_cluster_descr_cz, article_cluster_descr_en, article_cluster_descr_hr, article_cluster_descr_pl, article_cluster_descr_ro, article_cluster_descr_sk, article_cluster_descr_native, active_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(article_cluster_id) = 97 THEN 100 ELSE MAX(article_cluster_id) + 1 END AS article_cluster_id, P_ARTICLE_CLUSTER, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, 1
    FROM dbp_msi_view_nfmd.ts_nfmd_article_cluster
    WHERE mandant_id = P_MANDANT_ID AND article_cluster_id NOT IN (98, 99));
WHEN 8 THEN
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_article_cluster (mandant_id, article_cluster_id, article_cluster_descr, article_cluster_descr_bg, article_cluster_descr_cz, article_cluster_descr_en, article_cluster_descr_hr, article_cluster_descr_pl, article_cluster_descr_ro, article_cluster_descr_sk, article_cluster_descr_native, active_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(article_cluster_id) = 97 THEN 100 ELSE MAX(article_cluster_id) + 1 END AS article_cluster_id, P_ARTICLE_CLUSTER, P_ARTICLE_CLUSTER_LANDESSPRACHE, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_EN, P_ARTICLE_CLUSTER_LANDESSPRACHE, 1
    FROM dbp_msi_view_nfmd.ts_nfmd_article_cluster
    WHERE mandant_id = P_MANDANT_ID AND article_cluster_id NOT IN (98, 99));
END CASE;

COMMIT TRANSACTION;
SET out_param  =  'Artikelcluster hinzugefuegt';
SELECT out_param;
RETURN;
END;
