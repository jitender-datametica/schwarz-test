/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20201106_2646_PV_BNL_LEAD_Switch_Table
#            DDL for v_wh_pch_switch_2
#----------------------------------------------------------------------------
# History:
#  1.0  30.03.2020    Torsten Bachmann            Initial
#  1.1  29.07.2020    Torsten Bachmann            Table t_wh_pch_switch_2 moved from P_LEW_TMP.BIL  to CORE layer
#  1.2  16.10.2020    Aleksander Bialek           View repointed from P_LEW_TMP.core_switch  table to BNL fact table (to be reverted afterdata team fix for core_switch_table)
#  1.3  06.11.2020    Aleksander Bialek    View pointed additionally to materialized switch table "t_wh_pch_switch_2" (where we will adjust the switch dates manually)
#  1.4  08.04.2021    Aleksander Bialek           Logic moved into P_LEW_TMP.the  script filling BIl table. View repointed to BIL table.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_WH_PCH_SWITCH_2 COMMENT = 'Steering Table to determine when a country_2/wh switched to new BNL calculation.'
/*
#DescStart#
#$Revision: 16855 $, $LastChangedBy: abialek $
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
        client_id 
      , wh_id 
      , pch_bnl_switch_fg
      , switch_date 
      , dwh_updated
FROM P_LEW_BIL_AC.v_wh_pch_switch_2
;
