CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_LEAD
(
lead_id
,lead_bez
)
AS
   SELECT
  lead_id, lead_bez

   FROM dbp_view.v_artkz_lead
   WHERE mandant_id = 1;