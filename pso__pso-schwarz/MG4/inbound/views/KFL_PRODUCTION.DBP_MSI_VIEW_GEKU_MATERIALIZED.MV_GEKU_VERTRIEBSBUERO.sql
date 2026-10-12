create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_GEKU_VERTRIEBSBUERO(
	VERTRIEBSBUERO_UID,
	COUNTRY_UID,
	VERTRIEBSBUERO_BEZ
) as
   SELECT
   vertriebsbuero_uid
   , country_uid
   , vertriebsbuero_bez
   FROM dbp_view.v_geku_vertriebsbuero;