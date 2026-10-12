CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_VERTEILGEBIET_1
(
verteilgebiet_uid
,gebietsleiter_uid
,verteilgebiet_bez
)
AS
   SELECT
   verteilgebiet_uid
   , gebietsleiter_uid
   , verteilgebiet_bez
   FROM dbp_view.v_geku_verteilgebiet_1;