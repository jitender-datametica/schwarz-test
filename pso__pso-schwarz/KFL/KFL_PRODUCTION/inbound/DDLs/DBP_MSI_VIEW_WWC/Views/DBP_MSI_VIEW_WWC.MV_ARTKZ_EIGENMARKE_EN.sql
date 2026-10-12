CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_EIGENMARKE_EN
(
mandant_id
, eigenmarke_id
, eigenmarke_bez
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.eigenmarke_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.eigenmarke_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.eigenmarke_bez END)
   ) AS eigenmarke_bez, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_artkz_eigenmarke v01

   WHERE spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.eigenmarke_id;