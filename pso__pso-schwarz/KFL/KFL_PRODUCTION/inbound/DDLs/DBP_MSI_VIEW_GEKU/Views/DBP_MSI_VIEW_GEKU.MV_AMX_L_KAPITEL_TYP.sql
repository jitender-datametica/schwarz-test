CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AMX_L_KAPITEL_TYP
(
kapitel_typ_id
,amx_system_id
,kapitel_typ_bez
)
AS
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
kapitel_typ_id
,amx_system_id
,kapitel_typ_bez
FROM dbp_view.v_amx_l_kapitel_typ;