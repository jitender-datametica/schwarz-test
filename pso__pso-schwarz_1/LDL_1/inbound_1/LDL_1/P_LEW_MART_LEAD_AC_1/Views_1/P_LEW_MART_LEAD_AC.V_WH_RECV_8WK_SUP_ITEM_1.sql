/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.V_WH_RECV_8WK_SUP_ITEM_1
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | NAME              | DESCRIPTION OF CHANGES
# 1.0   06-12-2017   Michael Strauch     INITIAL VERSION
#                                        20171201_1515_TD_supplier_last8weeks_Rep1
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_WH_RECV_8WK_SUP_ITEM_1 COMMENT = 'View'

(
       client_id
      ,wh_loc_sid
      ,wh_id
      ,item_sid
      ,sup_sid /*suppliers who delivered items within the last 8 weeks*/
      ,recv_last8wk_cy_week /*week which contains, the last 8 weeks of receivings of items including the actual week*/
      ,last_recv_dat /*last receiving date*/

)

AS

SELECT client_id
      ,wh_loc_sid
      ,wh_id
      ,item_sid
      ,sup_sid /*suppliers who delivered items within the last 8 weeks*/
      ,recv_last8wk_cy_week /*week which contains, the last 8 weeks of receivings of items including the actual week*/
      ,last_recv_dat /*last receiving date*/
FROM P_LEW_MART_LEAD.V_WH_RECV_8WK_SUP_ITEM_1
;
