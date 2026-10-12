CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_POLYGON_SPR_ZU_UMLAND
-- Erweiterung um Dummy -1 / sschuecke 09.08.2016
(
mandant_id
, regio_stufe_id
, umland_id
, spr_id
, umland_bez
)
AS
   SELECT
   mandant_id, regio_stufe_id, regio_polygon_id AS umland_id, spr_id, regio_polygon_bez AS umland_bez
   FROM dbp_view.v_regio_polygon_spr_zu
   WHERE mandant_id = 1
   AND spr_id = 22
   AND regio_stufe_id = 40

   UNION

   SELECT
   dt1.mandant_id, dt1.regio_stufe_id, dt1.umland_id, dt1.spr_id, dt1.umland_bez
   FROM
   (
   SELECT
   1 AS mandant_id, 40 AS regio_stufe_id, -1 AS umland_id, 22 AS spr_id, ' '   AS umland_bez
   ) dt1;