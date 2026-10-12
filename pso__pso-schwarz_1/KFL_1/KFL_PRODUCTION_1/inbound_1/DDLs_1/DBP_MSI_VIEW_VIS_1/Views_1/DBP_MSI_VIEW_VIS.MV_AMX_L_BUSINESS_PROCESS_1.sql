CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_BUSINESS_PROCESS_1 
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
business_process_id
,business_process_bez
,pruef_feld_typ_id
,in_matrix_pruefgebiete_fg
,aktiv_fg
)
AS 
SELECT 
business_process_id
,business_process_bez
,pruef_feld_typ_id
,in_matrix_pruefgebiete_fg
,aktiv_fg
FROM dbp_view.v_amx_l_business_process_1
WHERE amx_system_id=1;