CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.v_ref_acct_mgr_bchmk_rpt_scty_1
AS
SELECT F.client_id AS client_bchmk_rpt_scty_id,
 F.wh_id AS wh_bchmk_rpt_scty_id,
 F.aspect_id AS aspect_bchmk_rpt_scty_id,
 F.account_manager_id AS acct_mgr_bchmk_rpt_scty_id,
 M.client_id,
 M.wh_id,
 M.aspect_id,
 M.account_manager_id
FROM ldl_p_lew_mart_lead.v_org_account_manager_merge_1 AS F
 INNER JOIN ldl_p_lew_mart_lead.v_org_account_manager_merge_1 AS M ON F.client_id = M.client_id AND F.aspect_id = M.aspect_id
     AND F.wh_id = M.wh_id;

