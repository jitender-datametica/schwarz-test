CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_POLYGON_SPR_ZU_DUMMY_2
-- Erweiterung um Dummy_2 -1 / sschuecke 09.08.2016
(
mandant_id
, regio_stufe_id
, dummy_id
, spr_id
, dummy_bez
)
AS
   SELECT
   mandant_id, regio_stufe_id, regio_polygon_id AS dummy_id, spr_id, regio_polygon_bez AS dummy_bez
   FROM dbp_view.v_regio_polygon_spr_zu_2
   WHERE mandant_id = 1
   AND spr_id = 22
   AND regio_stufe_id = 70

   UNION

   SELECT
   dt1.mandant_id, dt1.regio_stufe_id, dt1.dummy_id, dt1.spr_id, dt1.dummy_bez
   FROM
   (
   SELECT
   1 AS mandant_id, 70 AS regio_stufe_id, -1 AS dummy_id, 22 AS spr_id, ' '   AS dummy_bez
   ) dt1;