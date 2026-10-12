CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mdl_frage_befragung_bereich_kategorie_zu_2 AS SELECT V01.frage_id
 ,
 V01.befragung_id,
 V01.bereich_id,
 V01.kategorie_id,
 V02.kategorie_gruppe_id
FROM kfl_production_dbp_view.v_mdl_frage_befragung_bereich_kategorie_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mdl_kategorie_gruppe_zu_2 AS V02 ON V01.kategorie_id = V02.kategorie_id;