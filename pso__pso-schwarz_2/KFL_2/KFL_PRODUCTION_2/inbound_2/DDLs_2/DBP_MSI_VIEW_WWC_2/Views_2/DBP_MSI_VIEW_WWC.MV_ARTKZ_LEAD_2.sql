CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_LEAD_2
(
mandant_id
, lead_id
, spr_id
, lead_bez
)
AS
   SELECT
   v01.mandant_id, v01.lead_id, v01.spr_id, v01.lead_bez

   FROM dbp_view.v_artkz_lead_2 v01
   WHERE v01.spr_id = 22
;