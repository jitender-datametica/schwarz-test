CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_pmr_angebot_beschreibung_1 AS SELECT DISTINCT V01.angebot_id,
 COALESCE(V02.angebot_beschreibung, '') AS angebot_beschreibung
FROM kfl_production_dbp_data.pmr_angebot_art_wup_zu_1 AS V01
 LEFT JOIN kfl_production_dbp_data.pmr_angebot_beschreibung_1 AS V02 ON V01.angebot_id = V02.angebot_id;