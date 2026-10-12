CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AMX_PRUEF_PROGRAMM
(
pruef_programm_id
,amx_system_id
,pruef_programm_bez
,zustand_id
,kapitel_typ_id
,pruef_programm_mutter_id
)
AS
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
FROM dbp_view.v_amx_pruef_programm;