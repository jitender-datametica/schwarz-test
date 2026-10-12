CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_FRAGE_KAT_PRUEF_PROGR_ZU
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
frage_kat_pruef_progr_zu_id
,pruef_programm_id
,amx_frage_katalog_id
)
AS 
SELECT 
frage_kat_pruef_progr_zu_id
,pruef_programm_id
,amx_frage_katalog_id
FROM dbp_view.v_amx_frage_kat_pruef_progr_zu
WHERE amx_system_id=1;