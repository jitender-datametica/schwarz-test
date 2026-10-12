create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_L_SYSTEM(
	AMX_SYSTEM_ID,
	AMX_SYSTEM_BEZ
) as
-- 20220518 twie: SPEC0153699 neue audimex Lookup System, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

SELECT 
        v01.amx_system_id
        ,v01.amx_system_bez
FROM dbp_view.v_kmr_l_system v01;
