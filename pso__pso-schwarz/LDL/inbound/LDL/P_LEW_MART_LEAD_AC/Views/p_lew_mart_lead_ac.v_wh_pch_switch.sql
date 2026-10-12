/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_wh_pch_switch
#----------------------------------------------------------------------------
# History:
#  1.0  30.03.2020    Torsten Bachmann            Initial
#  1.1  16.10.2020    Aleksander Bialek           View adjusted to lew_mart_lead.v_wh_pch_switch according to changes 
#  1.2  07.04.2021    Aleksander Bialek           Adding dwh_updated 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_WH_PCH_SWITCH COMMENT = 'Steering Table to determine when a country/wh switched to new BNL calculation.'
/*
#DescStart#
#$Revision: 16850 $, $LastChangedBy: abialek $
#SubjectAreas#: Access Layer
#DescEnd#
*/
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
FROM P_LEW_MART_LEAD.v_wh_pch_switch AS v
;


