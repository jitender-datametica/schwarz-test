CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_SCM.MV_DT_TS_SCM_ART_CLUSTER_ZU_1
(MANDANT_ID,
ART_ID,
ART_CLUSTER_ID,
ART_CLUSTER_ZU_FG)
-- 25.02.2021, srom0404, AP0084960, SPEC0104182 - Fleisch Autodispo Massenpflege Mehrfachselektion
-- 25.06.2021, nwag2310, AP0084960, SPEC0104182 - Only non-deleted Clusters
-- Der komplette Artikelstamm wird den Clustern zugeordnet
-- Als Default -99, wenn keine manuelle Zuordnung erfolgt
-- 15.07.2021, nwag2310, AP0084960, SPEC0104182 - bugfix default cluster
-- 19.07.2021, nwag2310, AP0084960, SPEC0104182 - bugfix default cluster
-- 25.02.2025, nwag2310, switch to dyntable
TARGET_LAG = '60 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG
--WAREHOUSE = WH_KFL_D_DYNAMIC_TABLE_LOG
AS
SELECT 
 v01.mandant_id
,v01.art_id
,COALESCE(v03.art_cluster_id, -99) AS art_cluster_id
,CASE WHEN v03.art_cluster_id IS NULL THEN 0 ELSE 1 END AS art_cluster_zu_fg
FROM dbp_view.v_art_1 v01
LEFT JOIN dbp_view.v_ts_scm_art_cluster_zu_1 v02
  ON v01.mandant_id = v02.mandant_id
 AND v01.art_id     = v02.art_id
LEFT JOIN dbp_view.v_ts_scm_l_art_cluster_1 v03
  ON v03.mandant_id = v02.mandant_id
 AND v03.art_cluster_id = v02.art_cluster_id
 AND COALESCE(v03.art_cluster_del_fg,0) = 0
WHERE EXISTS (SELECT 1 FROM dbp_view.v_art_wup_autodispo_flw_tag_1 ad WHERE ad.mandant_id=v01.mandant_id AND ad.art_id=v01.art_id AND ad.menge_einh_id = 'BME' AND YEAR(ad.dat) >= YEAR(CURRENT_DATE) -2 );