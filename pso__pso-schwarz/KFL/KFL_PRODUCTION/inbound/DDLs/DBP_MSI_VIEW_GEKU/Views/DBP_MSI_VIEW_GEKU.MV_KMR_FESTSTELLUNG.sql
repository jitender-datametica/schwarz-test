CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_FESTSTELLUNG
(
	AMX_SYSTEM_ID,
	FESTSTELLUNG_ID,
	FESTSTELLUNG_BEZ,
	FESTSTELLUNG_TEXT,
	FRAGE_ID,
	FESTSTELLUNG_GEWICHTUNG_ID,
	COMPLIANCE_FG,
	BERICHTSRELEVANT_FG,
	EFFIZIENZ_FG,
	WIEDERKEHREND_FG
) AS
-- 20221117 twie: SPEC0166860 neue audimex View für Feststellung

SELECT 

 amx_system_id
,feststellung_id
,feststellung_bez
,feststellung_text
,frage_id
,feststellung_gewichtung_id
,compliance_fg
,berichtsrelevant_fg
,effizienz_fg
,wiederkehrend_fg

FROM dbp_view.V_KMR_FESTSTELLUNG;