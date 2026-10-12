CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AMX_L_ZUSTAND
(
zustand_id
,amx_system_id
,zustand_bez
)
AS
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160324 twie: Zustand der Prüfung; Empfehlung hat unabhängigen Zustand mit eigener View
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20190109 twie: NSR0506061 Filter zustand_id erweitert um 100025
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
zustand_id
,amx_system_id
,zustand_bez
FROM dbp_view.v_amx_l_zustand
WHERE ((amx_system_id = 2 AND zustand_id IN (100003, 100004, 100005, 1001, 100025))
OR (amx_system_id = 1 AND zustand_id IN (100005,1001,100041)));