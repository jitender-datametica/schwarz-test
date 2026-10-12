-- Da wir in der Beschreibungstabelle nur Angebot_ids erhalten, wo auch eine_1 Beschreibung vorliegt.

-- 05.01.2023 richternic SPEC0177152 -> JOIN mit PMR_ANGEBOT_ART_WUP_ZU_1, damit wir alle Angebot_ids haben.

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_pmr_angebot_beschreibung_1 (angebot_id,
angebot_beschreibung) AS SELECT DISTINCT V01.angebot_id,
 COALESCE(V02.angebot_beschreibung, '') AS angebot_beschreibung
FROM kfl_production_dbp_data.pmr_angebot_art_wup_zu_1 AS V01
 LEFT JOIN kfl_production_dbp_data.pmr_angebot_beschreibung_1 AS V02 ON V01.angebot_id = V02.angebot_id;