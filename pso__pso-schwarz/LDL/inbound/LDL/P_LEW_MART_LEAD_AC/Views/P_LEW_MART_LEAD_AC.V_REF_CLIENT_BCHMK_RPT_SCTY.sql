CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_CLIENT_BCHMK_RPT_SCTY
(
  client_bchmk_rpt_scty_id
, client_id
)
AS
   SELECT
     client_bchmk_rpt_scty_id,
   client_id
  FROM p_lew_mart_lead.v_ref_client_bchmk_rpt_scty
;