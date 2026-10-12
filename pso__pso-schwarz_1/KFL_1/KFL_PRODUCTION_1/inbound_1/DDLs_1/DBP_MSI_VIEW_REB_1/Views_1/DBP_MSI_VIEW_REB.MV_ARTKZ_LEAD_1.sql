CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_LEAD_1
(
mandant_id
,lead_id
,lead_bez
)
AS
   SELECT
   mandant_id, lead_id, lead_bez

   FROM dbp_view.v_artkz_lead_1
   WHERE mandant_id = 1
   AND spr_id =22;