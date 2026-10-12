/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_MAT_AGG_STORE_DAY_PICK_DELIV_2
#----------------------------------------------------------------------------
# History:
#  1.0  07.09.2020    Wenz, Tobias        	Initial Version
#                                           
#  1.1  30.11.2020    Stemke		            Strukturabgleich Delta bis 25.11.2020
#                                           
#  1.2  09.10.2025    Rahman, Md Fahmin     RP050: Add new column QTY_ORD_CASE for 'Ausgelieferte Kolli inklusive Zuteilungen' metric
#
#----------------------------------------------------------------------------
*/


-- All non-aggregated columns from the outer SELECT

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_agg_store_day_pick_deliv_2 (client_id, loc_sid_store_move_to, wh_loc_sid
, wh_id, aspect_id, dat_formdate, cy_month, cy_week, stc_slot_id, qty_ord_case, qty_del_case, order_cnt, dwh_updated) AS
/* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_delivery mit Core Objekt p_lew_core_ac.v_item_delivery_2 */
-- NEW COLUMN IN INNER SELECT (using NULL). Added this to the second inner SELECT from v_item_fruits_vegetables_delivery_2, as the column doesn't exist in this source.

/* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_fv_delivery fv mit Core Objekt p_lew_core_ac.v_item_fruits_vegetables_delivery_2 */
SELECT src.client_id,
 ACT.loc_sid_store_move_to,
 src.wh_loc_sid,
 LOC.src_wh_id AS wh_id,
 ACT.aspect_id,
 src.dat_formdate,
 CAL.cy_month,
 CAL.cy_week,
 src.stc_slot_id,
 SUM(src.qty_ord_case) AS qty_ord_case,
 SUM(src.qty_del_case) AS qty_del_case,
 SUM(src.order_cnt) AS order_cnt,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM (SELECT MOV.client_id,
    MOV.loc_sid_store,
    SK.orig_item_nr,
    MOV.loc_sid_wh AS wh_loc_sid,
    MOV.dwh_cal_dt AS dat_formdate,
    MOV.stc_slot_nr AS stc_slot_id,
    SUM(MOV.ordered_case_qty) AS qty_ord_case,
    SUM(MOV.del_case_qty) AS qty_del_case,
    COUNT(DISTINCT MOV.receipt_id) AS order_cnt
   FROM ldl_p_lew_core_ac.v_item_delivery_2 AS MOV
    INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey_2 AS SK ON MOV.client_id = SK.client_id AND MOV.item_sid = SK.item_sid
        AND MOV.dwh_cal_dt BETWEEN SK.dat_rec_start AND SK.dat_rec_end
    LEFT JOIN ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery_2 AS FV ON MOV.client_id = FV.client_id AND MOV.loc_sid_store
         = FV.loc_sid_store AND MOV.item_sid = FV.item_sid AND MOV.dwh_cal_dt = FV.dwh_cal_dt
      /* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_fv_delivery fv mit Core Objekt p_lew_core_ac.v_item_fruits_vegetables_delivery_2 */
      
   WHERE COALESCE(MOV.del_case_qty, 0) + COALESCE(MOV.ordered_case_qty, 0) <> 0
    AND MOV.delivery_type_id IN (1, 2)
    AND FV.client_id IS NULL
   GROUP BY MOV.client_id,
    MOV.loc_sid_store,
    SK.orig_item_nr,
    wh_loc_sid,
    dat_formdate,
    stc_slot_id -- GROUP BY for the non-aggregated columns in this subquery

   UNION ALL
   SELECT FV.client_id,
    FV.loc_sid_store,
    SK.orig_item_nr,
    FV.loc_sid_wh AS wh_loc_sid,
    FV.dwh_cal_dt AS dat_formdate,
    FV.slot_nr AS stc_slot_id,
    CAST(NULL AS BIGNUMERIC) AS qty_ord_case,
    SUM(FV.case_qty) AS qty_del_case,
    COUNT(DISTINCT FV.receipt_id_fv_del) AS order_cnt
   FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery_2 AS FV
    INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey_2 AS SK ON FV.client_id = SK.client_id AND FV.item_sid = SK.item_sid
        AND FV.dwh_cal_dt BETWEEN SK.dat_rec_start AND SK.dat_rec_end
   WHERE FV.case_qty <> 0
   GROUP BY FV.client_id,
    FV.loc_sid_store,
    SK.orig_item_nr,
    wh_loc_sid,
    dat_formdate,
    stc_slot_id) AS src
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON src.dat_formdate = CAL.cal_dt
 INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_2 AS ACT ON src.client_id = ACT.client_id AND src.loc_sid_store = ACT.loc_sid_store
     AND ACT.aspect_id = 1
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON src.client_id = LOC.client_id AND src.wh_loc_sid = LOC.loc_sid AND
   LOC.wh_store_mark = 'B'
GROUP BY src.client_id,
 ACT.loc_sid_store_move_to,
 src.wh_loc_sid,
 wh_id,
 ACT.aspect_id,
 src.dat_formdate,
 CAL.cy_month,
 CAL.cy_week,
 src.stc_slot_id;


/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_cal_calendarday_2", "p_lew_core_ac.v_item_delivery_2", "p_lew_core_ac.v_wawi_itm_item_skey_2", "p_lew_core_ac.v_item_fruits_vegetables_delivery_2" ****/