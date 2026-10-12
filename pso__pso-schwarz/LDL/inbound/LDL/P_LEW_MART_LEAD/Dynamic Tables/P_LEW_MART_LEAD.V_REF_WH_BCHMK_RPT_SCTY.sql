CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_REF_WH_BCHMK_RPT_SCTY
(
  client_bchmk_rpt_scty_id
, wh_bchmk_rpt_scty_id
, aspect_bchmk_rpt_scty_id
, wh_bchmk_rpt_scty_desc
, client_id
, aspect_id
, wh_id
, wh_desc
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
   f.wh_desc AS wh_bchmk_rpt_scty_desc,
   m.client_id,
   m.aspect_id,
   m.wh_id,
   m.wh_desc
  FROM p_lew_mart_lead.v_org_wh_merge AS f
   INNER JOIN p_lew_mart_lead.v_org_wh_merge AS m
   ON f.client_id = m.client_id
   AND f.aspect_id = m.aspect_id
;