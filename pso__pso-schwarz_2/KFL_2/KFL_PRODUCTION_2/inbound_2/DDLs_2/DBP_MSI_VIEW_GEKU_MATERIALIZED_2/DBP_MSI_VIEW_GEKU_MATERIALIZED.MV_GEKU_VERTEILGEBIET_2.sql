create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_GEKU_VERTEILGEBIET_2(
	VERTEILGEBIET_UID,
	GEBIETSLEITER_UID,
	VERTEILGEBIET_BEZ
) as
   SELECT
   verteilgebiet_uid
   , gebietsleiter_uid
   , verteilgebiet_bez
   FROM dbp_view.v_geku_verteilgebiet_2;
