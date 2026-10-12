 CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_SCM.MV_DT_TS_SCM_WUP_CLUSTER_ZU ( mandant_id
,wup_id
,nb_id
,wup_cluster_id
,wup_cluster_zu_fg)
TARGET_LAG = '30 minutes' refresh_mode = AUTO initialize = ON_CREATE
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG
--WAREHOUSE = WH_KFL_D_DYNAMIC_TABLE_LOG
AS
 -- 25.02.2021, srom0404, AP0084960, SPEC0104182 - Fleisch Autodispo Massenpflege Mehrfachselektion
-- 25.06.2021, nwag2310, AP0084960, SPEC0104182 - Only non-deleted Clusters
-- Der komplette Marktstamm wird den Clustern zugeordnet
-- Als Default -99, wenn keine manuelle Zuordnung erfolgt
-- 15.07.2021, nwag2310, AP0084960, SPEC0104182 - bugfix default cluster
-- 19.07.2021, nwag2310, AP0084960, SPEC0104182 - bugfix default cluster

SELECT 
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,COALESCE(v03.wup_cluster_id, -99) AS wup_cluster_id
,CASE WHEN v03.wup_cluster_id IS NULL THEN 0 ELSE 1 END AS wup_cluster_zu_fg
FROM dbp_view.v_wup v01
LEFT JOIN dbp_view.v_ts_scm_wup_cluster_zu v02
  ON v01.mandant_id = v02.mandant_id
 AND v01.wup_id = v02.wup_id
 AND v01.nb_id  = v02.nb_id
LEFT JOIN dbp_view.v_ts_scm_l_wup_cluster v03
  ON v03.mandant_id = v02.mandant_id
 AND v03.wup_cluster_id = v02.wup_cluster_id
 AND COALESCE(v03.wup_cluster_del_fg,0) = 0;
