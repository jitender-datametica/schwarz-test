CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_PROZESS_IST_ANKUNFT_1(
	PLOMBE_PROZESS_ID,
	PLOMBE_PROZESS_BEZ
) AS
--2023-12-18,AP0194349,SPEC0222332 dknop, initial
SELECT 
1 AS plombe_prozess_id
,'Plombe'AS plombe_prozess_bez
UNION
SELECT
2 AS plombe_prozess_id
,'WE_Palette' AS plombe_prozess_bez
UNION
SELECT
-1 AS plombe_prozess_id
,'' AS plombe_prozess_bez
;