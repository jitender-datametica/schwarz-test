-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_mdl_frage_befragung_bereich_kategorie_zu (frage_id,
befragung_id, bereich_id, kategorie_id) AS SELECT frage_id,
 befragung_id,
 bereich_id,
 kategorie_id
FROM kfl_production_dbp_view.v_mdl_frage_befragung_bereich_kategorie_zu AS v01;