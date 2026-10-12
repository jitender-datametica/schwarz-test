CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_LEAD_2
(
mandant_id
,lead_id
,lead_bez
)
AS
   SELECT
   mandant_id, lead_id, lead_bez

   FROM dbp_view.v_artkz_lead_2
   WHERE mandant_id = 1
   AND spr_id =22;