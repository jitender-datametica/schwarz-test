CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_STERNCHEN_LOGIK_KREIS_2
(
	ART_ID,
	KREISTYP_GRUPPE_ID,
	MANDANT_ID,
	LIST_DURCHG_FG,
	ANZAHL_MARKT,
	STERNCHEN_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.art_id, 
v01.kreistyp_gruppe_id, 
v01.mandant_id, 
v01.list_durchg_fg, 
v01.anzahl_markt_soll, 
v02.sternchen_id

FROM dbp_view.v_sternchen_logik_kreis_2 v01
JOIN dbp_view.v_l_sternchen_2 v02
ON  v01.list_durchg_fg  = v02.list_durchg_fg
AND v01.bezugsweg1_fg   = v02.bezugsweg1_fg
AND v01.bezugsweg4_fg   = v02.bezugsweg4_fg
AND v01.kdis0_fg        = v02.kdis0_fg
AND v01.kdis1_fg        = v02.kdis1_fg
AND v01.mandant_id      = v02.mandant_id
WHERE v01.mandant_id = 1;
