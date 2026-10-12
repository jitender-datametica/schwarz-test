create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_L_FRAGE_STATUS(
	FRAGE_STATUS_ID,
	AMX_SYSTEM_ID,
	FRAGE_STATUS_BEZ
) as
-- 20221116 twie: SPEC0166860 neue audimex View für Fragestatus

SELECT 

frage_status_id
,amx_system_id
,frage_status_bez

FROM dbp_view.V_KMR_L_FRAGE_STATUS;