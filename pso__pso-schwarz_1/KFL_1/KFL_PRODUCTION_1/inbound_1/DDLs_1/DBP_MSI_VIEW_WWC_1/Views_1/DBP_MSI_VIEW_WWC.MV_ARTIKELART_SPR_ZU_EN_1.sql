CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTIKELART_SPR_ZU_EN_1
(
mandant_id
,MTART
,artikelart_bez
,spr_id
)
AS
   SELECT
   v01.mandant_id, v01.artikelart_id  AS MTART, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.artikelart_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.artikelart_bez END)
   ) AS artikelart_bez, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_artikelart_spr_zu_1 v01

   WHERE spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.artikelart_id;