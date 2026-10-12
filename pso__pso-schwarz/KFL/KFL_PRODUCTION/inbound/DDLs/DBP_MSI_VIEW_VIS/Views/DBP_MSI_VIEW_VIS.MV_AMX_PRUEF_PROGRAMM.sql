CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_PRUEF_PROGRAMM 
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
pruef_programm_id
,pruef_programm_bez
,zustand_id
,kapitel_typ_id
,pruef_programm_mutter_id


)

AS 
SELECT 
pruef_programm_id
,pruef_programm_bez
,zustand_id
,kapitel_typ_id
,pruef_programm_mutter_id

FROM dbp_view.v_amx_pruef_programm
WHERE amx_system_id=1;