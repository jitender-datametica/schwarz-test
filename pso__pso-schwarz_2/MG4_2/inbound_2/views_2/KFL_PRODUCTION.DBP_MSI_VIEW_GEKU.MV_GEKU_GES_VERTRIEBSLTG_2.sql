create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_GES_VERTRIEBSLTG_2(
	COUNTRY_UID,
	LAND_ISO,
	LAND_BEZ,
	VERTEILTAG_ID
) as
   SELECT
   country_uid
   , land_iso
   , land_bez
   , verteiltag_id
   FROM dbp_view.v_geku_ges_vertriebsltg_2;