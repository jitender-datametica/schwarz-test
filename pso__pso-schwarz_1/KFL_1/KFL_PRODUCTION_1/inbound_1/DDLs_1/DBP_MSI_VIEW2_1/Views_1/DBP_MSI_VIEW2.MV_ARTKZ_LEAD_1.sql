CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_LEAD_1
(
lead_id
,lead_bez
)
AS
   SELECT
  lead_id, lead_bez

   FROM dbp_view.v_artkz_lead_1
   WHERE mandant_id = 1;