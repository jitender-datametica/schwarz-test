create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_AMX_L_BUSINESS_PROCESS_1(
	BUSINESS_PROCESS_ID,
	AMX_SYSTEM_ID,
	BUSINESS_PROCESS_BEZ,
	PRUEF_FELD_TYP_ID,
	IN_MATRIX_PRUEFGEBIETE_FG,
	AKTIV_FG
) as
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
business_process_id
,amx_system_id
,business_process_bez
,pruef_feld_typ_id
,in_matrix_pruefgebiete_fg
,aktiv_fg
FROM dbp_view.v_amx_l_business_process_1;