CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_PRUEF_OBJEKT_2
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
business_unit_id
,business_unit_bez
,pruef_feld_typ_id
,mandant_id
,in_matrix_pruefgebiete_fg
,aktiv_fg
)
AS 
SELECT 
business_unit_id
,business_unit_bez
,pruef_feld_typ_id
,mandant_id
,in_matrix_pruefgebiete_fg
,aktiv_fg
FROM dbp_view.v_amx_l_pruef_objekt_2
WHERE amx_system_id=1;