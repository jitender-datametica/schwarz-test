CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_POLYGON_SPR_ZU
(
mandant_id
, regio_stufe_id
, regio_polygon_id
, spr_id
, regio_polygon_bez
)
AS
   SELECT
   mandant_id, regio_stufe_id, regio_polygon_id, spr_id, regio_polygon_bez
   FROM dbp_view.v_regio_polygon_spr_zu
   WHERE mandant_id = 1
   AND spr_id = 22;