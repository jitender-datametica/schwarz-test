CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_KOSTEN_UPLOAD_FG(
	KOSTEN_UPLOAD_FG,
	KOSTEN_UPLOAD_FG_BEZ
) AS
--AP0230823, dknop, initial
SELECT 
-1 AS kosten_upload_fg
,'nicht definiert / not defined' AS kosten_upload_fg_bez
UNION
SELECT
1 AS kosten_upload_fg
,'Km-basiert' AS kosten_upload_fg_bez
UNION
SELECT
0 AS kosten_upload_fg
,'Kosten-basiert' AS kosten_upload_fg_bez
;