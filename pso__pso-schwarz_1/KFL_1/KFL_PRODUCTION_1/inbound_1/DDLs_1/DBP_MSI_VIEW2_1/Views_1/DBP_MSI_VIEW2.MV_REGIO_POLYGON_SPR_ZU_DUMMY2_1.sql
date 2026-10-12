CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_POLYGON_SPR_ZU_DUMMY2_1
-- Erweiterung um Dummy_1 -1 / sschuecke 09.08.2016
(
mandant_id
, regio_stufe_id
, dummy2_id
, spr_id
, dummy2_bez
)
AS
   SELECT
   mandant_id, regio_stufe_id, regio_polygon_id AS dummy2_id, spr_id, regio_polygon_bez AS dummy2_bez
   FROM dbp_view.v_regio_polygon_spr_zu_1
   WHERE mandant_id = 1
   AND spr_id = 22
   AND regio_stufe_id = 80

   UNION

   SELECT
   dt1.mandant_id, dt1.regio_stufe_id, dt1.dummy2_id, dt1.spr_id, dt1.dummy2_bez
   FROM
   (
   SELECT
   1 AS mandant_id, 80 AS regio_stufe_id, -1 AS dummy2_id, 22 AS spr_id, ' '   AS dummy2_bez
   ) dt1;