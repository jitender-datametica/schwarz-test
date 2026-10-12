CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_GES_VERTRIEBSLTG_1
(
country_uid
,land_iso
,land_bez
,verteiltag_id
)
AS
   SELECT
   country_uid
   , land_iso
   , land_bez
   , verteiltag_id
   FROM dbp_view.v_geku_ges_vertriebsltg_1;