CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_PRUEFUNG_KLASSE
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
pruefung_klasse_id
,pruefung_klasse_bez

)

AS 
SELECT 
pruefung_klasse_id
,pruefung_klasse_bez

FROM dbp_view.v_amx_l_pruefung_klasse

WHERE amx_system_id=1;