create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_L_FRAGE_TYP_2(
	FRAGE_TYP_ID,
	AMX_SYSTEM_ID,
	FRAGE_TYP_BEZ
) as
-- 20221116 twie: SPEC0166860 neue audimex View für Fragetyp

SELECT 

frage_typ_id
,amx_system_id
,frage_typ_bez

FROM dbp_view.V_KMR_L_FRAGE_TYP_2;