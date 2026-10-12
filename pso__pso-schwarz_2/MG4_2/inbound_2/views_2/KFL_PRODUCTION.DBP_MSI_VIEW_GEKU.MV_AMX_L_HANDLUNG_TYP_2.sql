create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_AMX_L_HANDLUNG_TYP_2(
	AMX_HANDLUNG_TYP_ID,
	AMX_SYSTEM_ID,
	AMX_HANDLUNG_TYP_BEZ
) as
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
amx_handlung_typ_id
,amx_system_id
,amx_handlung_typ_bez
FROM dbp_view.v_amx_l_handlung_typ_2;