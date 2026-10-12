CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AMX_L_SYSTEM_2
(
amx_system_id
,amx_system_bez
)
AS
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id, dies ist die Lookup

SELECT

amx_system_id
,amx_system_bez

FROM dbp_view.v_amx_l_system_2;