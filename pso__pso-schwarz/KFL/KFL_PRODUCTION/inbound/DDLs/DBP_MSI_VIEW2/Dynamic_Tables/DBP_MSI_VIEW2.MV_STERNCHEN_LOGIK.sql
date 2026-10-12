CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_STERNCHEN_LOGIK
(
	ART_ID,
	SM_ID,
	MANDANT_ID,
	LIST_DURCHG_FG,
	ANZAHL_MARKT,
	STERNCHEN_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
lsl.art_id, 
lsl.sm_id, 
lsl.mandant_id, 
lsl.list_durchg_fg, 
lsl.anzahl_markt_soll, 
ls.sternchen_id

FROM dbp_view.v_sternchen_logik AS lsl
INNER JOIN dbp_view.v_l_sternchen AS ls
ON  lsl.list_durchg_fg = ls.list_durchg_fg
AND lsl.bezugsweg1_fg  = ls.bezugsweg1_fg
AND lsl.bezugsweg4_fg  = ls.bezugsweg4_fg
AND lsl.kdis0_fg       = ls.kdis0_fg
AND lsl.kdis1_fg       = ls.kdis1_fg
AND lsl.mandant_id     = ls.mandant_id
WHERE lsl.mandant_id = 1;
