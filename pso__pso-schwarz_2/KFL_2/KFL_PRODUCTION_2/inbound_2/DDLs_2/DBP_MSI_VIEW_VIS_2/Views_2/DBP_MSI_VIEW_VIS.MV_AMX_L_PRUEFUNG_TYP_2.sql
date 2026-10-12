CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_PRUEFUNG_TYP_2
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
pruefung_typ_id
,pruefung_typ_bez
,ad_hoc_fg
)
AS 
SELECT 
pruefung_typ_id
,pruefung_typ_bez
,ad_hoc_fg
FROM dbp_view.v_amx_l_pruefung_typ_2
WHERE amx_system_id=1;