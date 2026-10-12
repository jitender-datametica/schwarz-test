CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_LEAD_EN
(
mandant_id
, lead_id
, lead_bez
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.lead_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.lead_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.lead_bez END)
   ) AS lead_bez, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_artkz_lead v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.lead_id ;