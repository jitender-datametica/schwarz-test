CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_LAGERORT_SPR_ZU_EN_2
(
mandant_id
, WERKS
, nb_id
, LGORT
, lagerort_bez
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.wup_id AS WERKS, v01.nb_id, v01.lagerort_id AS LGORT, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.lagerort_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.lagerort_bez END)
   ) AS lagerort_bez, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_lagerort_spr_zu_2 v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.wup_id
   ,v01.nb_id
   ,v01.lagerort_id;