create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_AMX_L_PRUEFUNG_KLASSE_1(
	PRUEFUNG_KLASSE_ID,
	AMX_SYSTEM_ID,
	PRUEFUNG_KLASSE_BEZ
) as
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
pruefung_klasse_id
,amx_system_id
,pruefung_klasse_bez
FROM dbp_view.v_amx_l_pruefung_klasse_1;