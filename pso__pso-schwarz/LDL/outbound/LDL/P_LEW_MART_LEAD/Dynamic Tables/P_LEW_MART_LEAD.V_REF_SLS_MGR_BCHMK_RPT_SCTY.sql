
CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.v_ref_sls_mgr_bchmk_rpt_scty
AS
SELECT F.client_id AS client_bchmk_rpt_scty_id,
 F.wh_id AS wh_bchmk_rpt_scty_id,
 F.aspect_id AS aspect_bchmk_rpt_scty_id,
 F.sales_manager_id AS sls_mgr_bchmk_rpt_scty_id,
 F.wh_id_exp AS wh_id_exp_bchmk_rpt_scty,
 M.client_id,
 M.wh_id,
 M.aspect_id,
 M.sales_manager_id,
 M.wh_id_exp
FROM ldl_p_lew_mart_lead.v_org_sales_manager_merge AS F
 INNER JOIN ldl_p_lew_mart_lead.v_org_sales_manager_merge AS M ON F.client_id = M.client_id AND F.aspect_id = M.aspect_id
     AND F.wh_id = M.wh_id;

