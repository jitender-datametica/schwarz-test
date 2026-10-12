-- 19.07.2021, nwag2310, AP0084960, SPEC0104182 - bugfix default cluster
 -- 25.02.2025, nwag2310, switch to dyn. table

-- Als Default -99, wenn keine manuelle Zuordnung erfolgt

-- 25.02.2021, srom0404, AP0084960, SPEC0104182 - Fleisch Autodispo Massenpflege Mehrfachselektion

-- 15.07.2021, nwag2310, AP0084960, SPEC0104182 - bugfix default cluster

-- 25.06.2021, nwag2310, AP0084960, SPEC0104182 - Only non-deleted Clusters

-- Der komplette Artikelstamm wird den Clustern zugeordnet

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_scm_art_cluster_zu_1 (mandant_id, art_id, art_cluster_id,
art_cluster_zu_fg) AS SELECT mandant_id,
 art_id,
 art_cluster_id,
 art_cluster_zu_fg
FROM kfl_production_dbp_msi_view_scm.mv_dt_ts_scm_art_cluster_zu_1;