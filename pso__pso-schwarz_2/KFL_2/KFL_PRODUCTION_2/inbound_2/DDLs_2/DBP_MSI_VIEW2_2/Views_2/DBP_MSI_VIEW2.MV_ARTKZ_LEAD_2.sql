CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_LEAD_2
(
lead_id
,lead_bez
)
AS
   SELECT
  lead_id, lead_bez

   FROM dbp_view.v_artkz_lead_2
   WHERE mandant_id = 1;