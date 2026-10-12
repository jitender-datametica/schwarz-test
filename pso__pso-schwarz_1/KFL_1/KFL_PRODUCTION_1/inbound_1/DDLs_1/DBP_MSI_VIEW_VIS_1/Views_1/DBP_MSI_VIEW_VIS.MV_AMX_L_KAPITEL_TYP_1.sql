CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_KAPITEL_TYP_1
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
kapitel_typ_id
,kapitel_typ_bez
)
AS 
SELECT 
kapitel_typ_id
,kapitel_typ_bez
FROM dbp_view.v_amx_l_kapitel_typ_1
WHERE amx_system_id=1;