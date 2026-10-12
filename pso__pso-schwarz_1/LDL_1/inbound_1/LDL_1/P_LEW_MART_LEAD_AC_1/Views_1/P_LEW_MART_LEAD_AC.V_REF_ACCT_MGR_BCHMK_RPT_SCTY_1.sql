CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_ACCT_MGR_BCHMK_RPT_SCTY_1
(
  client_bchmk_rpt_scty_id
, wh_bchmk_rpt_scty_id
, aspect_bchmk_rpt_scty_id
, acct_mgr_bchmk_rpt_scty_id
, client_id
, wh_id
, aspect_id
, account_manager_id
)
AS
   SELECT
     client_bchmk_rpt_scty_id,
   wh_bchmk_rpt_scty_id,
   aspect_bchmk_rpt_scty_id,
   acct_mgr_bchmk_rpt_scty_id,
   client_id,
   wh_id,
   aspect_id,
   account_manager_id
  FROM p_lew_mart_lead.v_ref_acct_mgr_bchmk_rpt_scty_1
;