CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_l_unter_kategorie (kmr_unter_kategorie_id,
kmr_kategorie_id, kmr_teilbereich_uk_id, uk_sw, kmr_quelle_id) AS SELECT V01.kmr_unter_kategorie_id,
 V01.kmr_kategorie_id,
 V01.kmr_teilbereich_uk_id,
 V01.uk_sw,
 MIN(V02.kmr_quelle_id) AS kmr_quelle_id
FROM kfl_production_dbp_view.v_kmr_l_unter_kategorie AS V01
 INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu AS V02 ON V01.kmr_unter_kategorie_id = V02.kmr_unter_kategorie_id
  
GROUP BY V01.kmr_unter_kategorie_id,
 V01.kmr_kategorie_id,
 V01.kmr_teilbereich_uk_id,
 V01.uk_sw;