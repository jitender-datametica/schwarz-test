CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_ZUSTAND
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160324 twie: Zustand der Prüfung; Empfehlung hat unabhängigen Zustand mit eigener View
-- 20190109 twie: NSR0506061 Filter zustand_id erweitert um 100025

(
zustand_id
,zustand_bez
)
AS
   SELECT
   zustand_id, zustand_bez

   FROM dbp_view.v_amx_l_zustand

   WHERE  --nur diese relevant für audimex
   zustand_id IN (100003, 100004, 100005, 1001, 100025)
;