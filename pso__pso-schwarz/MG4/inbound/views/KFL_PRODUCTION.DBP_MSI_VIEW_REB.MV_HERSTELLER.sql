create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_HERSTELLER(
	HERST_ID,
	HERST_NAME,
	MANDANT_ID,
	STRASSE,
	PLZ,
	ORT,
	LAND_ID,
	HERST_FG
) as
   SELECT
   gp_id, gp_name, mandant_id, gp_strasse, gp_plz, gp_ort, land_id, herst_fg

   FROM dbp_view.v_gp
   WHERE mandant_id = 1
   AND herst_fg = 1
;