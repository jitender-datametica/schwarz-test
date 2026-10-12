CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_GEBIETS_BEREICH_2
(
gebiets_bereich_uid
,verteilgebiet_uid
,gebiets_betreuer_uid
,gebiets_bereich_bez
)
AS
   SELECT
   gebiets_bereich_uid
   , verteilgebiet_uid
   , gebiets_betreuer_uid
   , gebiets_bereich_bez
   FROM dbp_view.v_geku_gebiets_bereich_2;