create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_L_FESTSTELLUNG_GEWICHTUNG(
	FESTSTELLUNG_GEWICHTUNG_ID,
	AMX_SYSTEM_ID,
	FESTSTELLUNG_GEWICHTUNG_BEZ
) as
-- 20221117 twie: SPEC0166860 neue audimex View für Gewichtung Feststellung

SELECT 

 feststellung_gewichtung_id
,amx_system_id
,feststellung_gewichtung_bez

FROM dbp_view.V_KMR_L_FESTSTELLUNG_GEWICHTUNG;