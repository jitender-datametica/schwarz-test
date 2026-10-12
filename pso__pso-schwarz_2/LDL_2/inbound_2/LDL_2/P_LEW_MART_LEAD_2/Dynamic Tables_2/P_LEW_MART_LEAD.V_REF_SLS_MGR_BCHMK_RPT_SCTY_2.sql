CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_REF_SLS_MGR_BCHMK_RPT_SCTY_2
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

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
   SELECT
     f.client_id AS client_bchmk_rpt_scty_id,
   f.wh_id AS wh_bchmk_rpt_scty_id,
   f.aspect_id AS aspect_bchmk_rpt_scty_id,
   f.sales_manager_id AS sls_mgr_bchmk_rpt_scty_id,
   f.wh_id_exp AS wh_id_exp_bchmk_rpt_scty,
   m.client_id,
   m.wh_id,
   m.aspect_id,
   m.sales_manager_id,
   m.wh_id_exp
  FROM p_lew_mart_lead.v_org_sales_manager_merge_2 AS f
   INNER JOIN p_lew_mart_lead.v_org_sales_manager_merge_2 AS m
   ON f.client_id = m.client_id
   AND f.aspect_id = m.aspect_id
   AND f.wh_id = m.wh_id
;