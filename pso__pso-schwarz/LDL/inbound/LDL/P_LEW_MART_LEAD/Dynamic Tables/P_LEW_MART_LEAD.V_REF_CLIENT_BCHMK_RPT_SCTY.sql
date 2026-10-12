CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_REF_CLIENT_BCHMK_RPT_SCTY
(
  client_bchmk_rpt_scty_id
, client_id
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
   SELECT
     f.client_id AS client_bchmk_rpt_scty_id,
   m.client_id
  FROM p_lew_mart_lead.v_ref_client AS f
   CROSS JOIN p_lew_mart_lead.v_ref_client AS m
;
