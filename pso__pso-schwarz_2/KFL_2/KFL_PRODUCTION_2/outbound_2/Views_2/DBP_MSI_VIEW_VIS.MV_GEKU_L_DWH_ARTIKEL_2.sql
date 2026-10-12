CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_l_dwh_artikel_2 AS SELECT V01.geku_dwh_artikel_id,
 3 AS kmr_quelle_id,
 V01.geku_grund_uid,
 V01.geku_artikel_uid,
 V01.geku_artikel_id,
 V01.fipo_pruefpunkt_id,
 V01.wmd_fg,
 V01.geku_dwh_artikel_id AS geku_dwh_artikel_vis_id,
  CASE
  WHEN V02.kmr_agm_id IS NULL
  THEN 0
  ELSE 1
  END AS geku_kmr_fg
FROM kfl_production_dbp_view.v_l_geku_dwh_artikel_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_2 AS V02 ON V01.geku_dwh_artikel_id = V02.kmr_agm_id AND
   V02.kmr_quelle_id = 3;