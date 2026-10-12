CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_STORE_DAY_ITM_PICK_DELIV_2
(
   client_id
  ,loc_sid_store
  ,orig_item_nr
  ,wh_loc_sid
  ,dat_formdate
  ,cy_month
  ,cy_week
  ,stc_slot_id
  ,qty_del_case
  ,order_cnt
)
AS
SELECT
src.client_id,
src.loc_sid_store,
src.orig_item_nr,
src.wh_loc_sid,
src.dat_formdate,
cal.cy_month,
cal.cy_week,
src.stc_slot_id,
SUM(src.qty_case_del) AS qty_del_case,
SUM(src.order_cnt) AS order_cnt
FROM
(SELECT
mov.client_id,
mov.loc_sid_store,
sk.orig_item_nr AS orig_item_nr,
mov.loc_sid_wh AS wh_loc_sid,
mov.dwh_cal_dt AS dat_formdate,
mov.stc_slot_nr AS stc_slot_id,
SUM(mov.del_case_qty) AS qty_case_del,
COUNT(DISTINCT mov.receipt_id) AS order_cnt
FROM p_lew_core_ac.v_item_delivery_2 mov /* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_delivery mit Core Objekt p_lew_core_ac.v_item_delivery_2*/

INNER JOIN p_lew_core_ac.v_wawi_itm_item_skey_2 sk
ON mov.client_id = sk.client_id
  AND mov.item_sid = sk.item_sid
  AND mov.dwh_cal_dt BETWEEN sk.dat_rec_start AND sk.dat_rec_end

LEFT OUTER JOIN p_lew_core_ac.v_item_fruits_vegetables_delivery_2 fv /* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_fv_delivery fv mit Core Objekt p_lew_core_ac.v_item_fruits_vegetables_delivery_2*/
ON mov.client_id = fv.client_id
  AND mov.loc_sid_store = fv.loc_sid_store
  AND mov.item_sid = fv.item_sid
  AND mov.dwh_cal_dt = fv.dwh_cal_dt

WHERE mov.del_case_qty IS NOT NULL
  AND mov.del_case_qty <> 0
  AND mov.delivery_type_id = 2
  AND fv.client_id IS NULL

GROUP BY 1,2,3,4,5,6

UNION ALL
SELECT
fv.client_id,
fv.loc_sid_store,
sk.orig_item_nr AS orig_item_nr,
fv.loc_sid_wh AS wh_loc_sid,
fv.dwh_cal_dt AS dat_formdate,
fv.slot_nr AS stc_slot_id,
SUM(fv.case_qty) AS qty_case_del,
COUNT(DISTINCT fv.receipt_id_fv_del) AS order_cnt
FROM p_lew_core_ac.v_item_fruits_vegetables_delivery_2 fv /* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_fv_delivery fv mit Core Objekt p_lew_core_ac.v_item_fruits_vegetables_delivery_2*/

INNER JOIN p_lew_core_ac.v_wawi_itm_item_skey_2 sk
ON fv.client_id = sk.client_id
  AND fv.item_sid = sk.item_sid
  AND fv.dwh_cal_dt BETWEEN sk.dat_rec_start AND sk.dat_rec_end

WHERE fv.case_qty IS NOT NULL
  AND fv.case_qty <> 0

GROUP BY 1,2,3,4,5,6

)src

INNER JOIN p_lew_core_ac.v_cal_calendarday_2 cal
ON cal.cal_dt = src.dat_formdate

GROUP BY 1,2,3,4,5,6,7,8
;

/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_bil_ac.v_warehouse_2", "p_lew_core_ac.v_wawi_ref_client_currency_rate_2", "p_lew_core_ac.v_wawi_itm_item_wh_2", "p_lew_core_ac.v_wawi_itm_wh_slot_2", "p_lew_core_ac.v_item_delivery_2", "p_lew_core_ac.v_item_fruits_vegetables_delivery_2", "p_lew_core_ac.v_wawi_itm_item_skey_act_2" ****/

