CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_wup_region_zu_1 (mandant_id, wup_id, nb_id, region_id) AS
SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 COALESCE(V02.wup_cluster_id, - 1) AS region_id
FROM kfl_production_dbp_view.v_wup_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_wup_cluster_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id =
     V02.wup_id AND V01.nb_id = V02.nb_id AND V02.wup_cluster_id IN (101, 102, 103, 106, 107, 108)
WHERE V01.nb_id = 0
UNION ALL
SELECT mandant_id,
 wup_id,
 nb_id,
 vs_id
FROM kfl_production_dbp_view.v_wup_1
WHERE mandant_id <> 1
 AND nb_id = 0;