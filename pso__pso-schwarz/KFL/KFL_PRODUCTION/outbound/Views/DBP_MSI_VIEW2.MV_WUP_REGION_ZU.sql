CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wup_region_zu (mandant_id, wup_id, nb_id, region_id) AS SELECT W
 .mandant_id,
 W.wup_id,
 W.nb_id,
 COALESCE(WCZ.wup_cluster_id, - 1) AS region_id
FROM kfl_production_dbp_view.v_wup AS W
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_wup_cluster_zu AS WCZ ON W.mandant_id = WCZ.mandant_id AND W.wup_id = WCZ.wup_id
      AND W.nb_id = WCZ.nb_id AND WCZ.wup_cluster_id IN (101, 102, 103, 106, 107, 108)
WHERE W.nb_id = 0;