CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_LAGER_BEWGRUND_SPR_ZU_EN_1
(
mandant_id
, GRUND
, BWART
, grund_bez
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.grund_id AS GRUND, v01.lager_bewart_id AS BWART, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.grund_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.grund_bez END)
   ) AS grund_bez, MAX(v01.spr_id) AS spr_id

   FROM dbp_view.v_lager_bewgrund_spr_zu_1 v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch
   AND v01.hist_fg = 0

   GROUP BY v01.mandant_id
   ,v01.grund_id
   ,v01.lager_bewart_id
;