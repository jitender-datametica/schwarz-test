CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_VERTRIEBSBUERO_1
(
vertriebsbuero_uid
,country_uid
,vertriebsbuero_bez
)
AS
   SELECT
   vertriebsbuero_uid
   , country_uid
   , vertriebsbuero_bez
   FROM dbp_view.v_geku_vertriebsbuero_1;