CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_HERSTELLER(
	HERST_ID,
	HERST_NAME,
	MANDANT_ID,
	STRASSE,
	PLZ,
	ORT,
	LAND_ID,
	HERST_FG
) AS SELECT
   gp_id,
   gp_name,
   mandant_id,
   gp_strasse,
   gp_plz,
   gp_ort,
   land_id,
   herst_fg
FROM dbp_view.v_gp
WHERE herst_fg = 1;