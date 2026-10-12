CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_egin_we_paletten_nach_anlieferbereich_2 (client_id
OPTIONS(description='Indicator of country_2'), wh_id OPTIONS(description='Warehouse number'), wh_staging_area_cd
OPTIONS(description='Warehouse area number'), wh_docking_gate_nr OPTIONS(description='Tor'), sup_sid
OPTIONS(description='Supplier_2 sid number'), spedition OPTIONS(description='Name of the carrier '), dat_entry_rcv
OPTIONS(description='task completed date and time'), euro_pal OPTIONS(description='Amount of Euro pallets'),
euro_pal_rejected OPTIONS(description='Amount of rejected euro pallets'), dd_pal
OPTIONS(description='Amount of Düsseldorf pallets'), dd_pal_rejected
OPTIONS(description='Amount of rejected Düsseldorf pallets'), euro_pal_aufgelaufen
OPTIONS(description='cumulative euro pallets'), dd_pal_aufgelaufen OPTIONS(description='cumulative Düsseldorf pallets'),
euro_pal_rejected_aufgelaufen OPTIONS(description='cumulative rejected euro pallets'), dd_pal_rejected_aufgelaufen
OPTIONS(description='cumulative rejected Düsseldorf pallets'), euro_pal_vj
OPTIONS(description='Amount of Euro pallets mapped to previous year'), euro_pal_rejected_vj
OPTIONS(description='Amount of rejected euro pallets mapped to previous year'), dd_pal_vj
OPTIONS(description='Amount of Düsseldorf pallets mapped to previous year'), dd_pal_rejected_vj
OPTIONS(description='Amount of rejected Düsseldorf mapped to previous year'), euro_pal_vj_aufgelaufen
OPTIONS(description='cumulative euro pallets previous year'), dd_pal_vj_aufgelaufen
OPTIONS(description='cumulative Düsseldorf pallets previous year'), euro_pal_rejected_vj_aufgelaufen
OPTIONS(description='cumulative rejected euro pallets previous year'), dd_pal_rejected_vj_aufgelaufen
OPTIONS(description='cumulative rejected Düsseldorf pallets previous year')) AS WITH BASE_WE_PALETTEN_DAY AS (SELECT DET
    .client_id,
    CAST(DET.wh_nr AS INTEGER) AS wh_id,
    WDG.wh_staging_area_cd,
    CAST(POS.wh_docking_gate_nr AS INTEGER) AS wh_docking_gate_nr,
    IFNULL(POS.departure_sup_sid, -1) AS sup_sid,
    DET.carrier_descr AS spedition,
    wk.dat_formdate AS dat_entry_rcv,
    SUM(CASE
      WHEN POS.pallet_type_cd IS NULL OR POS.pallet_type_cd = 'EP'
      THEN POS.pallet_cnt
      ELSE 0
      END) AS euro_pal,
    SUM(CASE
      WHEN (POS.pallet_type_cd IS NULL OR POS.pallet_type_cd = 'EP') AND POS.rejected_fg = 1
      THEN POS.pallet_cnt
      ELSE 0
      END) AS euro_pal_rejected,
    SUM(CASE
      WHEN POS.pallet_type_cd = 'DD'
      THEN POS.pallet_cnt
      ELSE 0
      END) AS dd_pal,
    SUM(CASE
      WHEN POS.pallet_type_cd = 'DD' AND POS.rejected_fg = 1
      THEN POS.pallet_cnt
      ELSE 0
      END) AS dd_pal_rejected
   FROM ldl_p_lew_core.t_warehouse_receiving_count_task_2 AS DET
    INNER JOIN ldl_p_lew_core.t_warehouse_receiving_count_task_pos_2 AS POS ON DET.client_id = POS.client_id AND DET.wh_loc_sid
         = POS.wh_loc_sid AND DET.wh_rcv_cnt_task_sid = POS.wh_rcv_cnt_task_sid AND POS.pos_status_id IN (99)
    INNER JOIN ldl_p_lew_core.t_ref_warehouse_docking_gate_2 AS WDG ON POS.client_id = WDG.client_id AND POS.wh_loc_sid =
       WDG.wh_loc_sid AND CAST(POS.wh_docking_gate_nr AS FLOAT64) = WDG.wh_docking_gate_nr
    INNER JOIN (SELECT DISTINCT client_id,
      wh_loc_sid,
      receipt_id_rcv,
      dat_formdate
     FROM ldl_p_lew_core.t_wawi_mov_item_wh_receiving_2
     WHERE receipttype_id = 1) AS wk ON POS.client_id = wk.client_id AND POS.wh_loc_sid = wk.wh_loc_sid AND POS.rcv_receipt_id
       = wk.receipt_id_rcv
    LEFT JOIN (SELECT client_id,
      sup_sid
     FROM ldl_p_lew_core.t_supplier_2
     WHERE sup_name LIKE '%Dummy_2%'
      OR sup_name LIKE '%dummy_2%') AS sup ON POS.client_id = sup.client_id AND POS.departure_sup_sid = sup.sup_sid
   WHERE DET.task_status_id = 99
    AND POS.case_per_pallet_cnt > 0
    AND DET.task_created_dt BETWEEN IF(DATE(CURRENT_DATETIME()) = LAST_DAY(DATE(CURRENT_DATETIME())), LAST_DAY(DATE_ADD(DATE(CURRENT_DATETIME()
         ), INTERVAL -24 MONTH)), DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL -24 MONTH)) AND (LAST_DAY(IF(DATE(CURRENT_DATETIME()
          ) = LAST_DAY(DATE(CURRENT_DATETIME())), LAST_DAY(DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL 0 MONTH)),
        DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL 0 MONTH)), MONTH))
    AND (POS.departure_sup_sid IS NULL OR sup.sup_sid IS NULL)
   GROUP BY DET.client_id,
    wh_id,
    WDG.wh_staging_area_cd,
    POS.wh_docking_gate_nr,
    sup_sid,
    spedition,
    dat_entry_rcv
   UNION ALL
   SELECT DET0.client_id,
    CAST(DET0.wh_nr AS INTEGER) AS wh_id,
    '-2' AS wh_staging_area_cd,
    -2 AS wh_docking_gate_nr,
    POS0.departure_sup_sid AS sup_sid,
    DET0.carrier_descr AS spedition,
    wk.dat_formdate AS dat_entry_rcv,
    SUM(CASE
      WHEN POS0.pallet_type_cd IS NULL OR POS0.pallet_type_cd = 'EP'
      THEN POS0.pallet_cnt
      ELSE 0
      END) AS euro_pal,
    SUM(CASE
      WHEN (POS0.pallet_type_cd IS NULL OR POS0.pallet_type_cd = 'EP') AND POS0.rejected_fg = 1
      THEN POS0.pallet_cnt
      ELSE 0
      END) AS euro_pal_rejected,
    SUM(CASE
      WHEN POS0.pallet_type_cd = 'DD'
      THEN POS0.pallet_cnt
      ELSE 0
      END) AS dd_pal,
    SUM(CASE
      WHEN POS0.pallet_type_cd = 'DD' AND POS0.rejected_fg = 1
      THEN POS0.pallet_cnt
      ELSE 0
      END) AS dd_pal_rejected
   FROM ldl_p_lew_core.t_warehouse_receiving_count_task_2 AS DET0
    INNER JOIN ldl_p_lew_core.t_warehouse_receiving_count_task_pos_2 AS POS0 ON DET0.client_id = POS0.client_id AND DET0.wh_loc_sid
         = POS0.wh_loc_sid AND DET0.wh_rcv_cnt_task_sid = POS0.wh_rcv_cnt_task_sid AND POS0.pos_status_id IN (99)
    INNER JOIN ldl_p_lew_core.t_ref_warehouse_docking_gate_2 AS WDG0 ON POS0.client_id = WDG0.client_id AND POS0.wh_loc_sid
        = WDG0.wh_loc_sid AND CAST(POS0.wh_docking_gate_nr AS FLOAT64) = WDG0.wh_docking_gate_nr
    INNER JOIN (SELECT DISTINCT client_id,
      wh_loc_sid,
      receipt_id_rcv,
      dat_formdate
     FROM ldl_p_lew_core.t_wawi_mov_item_wh_receiving_2
     WHERE receipttype_id = 1) AS wk ON POS0.client_id = wk.client_id AND POS0.wh_loc_sid = wk.wh_loc_sid AND POS0.rcv_receipt_id
       = wk.receipt_id_rcv
    INNER JOIN (SELECT client_id,
      sup_sid
     FROM ldl_p_lew_core.t_supplier_2
     WHERE sup_name LIKE '%Dummy_2%'
      OR sup_name LIKE '%dummy_2%') AS sup ON POS0.client_id = sup.client_id AND POS0.departure_sup_sid = sup.sup_sid
   WHERE DET0.task_status_id = 99
    AND POS0.case_per_pallet_cnt > 0
    AND DET0.task_created_dt BETWEEN IF(DATE(CURRENT_DATETIME()) = LAST_DAY(DATE(CURRENT_DATETIME())), LAST_DAY(DATE_ADD(DATE(CURRENT_DATETIME()
         ), INTERVAL -24 MONTH)), DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL -24 MONTH)) AND (LAST_DAY(IF(DATE(CURRENT_DATETIME()
          ) = LAST_DAY(DATE(CURRENT_DATETIME())), LAST_DAY(DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL 0 MONTH)),
        DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL 0 MONTH)), MONTH))
   GROUP BY DET0.client_id,
    wh_id,
    wh_staging_area_cd,
    wh_docking_gate_nr,
    sup_sid,
    spedition,
    dat_entry_rcv
   UNION ALL
   SELECT wr.client_id,
    WH.src_wh_id AS wh_id,
    '-1' AS wh_staging_area_cd,
    -1 AS wh_docking_gate_nr,
    IFNULL(wr.sup_sid, -1) AS sup_sid,
    '-1' AS spedition,
    wr.dat_formdate AS dat_entry_rcv,
    SUM(CASE
      WHEN IFNULL(wr.package_qty, 3) = 3
      THEN wr.qty_total_rcv / IFNULL(wr.case_size_dec, ROUND(SAFE_CAST(SUBSTR(SUBSTR(CAST(wr.item_sid AS STRING), 1, 10
             ), -4) AS BIGNUMERIC), 0)) / IFNULL(wr.pallet_factor_rcv, CASE
         WHEN IFNULL(wr.package_qty, 3) = 1
         THEN CAST(IFNULL(wr.stock_location_nr, 1) AS BIGNUMERIC)
         WHEN IFNULL(wr.package_qty, 3) = 2
         THEN IFNULL(ITM.case_factor_dd, ITM.case_factor_euro / 2)
         WHEN IFNULL(wr.package_qty, 3) = 3
         THEN CAST(ITM.case_factor_euro AS BIGNUMERIC)
         ELSE 1
         END)
      ELSE 0
      END) AS euro_pal,
    0 AS euro_pal_rejected,
    SUM(CASE
      WHEN IFNULL(wr.package_qty, 3) = 2
      THEN wr.qty_total_rcv / IFNULL(wr.case_size_dec, ROUND(SAFE_CAST(SUBSTR(SUBSTR(CAST(wr.item_sid AS STRING), 1, 10
             ), -4) AS BIGNUMERIC), 0)) / IFNULL(wr.pallet_factor_rcv, CASE
         WHEN IFNULL(wr.package_qty, 3) = 1
         THEN CAST(IFNULL(wr.stock_location_nr, 1) AS BIGNUMERIC)
         WHEN IFNULL(wr.package_qty, 3) = 2
         THEN IFNULL(ITM.case_factor_dd, ITM.case_factor_euro / 2)
         WHEN IFNULL(wr.package_qty, 3) = 3
         THEN CAST(ITM.case_factor_euro AS BIGNUMERIC)
         ELSE 1
         END)
      ELSE 0
      END) AS dd_pal,
    0 AS dd_pal_rejected
   FROM (SELECT *
     FROM ldl_p_lew_core.t_wawi_mov_item_wh_receiving_2
     WHERE dat_formdate BETWEEN IF(DATE(CURRENT_DATETIME()) = LAST_DAY(DATE(CURRENT_DATETIME())), LAST_DAY(DATE_ADD(DATE(CURRENT_DATETIME()
           ), INTERVAL -24 MONTH)), DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL -24 MONTH)) AND (LAST_DAY(IF(DATE(CURRENT_DATETIME()
            ) = LAST_DAY(DATE(CURRENT_DATETIME())), LAST_DAY(DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL 0 MONTH)),
          DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL 0 MONTH)), MONTH))
      AND IFNULL(case_size_dec, ROUND(SAFE_CAST(SUBSTR(SUBSTR(CAST(item_sid AS STRING), 1, 10), -4) AS BIGNUMERIC), 0))
       > 0
      AND receipttype_id = 1
      AND receipt_id_rcv < 5000000) AS wr
    INNER JOIN ldl_p_lew_bil.t_warehouse_2 AS WH ON wr.client_id = WH.client_id AND wr.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
       = 1
    INNER JOIN ldl_p_lew_core.t_wawi_itm_item_wh_2 AS ITM ON wr.client_id = ITM.client_id AND wr.wh_loc_sid = ITM.wh_loc_sid
         AND wr.item_sid = ITM.item_sid AND ITM.dat_rec_end = DATE '9999-12-31'
   WHERE IFNULL(wr.pallet_factor_rcv, CASE
       WHEN IFNULL(wr.package_qty, 3) = 1
       THEN CAST(IFNULL(wr.stock_location_nr, 1) AS BIGNUMERIC)
       WHEN IFNULL(wr.package_qty, 3) = 2
       THEN IFNULL(ITM.case_factor_dd, ITM.case_factor_euro / 2)
       WHEN IFNULL(wr.package_qty, 3) = 3
       THEN CAST(ITM.case_factor_euro AS BIGNUMERIC)
       ELSE 1
       END) > 0
    AND NOT EXISTS (SELECT 1
     FROM ldl_p_lew_core.t_warehouse_receiving_count_task_pos_2
     WHERE CONCAT(client_id, wh_loc_sid, rcv_receipt_id) = CONCAT(wr.client_id, wr.wh_loc_sid, wr.receipt_id_rcv)
      AND wh_docking_gate_nr IS NOT NULL)
   GROUP BY wr.client_id,
    wh_id,
    wr.sup_sid,
    dat_entry_rcv,
    wr.receipt_id_rcv), FACT_WE_PALETTEN_DAY_PREVIOUS_YEAR AS (SELECT a.client_id,
   a.wh_id,
   a.wh_staging_area_cd,
   a.wh_docking_gate_nr,
   a.sup_sid,
   a.spedition,
   B.cal_dt AS dat_entry_rcv,
   B.busyear,
   SUM(a.euro_pal) AS we_paletten_ep_vj,
   SUM(SUM(a.euro_pal)) OVER (PARTITION BY a.client_id, a.wh_id, B.busyear ORDER BY B.cal_dt NULLS LAST, a.wh_staging_area_cd
      NULLS LAST, a.wh_docking_gate_nr NULLS LAST, a.sup_sid NULLS LAST, a.spedition NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_ep_vj_aufgelaufen,
   SUM(a.dd_pal) AS we_paletten_dd_vj,
   SUM(SUM(a.dd_pal)) OVER (PARTITION BY a.client_id, a.wh_id, B.busyear ORDER BY B.cal_dt NULLS LAST, a.wh_staging_area_cd
      NULLS LAST, a.wh_docking_gate_nr NULLS LAST, a.sup_sid NULLS LAST, a.spedition NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_dd_vj_aufgelaufen,
   SUM(a.euro_pal_rejected) AS we_paletten_rejected_ep_vj,
   SUM(SUM(a.euro_pal_rejected)) OVER (PARTITION BY a.client_id, a.wh_id, B.busyear ORDER BY B.cal_dt NULLS LAST, a.wh_staging_area_cd
      NULLS LAST, a.wh_docking_gate_nr NULLS LAST, a.sup_sid NULLS LAST, a.spedition NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_rejected_ep_vj_aufgelaufen,
   SUM(a.dd_pal_rejected) AS we_paletten_rejected_dd_vj,
   SUM(SUM(a.dd_pal_rejected)) OVER (PARTITION BY a.client_id, a.wh_id, B.busyear ORDER BY B.cal_dt NULLS LAST, a.wh_staging_area_cd
      NULLS LAST, a.wh_docking_gate_nr NULLS LAST, a.sup_sid NULLS LAST, a.spedition NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_rejected_dd_vj_aufgelaufen
  FROM BASE_WE_PALETTEN_DAY AS a
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS B ON a.dat_entry_rcv = B.cal_dt_prev_1y
  GROUP BY a.client_id,
   a.wh_id,
   a.wh_staging_area_cd,
   a.wh_docking_gate_nr,
   a.sup_sid,
   a.spedition,
   dat_entry_rcv,
   B.busyear), FACT_WE_PALETTEN_DAY_CURRENT_YEAR AS (SELECT a.client_id,
   a.wh_id,
   a.wh_staging_area_cd,
   a.wh_docking_gate_nr,
   a.sup_sid,
   a.spedition,
   B0.cal_dt AS dat_entry_rcv,
   B0.busyear,
   SUM(a.euro_pal) AS we_paletten_ep,
   SUM(SUM(a.euro_pal)) OVER (PARTITION BY a.client_id, a.wh_id, B0.busyear ORDER BY B0.cal_dt NULLS LAST, a.wh_staging_area_cd
      NULLS LAST, a.wh_docking_gate_nr NULLS LAST, a.sup_sid NULLS LAST, a.spedition NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_ep_aufgelaufen,
   SUM(a.dd_pal) AS we_paletten_dd,
   SUM(SUM(a.dd_pal)) OVER (PARTITION BY a.client_id, a.wh_id, B0.busyear ORDER BY B0.cal_dt NULLS LAST, a.wh_staging_area_cd
      NULLS LAST, a.wh_docking_gate_nr NULLS LAST, a.sup_sid NULLS LAST, a.spedition NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_dd_aufgelaufen,
   SUM(a.euro_pal_rejected) AS we_paletten_rejected_ep,
   SUM(SUM(a.euro_pal_rejected)) OVER (PARTITION BY a.client_id, a.wh_id, B0.busyear ORDER BY B0.cal_dt NULLS LAST, a.wh_staging_area_cd
      NULLS LAST, a.wh_docking_gate_nr NULLS LAST, a.sup_sid NULLS LAST, a.spedition NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_rejected_ep_aufgelaufen,
   SUM(a.dd_pal_rejected) AS we_paletten_rejected_dd,
   SUM(SUM(a.dd_pal_rejected)) OVER (PARTITION BY a.client_id, a.wh_id, B0.busyear ORDER BY B0.cal_dt NULLS LAST, a.wh_staging_area_cd
      NULLS LAST, a.wh_docking_gate_nr NULLS LAST, a.sup_sid NULLS LAST, a.spedition NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_rejected_dd_aufgelaufen
  FROM BASE_WE_PALETTEN_DAY AS a
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS B0 ON a.dat_entry_rcv = B0.cal_dt
  GROUP BY a.client_id,
   a.wh_id,
   a.wh_staging_area_cd,
   a.wh_docking_gate_nr,
   a.sup_sid,
   a.spedition,
   dat_entry_rcv,
   B0.busyear) (SELECT IFNULL(a.client_id, b.client_id) AS client_id,
   IFNULL(a.wh_id, b.wh_id) AS wh_id,
   IFNULL(IFNULL(a.wh_staging_area_cd, b.wh_staging_area_cd), '-1') AS wh_staging_area_cd,
   IFNULL(IFNULL(a.wh_docking_gate_nr, b.wh_docking_gate_nr), -1) AS wh_docking_gate_nr,
   IFNULL(a.sup_sid, b.sup_sid) AS sup_sid,
   IFNULL(a.spedition, b.spedition) AS spedition,
   IFNULL(a.dat_entry_rcv, b.dat_entry_rcv) AS dat_entry_rcv,
   MAX(b.we_paletten_ep) AS euro_pal,
   MAX(b.we_paletten_rejected_ep) AS euro_pal_rejected,
   MAX(b.we_paletten_dd) AS dd_pal,
   MAX(b.we_paletten_rejected_dd) AS dd_pal_rejected,
   MAX(b.we_paletten_ep_aufgelaufen) AS euro_pal_aufgelaufen,
   MAX(b.we_paletten_dd_aufgelaufen) AS dd_pal_aufgelaufen,
   MAX(b.we_paletten_rejected_ep_aufgelaufen) AS euro_pal_rejected_aufgelaufen,
   MAX(b.we_paletten_rejected_dd_aufgelaufen) AS dd_pal_rejected_aufgelaufen,
   MAX(a.we_paletten_ep_vj) AS euro_pal_vj,
   MAX(a.we_paletten_rejected_ep_vj) AS euro_pal_rejected_vj,
   MAX(a.we_paletten_dd_vj) AS dd_pal_vj,
   MAX(a.we_paletten_rejected_dd_vj) AS dd_pal_rejected_vj,
   MAX(a.we_paletten_ep_vj_aufgelaufen) AS euro_pal_vj_aufgelaufen,
   MAX(a.we_paletten_dd_vj_aufgelaufen) AS dd_pal_vj_aufgelaufen,
   MAX(a.we_paletten_rejected_ep_vj_aufgelaufen) AS euro_pal_rejected_vj_aufgelaufen,
   MAX(a.we_paletten_rejected_dd_vj_aufgelaufen) AS dd_pal_rejected_vj_aufgelaufen
  FROM FACT_WE_PALETTEN_DAY_PREVIOUS_YEAR AS a
   FULL JOIN FACT_WE_PALETTEN_DAY_CURRENT_YEAR AS b ON a.client_id = b.client_id AND a.wh_id = b.wh_id AND a.wh_staging_area_cd
          = b.wh_staging_area_cd AND a.wh_docking_gate_nr = b.wh_docking_gate_nr AND a.sup_sid = b.sup_sid AND a.spedition
       = b.spedition AND a.dat_entry_rcv = b.dat_entry_rcv
  GROUP BY client_id,
   wh_id,
   wh_staging_area_cd,
   wh_docking_gate_nr,
   sup_sid,
   spedition,
   dat_entry_rcv);