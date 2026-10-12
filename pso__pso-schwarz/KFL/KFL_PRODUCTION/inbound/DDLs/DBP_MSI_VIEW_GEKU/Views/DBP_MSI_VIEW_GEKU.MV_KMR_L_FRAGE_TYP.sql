CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_L_FRAGE_TYP
(
	FRAGE_TYP_ID,
	AMX_SYSTEM_ID,
	FRAGE_TYP_BEZ
) AS
-- 20221116 twie: SPEC0166860 neue audimex View für Fragetyp

SELECT 

frage_typ_id
,amx_system_id
,frage_typ_bez

FROM dbp_view.V_KMR_L_FRAGE_TYP;