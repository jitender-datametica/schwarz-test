/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_wh_pch_switch_2
#----------------------------------------------------------------------------
# History:
#  1.0 2021-02-18 Marcin Malec       Copying mart_lead view to bil
#  1.1 2021-04-07 Aleksander Bialek       Adding dwh_updated column 
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_WH_PCH_SWITCH_2 COMMENT = 'Steering Table to determine when a country_2/wh switched to new BNL calculation.'
(
  client_id
, wh_id
, pch_bnl_switch_fg
, switch_date
, dwh_updated
) AS
SELECT
  v.client_id
, v.wh_id
, v.pch_bnl_switch_fg
, v.switch_date
, v.dwh_updated
FROM P_LEW_BIL.v_wh_pch_switch_2 AS v
;