CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mdl_frage_befragung_bereich_kategorie_zu_2 (frage_id, befragung_id,
bereich_id, kategorie_id) AS SELECT frage_id,
 befragung_id,
 bereich_id,
 kategorie_id
FROM kfl_production_dbp_data.mdl_frage_befragung_bereich_kategorie_zu_2;