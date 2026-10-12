create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_AMX_L_SYSTEM(
	AMX_SYSTEM_ID,
	AMX_SYSTEM_BEZ
) as
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id, dies ist die Lookup

SELECT

amx_system_id
,amx_system_bez

FROM dbp_view.v_amx_l_system;