CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_store_day_itm_pick_deliv (client_id, loc_sid_store, orig_item_nr,
wh_loc_sid, dat_formdate, cy_month, cy_week, stc_slot_id, qty_del_case, order_cnt) AS
/* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_delivery mit Core Objekt p_lew_core_ac.v_item_delivery */
/* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_fv_delivery fv mit Core Objekt p_lew_core_ac.v_item_fruits_vegetables_delivery */
SELECT src.client_id,
 src.loc_sid_store,
 src.orig_item_nr,
 src.wh_loc_sid,
 src.dat_formdate,
 CAL.cy_month,
 CAL.cy_week,
 src.stc_slot_id,
 SUM(src.qty_case_del) AS qty_del_case,
 SUM(src.order_cnt) AS order_cnt
FROM (SELECT MOV.client_id,
    MOV.loc_sid_store,
    SK.orig_item_nr,
    MOV.loc_sid_wh AS wh_loc_sid,
    MOV.dwh_cal_dt AS dat_formdate,
    MOV.stc_slot_nr AS stc_slot_id,
    SUM(MOV.del_case_qty) AS qty_case_del,
    COUNT(DISTINCT MOV.receipt_id) AS order_cnt
   FROM ldl_p_lew_core_ac.v_item_delivery AS MOV
    INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey AS SK ON MOV.client_id = SK.client_id AND MOV.item_sid = SK.item_sid
        AND MOV.dwh_cal_dt BETWEEN SK.dat_rec_start AND SK.dat_rec_end
    LEFT JOIN ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery AS FV ON MOV.client_id = FV.client_id AND MOV.loc_sid_store
         = FV.loc_sid_store AND MOV.item_sid = FV.item_sid AND MOV.dwh_cal_dt = FV.dwh_cal_dt
      /* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_fv_delivery fv mit Core Objekt p_lew_core_ac.v_item_fruits_vegetables_delivery */
      
   WHERE MOV.del_case_qty <> 0
    AND MOV.delivery_type_id = 2
    AND FV.client_id IS NULL
   GROUP BY MOV.client_id,
    MOV.loc_sid_store,
    SK.orig_item_nr,
    wh_loc_sid,
    dat_formdate,
    stc_slot_id
   UNION ALL
   SELECT FV.client_id,
    FV.loc_sid_store,
    SK.orig_item_nr,
    FV.loc_sid_wh AS wh_loc_sid,
    FV.dwh_cal_dt AS dat_formdate,
    FV.slot_nr AS stc_slot_id,
    SUM(FV.case_qty) AS qty_case_del,
    COUNT(DISTINCT FV.receipt_id_fv_del) AS order_cnt
   FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery AS FV
    INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey AS SK ON FV.client_id = SK.client_id AND FV.item_sid = SK.item_sid
        AND FV.dwh_cal_dt BETWEEN SK.dat_rec_start AND SK.dat_rec_end
   WHERE FV.case_qty <> 0
   GROUP BY FV.client_id,
    FV.loc_sid_store,
    SK.orig_item_nr,
    wh_loc_sid,
    dat_formdate,
    stc_slot_id) AS src
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON src.dat_formdate = CAL.cal_dt
GROUP BY src.client_id,
 src.loc_sid_store,
 src.orig_item_nr,
 src.wh_loc_sid,
 src.dat_formdate,
 CAL.cy_month,
 CAL.cy_week,
 src.stc_slot_id;


/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_bil_ac.v_warehouse", "p_lew_core_ac.v_wawi_ref_client_currency_rate", "p_lew_core_ac.v_wawi_itm_item_wh", "p_lew_core_ac.v_wawi_itm_wh_slot", "p_lew_core_ac.v_item_delivery", "p_lew_core_ac.v_item_fruits_vegetables_delivery", "p_lew_core_ac.v_wawi_itm_item_skey_act" ****/