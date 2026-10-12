CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_SLS_MGR_BCHMK_RPT_SCTY
(
  client_bchmk_rpt_scty_id
, wh_bchmk_rpt_scty_id
, aspect_bchmk_rpt_scty_id
, sls_mgr_bchmk_rpt_scty_id
, wh_id_exp_bchmk_rpt_scty
, client_id
, wh_id
, aspect_id
, sales_manager_id
, wh_id_exp
)
AS
   SELECT
     client_bchmk_rpt_scty_id,
   wh_bchmk_rpt_scty_id,
   aspect_bchmk_rpt_scty_id,
   sls_mgr_bchmk_rpt_scty_id,
   wh_id_exp_bchmk_rpt_scty,
   client_id,
   wh_id,
   aspect_id,
   sales_manager_id,
   wh_id_exp
  FROM p_lew_mart_lead.v_ref_sls_mgr_bchmk_rpt_scty
;