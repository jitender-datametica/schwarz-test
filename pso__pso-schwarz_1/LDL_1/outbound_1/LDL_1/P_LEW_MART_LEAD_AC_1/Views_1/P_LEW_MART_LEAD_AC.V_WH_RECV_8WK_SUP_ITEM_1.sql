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


/* week which contains, the last 8 weeks of receivings of items including the actual week */
/* week which contains, the last 8 weeks of receivings of items including the actual week */
/* suppliers who delivered items within the last 8 weeks */ /* suppliers who delivered items within the last 8 weeks */
/* last receiving date */ /* last receiving date */ CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_wh_recv_8wk_sup_item_1
(client_id, wh_loc_sid, wh_id, item_sid, sup_sid, recv_last8wk_cy_week, last_recv_dat) OPTIONS(DESCRIPTION = `VIEW`) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_wh_recv_8wk_sup_item_1;