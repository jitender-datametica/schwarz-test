CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_geku_dwh_artikel_1 (geku_dwh_artikel_id, kmr_quelle_id,
geku_grund_uid, geku_artikel_uid, geku_artikel_id, wmd_fg, aktiv_fg, alt_fg, fipo_pruefpunkt_id, kmr_quelle_pp_id,
geku_kmr_fg) AS SELECT V01.geku_dwh_artikel_id,
 3 AS kmr_quelle_id,
 V01.geku_grund_uid,
 V01.geku_artikel_uid,
 V01.geku_artikel_id,
 V01.wmd_fg,
 V01.aktiv_fg,
 V01.alt_fg,
 V01.fipo_pruefpunkt_id,
 4 AS kmr_quelle_pp_id,
  CASE
  WHEN V02.kmr_agm_id IS NULL
  THEN 0
  ELSE 1
  END AS geku_kmr_fg
FROM kfl_production_dbp_view.v_l_geku_dwh_artikel_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_1 AS V02 ON V01.geku_dwh_artikel_id = V02.kmr_agm_id AND
   V02.kmr_quelle_id = 3
WHERE V01.geku_dwh_artikel_id IN (SELECT geku_dwh_artikel_id
   FROM kfl_production_dbp_view.v_l_geku_artikel_1);