CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_upd_nfmd_article_cluster(IN P_MANDANT_ID INT64, IN P_ARTICLE_CLUSTER_ID INT64, IN P_ARTICLE_CLUSTER STRING, IN P_ARTICLE_CLUSTER_EN STRING, IN P_ARTICLE_CLUSTER_LANDESSPRACHE STRING, IN P_FLAG_AKTIV INT64, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;

IF P_ARTICLE_CLUSTER_ID IN (0, 99) THEN
    SET P_FLAG_AKTIV  =  2;
END IF;
CASE P_MANDANT_ID 
WHEN 1 THEN
    
    UPDATE dbp_msi_view_nfmd.ts_nfmd_article_cluster_2 SET
    article_cluster_descr = P_ARTICLE_CLUSTER,
    article_cluster_descr_bg = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_cz = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_en = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_hr = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_pl = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_ro = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_sk = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_native = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    active_fg = P_FLAG_AKTIV
WHERE mandant_id = P_MANDANT_ID AND article_cluster_id = P_ARTICLE_CLUSTER_ID;
WHEN 2 THEN
    
    UPDATE dbp_msi_view_nfmd.ts_nfmd_article_cluster_2 SET
    article_cluster_descr = P_ARTICLE_CLUSTER,
    article_cluster_descr_bg = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_cz = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    article_cluster_descr_en = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_hr = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_pl = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_ro = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_sk = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_native = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    active_fg = P_FLAG_AKTIV
WHERE mandant_id = P_MANDANT_ID AND article_cluster_id = P_ARTICLE_CLUSTER_ID;
WHEN 3 THEN
    
    UPDATE dbp_msi_view_nfmd.ts_nfmd_article_cluster_2 SET
    article_cluster_descr = P_ARTICLE_CLUSTER,
    article_cluster_descr_bg = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_cz = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_en = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_hr = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_pl = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    article_cluster_descr_ro = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_sk = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_native = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    active_fg = P_FLAG_AKTIV
WHERE mandant_id = P_MANDANT_ID AND article_cluster_id = P_ARTICLE_CLUSTER_ID;
WHEN 4 THEN
    
    UPDATE dbp_msi_view_nfmd.ts_nfmd_article_cluster_2 SET
    article_cluster_descr = P_ARTICLE_CLUSTER,
    article_cluster_descr_bg = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_cz = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_en = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_hr = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_pl = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_ro = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    article_cluster_descr_sk = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_native = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    active_fg = P_FLAG_AKTIV
WHERE mandant_id = P_MANDANT_ID AND article_cluster_id = P_ARTICLE_CLUSTER_ID;
WHEN 5 THEN
    
    UPDATE dbp_msi_view_nfmd.ts_nfmd_article_cluster_2 SET
    article_cluster_descr = P_ARTICLE_CLUSTER,
    article_cluster_descr_bg = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_cz = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_en = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_hr = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_pl = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_ro = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_sk = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    article_cluster_descr_native = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    active_fg = P_FLAG_AKTIV
WHERE mandant_id = P_MANDANT_ID AND article_cluster_id = P_ARTICLE_CLUSTER_ID;
WHEN 6 THEN
    
    UPDATE dbp_msi_view_nfmd.ts_nfmd_article_cluster_2 SET
    article_cluster_descr = P_ARTICLE_CLUSTER,
    article_cluster_descr_bg = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_cz = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_en = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_hr = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    article_cluster_descr_pl = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_ro = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_sk = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_native = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    active_fg = P_FLAG_AKTIV
WHERE mandant_id = P_MANDANT_ID AND article_cluster_id = P_ARTICLE_CLUSTER_ID;
WHEN 7 THEN
   
    UPDATE dbp_msi_view_nfmd.ts_nfmd_article_cluster_2 SET
    article_cluster_descr = P_ARTICLE_CLUSTER,
    article_cluster_descr_bg = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_cz = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_en = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_hr = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_pl = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_ro = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    article_cluster_descr_sk = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_native = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    active_fg = P_FLAG_AKTIV
WHERE mandant_id = P_MANDANT_ID AND article_cluster_id = P_ARTICLE_CLUSTER_ID;
WHEN 8 THEN
    
    UPDATE dbp_msi_view_nfmd.ts_nfmd_article_cluster_2 SET
    article_cluster_descr = P_ARTICLE_CLUSTER,
    article_cluster_descr_bg = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    article_cluster_descr_cz = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_en = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_hr = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_pl = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_ro = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_sk = P_ARTICLE_CLUSTER_EN,
    article_cluster_descr_native = P_ARTICLE_CLUSTER_LANDESSPRACHE,
    active_fg = P_FLAG_AKTIV
WHERE mandant_id = P_MANDANT_ID AND article_cluster_id = P_ARTICLE_CLUSTER_ID;
END CASE;

COMMIT TRANSACTION;
SET out_param  =  'Artikelcluster geaendert';
SELECT out_param;
RETURN;
END;

