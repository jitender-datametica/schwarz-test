CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WERBEPROZESS_SPR_ZU_1(
	WERBEPROZESS_ID,
	WERBEPROZESS_BEZ
)
 AS
--2025-10-30, dknop, AP0269651, SPEC0329583, initial
SELECT
 1 AS werbeprozess_id
,'WBS TP1' AS werbeprozess_bez
UNION
SELECT
 2 AS werbeprozess_id
,'WBS TP2'  AS werbeprozess_bez
UNION
SELECT
 3 AS werbeprozess_id
,'WBS TP1+TP2' AS werbeprozess_bez
UNION
SELECT
 4 AS werbeprozess_id
,'F&R' AS werbeprozess_bez
UNION
SELECT
 0 AS werbeprozess_id
,'N/A' AS werbeprozess_bez
UNION
SELECT
 -1 AS werbeprozess_id
,'N/A' AS werbeprozess_bez

;