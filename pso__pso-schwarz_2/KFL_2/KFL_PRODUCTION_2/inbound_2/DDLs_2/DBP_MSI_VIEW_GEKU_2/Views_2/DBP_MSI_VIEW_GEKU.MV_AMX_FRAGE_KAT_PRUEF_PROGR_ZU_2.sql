CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AMX_FRAGE_KAT_PRUEF_PROGR_ZU_2
(
frage_kat_pruef_progr_zu_id
,amx_system_id
,pruef_programm_id
,amx_frage_katalog_id
)
AS
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
frage_kat_pruef_progr_zu_id
,amx_system_id
,pruef_programm_id
,amx_frage_katalog_id
FROM dbp_view.v_amx_frage_kat_pruef_progr_zu_2;