CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.v_ref_wh_bchmk_rpt_scty_2
AS
SELECT F.client_id AS client_bchmk_rpt_scty_id,
 F.wh_id AS wh_bchmk_rpt_scty_id,
 F.aspect_id AS aspect_bchmk_rpt_scty_id,
 F.wh_desc AS wh_bchmk_rpt_scty_desc,
 M.client_id,
 M.aspect_id,
 M.wh_id,
 M.wh_desc
FROM ldl_p_lew_mart_lead.v_org_wh_merge_2 AS F
 INNER JOIN ldl_p_lew_mart_lead.v_org_wh_merge_2 AS M ON F.client_id = M.client_id AND F.aspect_id = M.aspect_id;
