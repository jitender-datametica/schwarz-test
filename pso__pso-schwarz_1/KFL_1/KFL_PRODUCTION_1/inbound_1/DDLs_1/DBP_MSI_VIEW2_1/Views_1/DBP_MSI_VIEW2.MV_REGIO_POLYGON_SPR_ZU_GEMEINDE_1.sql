CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_POLYGON_SPR_ZU_GEMEINDE_1
-- Erweiterung um Dummy_1 -1 / sschuecke 09.08.2016
(
mandant_id
, regio_stufe_id
, gemeinde_id
, spr_id
, gemeinde_bez
)
AS
   SELECT
   mandant_id, regio_stufe_id, regio_polygon_id AS gemeinde_id, spr_id, regio_polygon_bez AS gemeinde_bez
   FROM dbp_view.v_regio_polygon_spr_zu_1
   WHERE mandant_id = 1
   AND spr_id = 22
   AND regio_stufe_id = 10

   UNION

   SELECT
   dt1.mandant_id, dt1.regio_stufe_id, dt1.gemeinde_id, dt1.spr_id, dt1.gemeinde_bez
   FROM
   (
   SELECT
   1 AS mandant_id, 10 AS regio_stufe_id, -1 AS gemeinde_id, 22 AS spr_id, ' '   AS gemeinde_bez
   ) dt1;