CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_REF_ACCT_MGR_BCHMK_RPT_SCTY_1
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

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
   SELECT
     f.client_id AS client_bchmk_rpt_scty_id,
   f.wh_id AS wh_bchmk_rpt_scty_id,
   f.aspect_id AS aspect_bchmk_rpt_scty_id,
   f.account_manager_id AS acct_mgr_bchmk_rpt_scty_id,
   m.client_id,
   m.wh_id,
   m.aspect_id,
   m.account_manager_id
  FROM p_lew_mart_lead.v_org_account_manager_merge_1 AS f
   INNER JOIN p_lew_mart_lead.v_org_account_manager_merge_1 AS m
   ON f.client_id = m.client_id
   AND f.aspect_id = m.aspect_id
   AND f.wh_id = m.wh_id
;