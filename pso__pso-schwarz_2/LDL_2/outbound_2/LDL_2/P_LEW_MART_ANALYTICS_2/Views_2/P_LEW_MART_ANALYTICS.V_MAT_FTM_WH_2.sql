CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_mat_ftm_wh_2 (client_id, dat_formdate, wh_id, item_id, orig_item_nr,
buying_val) AS
-- here was a select FROM LDL.P_LEW_MART_MSI_AC.V_MOV_ITEM_RECEIVE_WH_2, so I take only what is in scope, not all available columns.

-- end
 SELECT WE.client_id,
 TAG.dat_calendar AS dat_formdate,
 WE.wh_id,
 WE.item_id,
 WE.orig_item_nr,
  CAST(SUM(WE.we_ek_wert) AS BIGNUMERIC) / NULLIF(SUM(WE.we_menge), 0) AS buying_val
FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS TAG_2
 LEFT JOIN (SELECT WE.client_id,
   WE.wh_id,
   WE.item_id,
   UWG_INFO.itemgroup_int_id,
   WE.dat_formdate,
   TAG0.cy_day_sequence,
   ART_INFO.orig_item_nr,
   SUM(CASE
     WHEN WE.receivetype_id IN (1, 2, 3)
     THEN CASE
      WHEN WE.status_tg > 3 AND WE.receipt_pos_marginrel_fg = 1
      THEN ROUND(CAST(WE.qty_total_rcv AS NUMERIC), 2) - CASE
        WHEN COALESCE(CAST(WE.customer_nr AS BIGNUMERIC), 0) = 0
        THEN 0
        ELSE ROUND(CAST(WE.qty_total_rcv AS NUMERIC), 2)
        END
      ELSE NULL
      END
     ELSE NULL
     END) AS we_menge,
   SUM(CASE
     WHEN WE.receipt_pos_marginrel_fg = 1
     THEN WE.val_buying_rcv
     ELSE NULL
     END) AS we_ek_wert
  FROM (SELECT A.client_id,
     A.src_wh_id AS wh_id,
     ITMP.item_sid_map AS item_id,
     A.dwh_cal_dt AS dat_formdate,
     A.receipt_type_id AS receivetype_id,
     A.status_tg,
     A.receipt_pos_margin_rel_fg AS receipt_pos_marginrel_fg,
     A.customer_nr,
     A.buying_val AS val_buying_rcv,
     A.receive_piece_qty AS qty_total_rcv
    FROM ldl_p_lew_bil_ac.v_mov_item_receive_wh_2 AS A
     INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid = ITMP.item_sid
    WHERE A.curr_cd_from = 'EUR'
     AND A.dwh_cal_dt BETWEEN DATE_ADD(CURRENT_DATE, INTERVAL - 2 YEAR) AND (CURRENT_DATE)
     AND (A.receipt_type_id IN (1, 2, 3) OR A.receipt_pos_margin_rel_fg = 1)) AS WE
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS TAG0 ON WE.dat_formdate = TAG0.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item_2 AS ART_INFO ON WE.client_id = ART_INFO.client_id AND WE.item_id =
     ART_INFO.item_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_2 AS UWG_INFO ON ART_INFO.subitemgroup_id = UWG_INFO.subitemgroup_id
    
  GROUP BY WE.client_id,
   WE.wh_id,
   WE.item_id,
   UWG_INFO.itemgroup_int_id,
   WE.dat_formdate,
   TAG0.cy_day_sequence,
   ART_INFO.orig_item_nr) AS WE ON WE.itemgroup_int_id IN (10, 20, 30, 32) AND WE.cy_day_sequence BETWEEN TAG.cy_day_sequence
       - 14 AND TAG.cy_day_sequence OR WE.itemgroup_int_id IN (40, 50, 60, 90) AND WE.cy_day_sequence BETWEEN TAG.cy_day_sequence
       - 164 AND TAG.cy_day_sequence OR WE.itemgroup_int_id IN (0, 70) AND WE.cy_day_sequence BETWEEN TAG.cy_day_sequence
      - 1000 AND TAG.cy_day_sequence
GROUP BY WE.client_id,
 dat_formdate,
 WE.wh_id,
 WE.item_id,
 WE.orig_item_nr;