CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_L_PRUEFUNG_KLASSE
(
	PRUEFUNG_KLASSE_ID,
	AMX_SYSTEM_ID,
	PRUEFUNG_KLASSE_BEZ
) AS
-- 20220518 twie: SPEC0153699 neue audimex Lookup Prüfung Klasse (Prüfungsart), inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

SELECT 
         v01.pruefung_klasse_id
        ,v01.amx_system_id
        ,v01.pruefung_klasse_bez
FROM dbp_view.v_kmr_l_pruefung_klasse v01;