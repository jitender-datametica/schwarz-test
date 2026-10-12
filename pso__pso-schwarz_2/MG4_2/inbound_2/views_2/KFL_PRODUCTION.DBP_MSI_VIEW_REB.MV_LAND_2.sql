create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_LAND_2(
	LAND_BEZ,
	LAND_ISO,
	EU_LAND_FG,
	LAND_ID
) as
   SELECT
  land_bez, land_iso, eu_land_fg, land_id

   FROM dbp_view.v_land_2
   WHERE mandant_id = 1
   AND land_id = 'DE';