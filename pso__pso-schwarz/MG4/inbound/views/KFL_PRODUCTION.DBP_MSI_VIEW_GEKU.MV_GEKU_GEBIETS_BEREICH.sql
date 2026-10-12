create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_GEBIETS_BEREICH(
	GEBIETS_BEREICH_UID,
	VERTEILGEBIET_UID,
	GEBIETS_BETREUER_UID,
	GEBIETS_BEREICH_BEZ
) as
   SELECT
   gebiets_bereich_uid
   , verteilgebiet_uid
   , gebiets_betreuer_uid
   , gebiets_bereich_bez
   FROM dbp_view.v_geku_gebiets_bereich;