CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_REGIO_ART_GP_WUP_ZU_1
(
	MANDANT_ID,
	REGIO_STUFE_ID,
	GP_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	REGIO_POLYGON_ID,
	VERSENDET_FG,
	LOESCH_FG
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
mandant_id, 
regio_stufe_id, 
gp_id, 
art_id, 
wup_id, 
nb_id, 
regio_polygon_id, 
versendet_fg, 
loesch_fg

FROM dbp_view.v_regio_art_gp_wup_zu_1
WHERE mandant_id = 1
AND loesch_fg = 0;
