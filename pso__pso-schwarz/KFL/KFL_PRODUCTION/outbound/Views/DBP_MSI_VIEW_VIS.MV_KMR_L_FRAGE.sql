CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_l_frage (kmr_frage_id, kmr_quelle_id,
kmr_unter_kategorie_id, kmr_teilbereich_frage_id, agm_sw) AS SELECT V02.kmr_agm_id AS kmr_frage_id,
 V02.kmr_quelle_id,
 V02.kmr_unter_kategorie_id,
 V02.kmr_teilbereich_frage_id,
 V02.agm_sw
FROM kfl_production_dbp_view.v_amx_frage_katalog AS V01
 INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu AS V02 ON V01.amx_frage_katalog_id = V02.kmr_agm_id AND
   V02.kmr_quelle_id = 1
UNION ALL
SELECT V04.kmr_agm_id AS kmr_frage_id,
 V04.kmr_quelle_id,
 V04.kmr_unter_kategorie_id,
 V04.kmr_teilbereich_frage_id,
 V04.agm_sw
FROM kfl_production_dbp_view.v_mcx_l_antwort AS V03
 INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu AS V04 ON V03.antwort_id = V04.kmr_agm_id AND V03.umfrage_id
     = V04.umfrage_id AND V04.kmr_quelle_id = 2
UNION ALL
SELECT V06.kmr_agm_id AS kmr_frage_id,
 V06.kmr_quelle_id,
 V06.kmr_unter_kategorie_id,
 V06.kmr_teilbereich_frage_id,
 V06.agm_sw
FROM kfl_production_dbp_view.v_l_geku_dwh_artikel AS V05
 INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu AS V06 ON V05.geku_dwh_artikel_id = V06.kmr_agm_id AND
   V06.kmr_quelle_id = 3
WHERE V05.geku_dwh_artikel_id IN (SELECT geku_dwh_artikel_id
   FROM kfl_production_dbp_view.v_l_geku_artikel)
UNION ALL
SELECT V08.kmr_agm_id AS kmr_frage_id,
 V08.kmr_quelle_id,
 V08.kmr_unter_kategorie_id,
 V08.kmr_teilbereich_frage_id,
 V08.agm_sw
FROM kfl_production_dbp_view.v_fipo_pruefpunkt AS V07
 INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu AS V08 ON V07.fipo_pruefpunkt_id = V08.kmr_agm_id AND
   V08.kmr_quelle_id = 4;