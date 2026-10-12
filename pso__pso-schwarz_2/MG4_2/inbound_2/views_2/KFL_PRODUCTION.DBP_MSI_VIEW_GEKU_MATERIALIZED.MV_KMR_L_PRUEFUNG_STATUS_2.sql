create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_L_PRUEFUNG_STATUS_2(
	PRUEFUNG_STATUS_ID,
	AMX_SYSTEM_ID,
	PRUEFUNG_STATUS_BEZ
) as
-- 20220518 twie: SPEC0153699 neue audimex Lookup Prüfungsstatus, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

SELECT 
         v01.pruefung_status_id
        ,v01.amx_system_id
        ,v01.pruefung_status_bez
FROM dbp_view.v_kmr_l_pruefung_status_2 v01;