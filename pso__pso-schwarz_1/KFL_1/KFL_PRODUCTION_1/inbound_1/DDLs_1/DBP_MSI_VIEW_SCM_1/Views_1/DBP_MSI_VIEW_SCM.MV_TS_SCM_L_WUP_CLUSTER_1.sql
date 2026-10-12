CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_SCM_L_WUP_CLUSTER_1
AS
-- 25.02.2021, srom0404, AP0084960, SPEC0104182 - Fleisch Autodispo Massenpflege Mehrfachselektion
-- 25.06.2021, nwag2310, AP0084960, SPEC0104182 - Only non-deleted Clusters
-- 04.10.2021, srom0404, AP0084960, UserID darf nicht mit gespeichert werden. D.h. alle Autodiospo User können alle Cluster bearbeiten
SELECT
v01.mandant_id
,v01.wup_cluster_id
,v01.wup_cluster_bez
,v01.wup_cluster_descr
,v01.wup_cluster_del_fg
,v01.update_timestamp
,v01.update_user
 -- neu, alle SCM User dürfen alle Cluster editieren
,1 AS own_cluster
FROM dbp_view.v_ts_scm_l_wup_cluster_1 v01
WHERE v01.wup_cluster_del_fg = 0
         -- neu, alle SCM User dürfen alle Cluster editieren
         /** alt, User spezifische Cluster Zuordnung
                CASE
                    WHEN v02.user_id IS NOT NULL THEN 1 ELSE 0
                END AS own_cluster
                FROM dbp_view.v_ts_scm_l_wup_cluster_1 v01

                LEFT JOIN dbp_msi_data.akt_msi_user_1 v02
                ON v01.update_user = v02.user_id
                WHERE v01.wup_cluster_del_fg = 0
                **/
UNION

SELECT
v03.mandant_id
,-1 AS wup_cluster_id
,'Alle (DIF)' AS wup_cluster_bez
,'Alle Markt Cluster (DIF)' AS wup_cluster_descr
,0 AS wup_cluster_del_fg
,CURRENT_TIMESTAMP(6) AS update_timestamp
,'System' AS update_user
,0 AS own_cluster
FROM dbp_view.v_mandant_1 v03
WHERE v03.mandant_id = 1

UNION
SELECT
v03.mandant_id
,-99 AS wup_cluster_id
,'nicht zugeordnet' AS wup_cluster_bez
,'Markt ist keinem Cluster zugeordnet' AS wup_cluster_descr
,0 AS wup_cluster_del_fg
,CURRENT_TIMESTAMP(6) AS update_timestamp
,'System' AS update_user
,0 AS own_cluster
FROM dbp_view.v_mandant_1 v03
WHERE v03.mandant_id = 1;