create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_AMX_REVISOR(
	REVISOR_ID,
	REVISOR_ANREDE,
	REVISOR_NACHNAME,
	REVISOR_VORNAME,
	REVISOR_NAME
) as
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160323 twie: name zusammensetzen
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20170914 twie: SPEC0026683 Tabelle enthält nur noch 1 Eintrag mit -1 'dummy'
--                           Grund: Revisor wurde aus Datenschutzgründen ausgebaut und darf nicht ohne Rücksprache mit SBIT wieder eingebaut werden.
-- 20200629 twie: SPEC0080405 Tabelle amx_revisor nicht um amx_system_id erweitert, da nicht mehr verwendet, enthält nur einen Eintrag -1

SELECT
revisor_id
,revisor_anrede
,revisor_nachname
,revisor_vorname
,TRIM(revisor_anrede) || ' ' || TRIM(revisor_vorname) || ' ' || TRIM(revisor_nachname) AS revisor_name
FROM dbp_view.v_amx_revisor;