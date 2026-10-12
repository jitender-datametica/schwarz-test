CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_L_MASSNAHME_STATUS
(
	MASSNAHME_STATUS_ID,
	AMX_SYSTEM_ID,
	MASSNAHME_STATUS_BEZ
)
AS
-- 20230817 twie: SPEC0195708 neue audimex Lookup Massnahmestatus, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

SELECT 
         v01.massnahme_status_id
        ,v01.amx_system_id
        ,v01.massnahme_status_bez
FROM dbp_view.v_kmr_l_massnahme_status v01;