CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_PMR_ANGEBOT_BESCHREIBUNG AS 
-- 05.01.2023 richternic SPEC0177152 -> JOIN mit PMR_ANGEBOT_ART_WUP_ZU, damit wir alle Angebot_ids haben. 
--                                      Da wir in der Beschreibungstabelle nur Angebot_ids erhalten, wo auch eine Beschreibung vorliegt.
SELECT DISTINCT 
    v01.angebot_id,
    COALESCE(v02.angebot_beschreibung,'') AS angebot_beschreibung
FROM DBP_DATA.PMR_ANGEBOT_ART_WUP_ZU v01
LEFT JOIN DBP_DATA.PMR_ANGEBOT_BESCHREIBUNG v02
ON v01.angebot_id = v02.angebot_id;