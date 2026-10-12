CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_VERPART_EN
(
mandant_id
,verpart_id
,spr_id
,verpart_bez
)
AS
   SELECT
   v01.mandant_id, v01.verpart_id, MAX(v01.spr_id) AS spr_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.verpart_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.verpart_bez END)
   ) AS verpart_bez

   FROM dbp_view.v_artkz_verpart v01
   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.verpart_id;