CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_POLYGON_SPR_ZU_LAND_2
-- Erweiterung um Dummy_2 -1 / sschuecke 09.08.2016
(
mandant_id
, regio_stufe_id
, land_id
, spr_id
, land_bez
)
AS
   SELECT
   mandant_id, regio_stufe_id, regio_polygon_id AS land_id, spr_id, regio_polygon_bez AS land_bez
   FROM dbp_view.v_regio_polygon_spr_zu_2
   WHERE mandant_id = 1
   AND spr_id = 22
   AND regio_stufe_id = 30

   UNION

   SELECT
   dt1.mandant_id, dt1.regio_stufe_id, dt1.land_id, dt1.spr_id, dt1.land_bez
   FROM
   (
   SELECT
   1 AS mandant_id, 30 AS regio_stufe_id, -1 AS land_id, 22 AS spr_id, ' '   AS land_bez
   ) dt1;