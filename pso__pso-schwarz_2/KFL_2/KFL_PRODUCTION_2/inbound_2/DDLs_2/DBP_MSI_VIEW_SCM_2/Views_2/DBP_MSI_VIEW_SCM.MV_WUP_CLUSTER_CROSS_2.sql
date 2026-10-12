CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WUP_CLUSTER_CROSS_2
-- 25.02.2021, srom0404, AP0084960, SPEC0104182 - Fleisch Autodispo Massenpflege Mehrfachselektion
-- Dient als Auswahl Liste mit den möglichen Märkten für vorhandene Cluster, Kombination daher über CROSS
-- Vorhandene Zuordnungen werden mit einem Flag (=1) markiert
AS
SELECT
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,v02.wup_cluster_id
,CASE WHEN v03.wup_cluster_id IS NULL THEN 0 ELSE 1 END AS wup_cluster_cross_fg
FROM DBP_VIEW.v_wup_2 v01
CROSS JOIN DBP_VIEW.v_ts_scm_l_wup_cluster_2 v02

LEFT JOIN DBP_VIEW.v_ts_scm_wup_cluster_zu_2 v03
  ON v01.mandant_id = v03.mandant_id
 AND v01.wup_id     = v03.wup_id
 AND v01.nb_id      = v03.nb_id
 AND v02.wup_cluster_id = v03.wup_cluster_id
;
