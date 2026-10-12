CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_MUTTER_SPR_ZU_EN
(
mandant_id
, art_id
, art_bez
, art_id_bez
, spr_id
)
AS
   SELECT
   v02.mandant_id, v02.art_id, v02.art_bez, CAST(CAST(v02.art_id AS CHAR(10)) || ' ' || v02.art_bez AS CHAR(60)) AS art_id_bez, v02.spr_id

   FROM
   (
   SELECT
   v01.mandant_id, v01.art_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.art_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.art_bez END)
   ) AS art_bez, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_art_spr_zu v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.art_id
   ) v02;