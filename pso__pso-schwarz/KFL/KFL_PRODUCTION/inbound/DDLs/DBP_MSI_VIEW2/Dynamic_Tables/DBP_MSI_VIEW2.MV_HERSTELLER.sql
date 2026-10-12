CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_HERSTELLER
(
	HERST_ID,
	HERST_NAME,
	MANDANT_ID,
	STRASSE,
	PLZ,
	ORT,
	LAND_ID,
	HERST_FG,
	AMPEL_FLG
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
g.gp_id, 
gp_name, 
mandant_id, 
gp_strasse, 
gp_plz, 
gp_ort, 
land_id, 
herst_fg, 
1
FROM dbp_view.v_gp g
WHERE mandant_id = 1 
AND herst_fg = 1;
