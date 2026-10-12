create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_L_PRUEFPROZESS(
	GEPR_PROZESS_ID,
	AMX_SYSTEM_ID,
	GEPR_PROZESS_IMP_REFERENZ,
	GEPR_PROZESS_BEZ
) as
-- 20220518 twie: SPEC0153699 neue audimex Lookup Prozess, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

SELECT 

         v01.gepr_prozess_id
        ,v01.amx_system_id
        ,v01.gepr_prozess_imp_referenz
        ,v01.gepr_prozess_bez

FROM dbp_view.v_kmr_l_pruefprozess v01;