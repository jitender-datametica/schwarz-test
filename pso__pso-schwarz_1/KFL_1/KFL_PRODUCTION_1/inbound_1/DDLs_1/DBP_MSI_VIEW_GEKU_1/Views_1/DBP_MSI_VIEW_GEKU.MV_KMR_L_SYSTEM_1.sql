CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_L_SYSTEM_1
(
	AMX_SYSTEM_ID,
	AMX_SYSTEM_BEZ
) AS
-- 20220518 twie: SPEC0153699 neue audimex Lookup System, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

SELECT 
        v01.amx_system_id
        ,v01.amx_system_bez
FROM dbp_view.v_kmr_l_system_1 v01;