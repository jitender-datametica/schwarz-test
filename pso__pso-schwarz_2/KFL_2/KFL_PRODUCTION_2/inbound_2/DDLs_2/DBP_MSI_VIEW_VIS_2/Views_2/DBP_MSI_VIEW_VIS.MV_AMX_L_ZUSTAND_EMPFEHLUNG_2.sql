CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_ZUSTAND_EMPFEHLUNG_2
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160324 twie: Zustand der Empfehlung unabhängig von Zustand der Prüfung
-- deshalb 2 Views + Attribute, nur die Quelltabelle ist die gleiche
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
zustand_id
,zustand_bez
)
AS 
SELECT 
zustand_id
,zustand_bez
FROM dbp_view.v_amx_l_zustand_2
WHERE amx_system_id=1;