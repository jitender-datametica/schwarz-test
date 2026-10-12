create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_AMX_PRUEF_PROGRAMM_2(
	PRUEF_PROGRAMM_ID,
	AMX_SYSTEM_ID,
	PRUEF_PROGRAMM_BEZ,
	ZUSTAND_ID,
	KAPITEL_TYP_ID,
	PRUEF_PROGRAMM_MUTTER_ID
) as
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
pruef_programm_id
,amx_system_id
,pruef_programm_bez
,zustand_id
,kapitel_typ_id
,pruef_programm_mutter_id
FROM dbp_view.v_amx_pruef_programm_2;