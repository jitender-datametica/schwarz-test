CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_HERSTELLER_2(
	HERST_ID,
	HERST_NAME,
	MANDANT_ID,
	STRASSE,
	PLZ,
	ORT,
	LAND_ID,
	HERST_FG,
	AMPEL_FLG
) AS
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
FROM dbp_view.v_gp_2 g
WHERE mandant_id != 1
AND herst_fg = 1;