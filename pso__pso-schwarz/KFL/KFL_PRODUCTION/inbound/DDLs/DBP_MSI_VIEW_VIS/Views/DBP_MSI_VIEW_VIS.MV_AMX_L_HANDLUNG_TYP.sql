CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_HANDLUNG_TYP
-- 20160322 KKaiser, neu für AP0002158 Audimex
--lsvi0303: SPEC0073867 OneAudimex filter amx_system_id=1
(
amx_handlung_typ_id
,amx_handlung_typ_bez
)

AS 
SELECT 
amx_handlung_typ_id
,amx_handlung_typ_bez

FROM dbp_view.v_amx_l_handlung_typ
WHERE amx_system_id=1;