
CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_L_PRUEFUNG_STANDORT_1
(
	STANDORT_ID,
	AMX_SYSTEM_ID,
	STANDORT_TYP_ID,
	STANDORT_BEZ
) AS
-- 20220518 twie: SPEC0153699 neue audimex Lookup Standort, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

SELECT 
         v01.standort_id
         ,v01.amx_system_id
        ,standort_typ_id
        ,v01.standort_bez
FROM dbp_view.v_kmr_l_pruefung_standort_1 v01;