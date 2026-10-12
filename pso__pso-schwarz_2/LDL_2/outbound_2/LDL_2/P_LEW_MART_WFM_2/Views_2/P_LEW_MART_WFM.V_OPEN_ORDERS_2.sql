CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_open_orders_2 (client_id, country_cd, src_wh_id, src_orig_item_nr,
dat_delivery, remaining_case, complete_case, remaining_ep, complete_ep, remainig_piece, complete_piece) AS SELECT CASE
  WHEN client_id = 23
  THEN 7
  ELSE client_id
  END AS client_id,
 country_cd,
 src_wh_id,
 ROUND(CAST(src_orig_item_nr AS BIGNUMERIC), 0) AS src_orig_item_nr,
 delivery_dt AS dat_delivery,
 SUM(CASE
   WHEN part_fg = 1 AND order_qty_type_cd = 0
   THEN CAST(order_remain_qty AS NUMERIC) * real_case_size
   ELSE 0.000
   END) AS remaining_case,
 SUM(CASE
   WHEN part_fg <> 1 AND order_qty_type_cd = 0
   THEN CAST(order_qty AS NUMERIC) * real_case_size
   ELSE 0.000
   END) AS complete_case,
 SUM(CASE
   WHEN part_fg = 1 AND order_qty_type_cd IN (1, 2, 3)
   THEN CAST(order_remain_qty AS NUMERIC) * case_factor * real_case_size
   ELSE 0.000
   END) AS remaining_ep,
 SUM(CASE
   WHEN part_fg <> 1 AND order_qty_type_cd IN (1, 2, 3)
   THEN ROUND(CAST(order_qty * case_factor * real_case_size AS BIGNUMERIC), 0)
   ELSE 0.000
   END) AS complete_ep,
 SUM(CASE
   WHEN part_fg = 1 AND order_qty_type_cd = 4
   THEN order_remain_qty
   ELSE 0.000
   END) AS remainig_piece,
 SUM(CASE
   WHEN part_fg <> 1 AND order_qty_type_cd = 4
   THEN order_qty
   ELSE 0.000
   END) AS complete_piece
FROM (SELECT REP_POS.client_id,
   REP_POS.loc_sid,
   COUNTRY.country_cd,
   REP_POS.order_record_id,
   REP_POS.order_pos_version_nr,
   REP_POS.order_pos_created_tmsp,
   REP_POS.delivery_dt,
   REP_POS.delivery_tmsp,
   REP_POS.order_status_cd,
   REP_POS.part_fg,
   REP_POS.item_sid,
   LOCO.src_wh_id,
   ITM.src_orig_item_nr,
   REP_POS.order_qty_type_cd,
   REP_POS.order_qty,
   REP_POS.order_remain_qty,
   REP_POS.case_factor,
   REP_POS.real_case_size,
   REP_POS.order_diff,
   REP_POS.task_id,
   REP_POS.dwh_cal_dt,
   REP_POS.dwh_load_id,
   REP_POS.dwh_created,
   REP_POS.dwh_updated
  FROM ldl_p_lew_core_ac.v_replenish_order_wh_record_pos_2 AS REP_POS
   INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS ITM_H ON REP_POS.client_id = ITM_H.client_id AND REP_POS.item_sid = ITM_H
      .item_sid AND REP_POS.dwh_cal_dt BETWEEN ITM_H.dwh_valid_from AND ITM_H.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITM ON REP_POS.client_id = ITM.client_id AND REP_POS.item_sid = ITM.item_sid
    AND REP_POS.real_case_size = CAST(ITM.src_case_size AS FLOAT64)
   INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS LOCO_H ON REP_POS.loc_sid = LOCO_H.loc_sid AND REP_POS.dwh_cal_dt
     BETWEEN LOCO_H.dwh_valid_from AND LOCO_H.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOCO ON REP_POS.loc_sid = LOCO.loc_sid AND REP_POS.dwh_cal_dt >= LOCO.opening_dt
     
   INNER JOIN (SELECT REP.client_id,
     REP.loc_sid,
     REP.order_record_id
    FROM ldl_p_lew_core_ac.v_replenish_order_wh_record_2 AS REP
     INNER JOIN ldl_p_lew_core_ac.v_supplier_hist_2 AS SUP ON REP.client_id = SUP.client_id AND REP.sup_sid = SUP.sup_sid
      AND REP.dwh_cal_dt BETWEEN SUP.dwh_valid_from AND SUP.dwh_valid_to
     INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS LOC_H ON REP.loc_sid = LOC_H.loc_sid AND REP.dwh_cal_dt BETWEEN
       LOC_H.dwh_valid_from AND LOC_H.dwh_valid_to
     INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON REP.loc_sid = LOC.loc_sid AND REP.dwh_cal_dt >= LOC.opening_dt
    GROUP BY REP.client_id,
     REP.loc_sid,
     REP.order_record_id) AS rep_h ON REP_POS.client_id = rep_h.client_id AND REP_POS.loc_sid = rep_h.loc_sid AND
     REP_POS.order_record_id = rep_h.order_record_id
   INNER JOIN ldl_p_lew_core_ac.v_client_2 AS COUNTRY_2 ON REP_POS.client_id = COUNTRY.client_id) AS replenish
WHERE order_status_cd IN (0, 1)
 AND delivery_dt >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
 AND CASE
        WHEN part_fg = 1 AND order_qty_type_cd = 0
        THEN CAST(order_remain_qty AS NUMERIC) * real_case_size
        ELSE 0.000
        END + CASE
        WHEN part_fg <> 1 AND order_qty_type_cd = 0
        THEN CAST(order_qty AS NUMERIC) * real_case_size
        ELSE 0.000
        END + CASE
       WHEN part_fg = 1 AND order_qty_type_cd IN (1, 2, 3)
       THEN CAST(order_remain_qty AS NUMERIC) * case_factor * real_case_size
       ELSE 0.000
       END + CASE
      WHEN part_fg <> 1 AND order_qty_type_cd IN (1, 2, 3)
      THEN ROUND(CAST(order_qty * case_factor * real_case_size AS BIGNUMERIC), 0)
      ELSE 0.000
      END + CASE
     WHEN part_fg = 1 AND order_qty_type_cd = 4
     THEN order_remain_qty
     ELSE 0.000
     END + CASE
    WHEN part_fg <> 1 AND order_qty_type_cd = 4
    THEN order_qty
    ELSE 0.000
    END <> 0
GROUP BY client_id,
 country_cd,
 src_wh_id,
 src_orig_item_nr,
 dat_delivery;