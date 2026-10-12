CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu (kmr_quelle_id, kmr_agm_id, umfrage_id,
kmr_unter_kategorie_id, agm_sw, kmr_teilbereich_frage_id) AS SELECT kmr_quelle_id,
 kmr_agm_id,
 umfrage_id,
 kmr_unter_kategorie_id,
 agm_sw,
 kmr_teilbereich_frage_id
FROM kfl_production_dbp_data.kmr_agm_unter_kategorie_zu;