/* Grundgesamtheit der zu berücksichtigenden Zeilen aus SFO-Aggregat und Umsätzen (EJR) für alle Länder und alle für FLOP10 relevanten Zeiträume
  Das Logikparadigma wurde aus dem WAWI-Paradigma abstrahiert und stimmt für alle WAWI-Länder mit der Altstreckeüberein
  - Tests hierzu vollumfänglich erfolgreich am 02.06.2018 durch Jens Thole
  Da die Daten aus dem BIL-Layer stammen, erfolgt hierbei auch die notwendige Korrektur in der Vergangenheit falsch zugeordneter
  ITEM_SIDs wegen des bekannten Fehlers des WAWI-Transportweges und dessen automatischer Anlage_2 von unbekannten Artikeln mit CS=-1.
  Es wird der Klammer-Artikel_2 der Keyintegration verwendet um somit immer den aktuellsten Stand evtl vorgenommener ITEM_SID-Korrekturen zu liefern

  Die View ist die unterste Basis zur Ziel-View v_mat_bo_base_flop10_2 und deren Materialisierung
  v_mat0_bo_base_flop10_2 ---> v_mat1_bo_base_flop10_2 ---> v_mat_bo_base_flop10_2 ---> t_bo_base_flop10_2

  2022-10-14   Michael Morris    INC4885339, User Story: 343128 - Added pcwo_reason_id 152 for force majeure.
  2025-03-24   Dominik Pfarr	 INC9229115: Adjust calculation of qty_disc_piece_weigth_sfo_asis to match with LEAD logic */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_bo_base_flop10_2 (client_id, loc_sid_store, item_sid, abstract_time_unit
, time_range_fg, curr_cd, val_rtl_rl_sfo, val_rtl_rl_net_sfo, val_rtl_net_sfo_mhd_break, val_rtl_net_sfo_other_stc_loss
, val_rtl_net_sfo_str_deliv_qlty, val_wrtoff_zero, val_wrtoff_zero_net, val_wrtoff_zero_net_mhd_break,
val_wrtoff_zero_net_other_stc_loss, val_wrtoff_zero_net_deliv_qlty, qty_total_sfo, qty_total_sfo_mhd_break,
qty_total_sfo_other_stc_loss, qty_total_sfo_str_deliv_qlty, `_val_discount_ejr`, `_val_discount_net_ejr`,
`_val_rtl_ejr_adj`, `_val_rtl_net_ejr_adj`, qty_disc_piece_weigth_ejr_asis, qty_disc_piece_weigth_sfo_asis) AS
-- in total store writeoffs
 -- writeoffs for mhd and break of stores
 -- in total ""other stock losses""

-- writeoffs for other stock losses of stores
 -- store delivery quality
 -- store delivery quality
 -- mhd
 -- break

-- in total store writeoffs
 -- writeoffs for mhd and break of stores
 -- force majeure
 -- Warenentnahme Filiale

-- Spenden Filiale
 -- in total ""other stock losses""
 -- writeoffs for other stock losses of stores

-- store delivery quality
 -- store delivery quality
 -- mhd
 -- break
 -- in total store writeoffs

-- writeoffs for mhd and break of stores
 -- force majeure
 -- Warenentnahme Filiale
 -- Spenden Filiale

-- in total ""other stock losses""
 -- writeoffs for other stock losses of stores
 -- store delivery quality

-- store delivery quality
 -- discount
 -- discount
 -- discount
 SELECT mT.client_id,
 mT.loc_sid_store,
 IMAPK.item_sid_map AS item_sid,
 mT.abstract_time_unit,
 mT.time_range_fg,
 mT.curr_cd,
 mT.val_rtl_rl_sfo,
 mT.val_rtl_rl_net_sfo,
 mT.val_rtl_net_sfo_mhd_break,
 mT.val_rtl_net_sfo_other_stc_loss,
 mT.val_rtl_net_sfo_str_deliv_qlty,
 mT.val_wrtoff_zero,
 mT.val_wrtoff_zero_net,
 mT.val_wrtoff_zero_net_mhd_break,
 mT.val_wrtoff_zero_net_other_stc_loss,
 mT.val_wrtoff_zero_net_deliv_qlty,
 mT.qty_total_sfo,
 mT.qty_total_sfo_mhd_break,
 mT.qty_total_sfo_other_stc_loss,
 mT.qty_total_sfo_str_deliv_qlty,
 mT.`_val_discount_ejr`,
 mT.`_val_discount_net_ejr`,
 mT.`_val_rtl_ejr_adj`,
 mT.`_val_rtl_net_ejr_adj`,
 mT.qty_disc_piece_weigth_ejr_asis,
 mT.qty_disc_piece_weigth_sfo_asis
FROM (SELECT A11.client_id,
    A11.loc_sid_store,
    A11.item_sid,
    a17.abstract_time_unit,
    a17.time_range_fg,
    A11.curr_cd,
    SUM(A11.sfo_total_rtl_rl_val_asis) AS val_rtl_rl_sfo,
    SUM(CAST(A11.sfo_total_rtl_rl_net_val_asis AS NUMERIC)) AS val_rtl_rl_net_sfo,
    SUM(CAST(CASE
       WHEN A11.pcwo_reason_id IN (1, 127, 134, 135 -- mhd
, 2, 128 -- break
)
       THEN A11.sfo_total_rtl_rl_net_val_asis
       ELSE 0
       END AS NUMERIC)) AS val_rtl_net_sfo_mhd_break,
    SUM(CAST(CASE
       WHEN A11.pcwo_reason_id IN (3, 136, 137, 152 -- force majeure
, 4, 101, 102, 110, 111, 129 -- Warenentnahme Filiale
, 7, 130, 131 -- Spenden Filiale
)
       THEN A11.sfo_total_rtl_rl_net_val_asis
       ELSE 0
       END AS NUMERIC)) AS val_rtl_net_sfo_other_stc_loss,
    SUM(CAST(CASE
       WHEN A11.pcwo_reason_id IN (8)
       THEN A11.sfo_total_rtl_rl_net_val_asis
       ELSE 0
       END AS NUMERIC)) AS val_rtl_net_sfo_str_deliv_qlty,
    SUM(A11.sfo_wrtoff_zero_rtl_rl_val_asis) AS val_wrtoff_zero,
    SUM(CAST(A11.sfo_wrtoff_zero_rtl_rl_net_val_asis AS NUMERIC)) AS val_wrtoff_zero_net,
    SUM(CAST(CASE
       WHEN A11.pcwo_reason_id IN (1, 127, 134, 135 -- mhd
, 2, 128 -- break
)
       THEN A11.sfo_wrtoff_zero_rtl_rl_net_val_asis
       ELSE 0
       END AS NUMERIC)) AS val_wrtoff_zero_net_mhd_break,
    SUM(CAST(CASE
       WHEN A11.pcwo_reason_id IN (3, 136, 137, 152 -- force majeure
, 4, 101, 102, 110, 111, 129 -- Warenentnahme Filiale
, 7, 130, 131 -- Spenden Filiale
)
       THEN A11.sfo_wrtoff_zero_rtl_rl_net_val_asis
       ELSE 0
       END AS NUMERIC)) AS val_wrtoff_zero_net_other_stc_loss,
    SUM(CAST(CASE
       WHEN A11.pcwo_reason_id IN (8)
       THEN A11.sfo_wrtoff_zero_rtl_rl_net_val_asis
       ELSE 0
       END AS NUMERIC)) AS val_wrtoff_zero_net_deliv_qlty,
    SUM(A11.sfo_total_qty_asis) AS qty_total_sfo,
    SUM(CASE
      WHEN A11.pcwo_reason_id IN (1, 127, 134, 135 -- mhd
, 2, 128 -- break
)
      THEN A11.sfo_total_qty_asis
      ELSE 0
      END) AS qty_total_sfo_mhd_break,
    SUM(CASE
      WHEN A11.pcwo_reason_id IN (3, 136, 137, 152 -- force majeure
, 4, 101, 102, 110, 111, 129
        -- Warenentnahme Filiale
, 7, 130, 131 -- Spenden Filiale
)
      THEN A11.sfo_total_qty_asis
      ELSE 0
      END) AS qty_total_sfo_other_stc_loss,
    SUM(CASE
      WHEN A11.pcwo_reason_id IN (8)
      THEN A11.sfo_total_qty_asis
      ELSE 0
      END) AS qty_total_sfo_str_deliv_qlty,
    SUM(CASE
      WHEN A11.pcwo_reason_id IN (5)
      THEN A11.sfo_total_rtl_rl_val_asis
      ELSE 0
      END) AS `_val_discount_ejr`,
    SUM(CASE
      WHEN A11.pcwo_reason_id IN (5)
      THEN A11.sfo_total_rtl_rl_net_val_asis
      ELSE 0
      END) AS `_val_discount_net_ejr`,
    CAST(NULL AS BIGNUMERIC) AS `_val_rtl_ejr_adj`,
    CAST(NULL AS BIGNUMERIC) AS `_val_rtl_net_ejr_adj`,
    CAST(NULL AS NUMERIC) AS qty_disc_piece_weigth_ejr_asis,
    SUM(CASE
      WHEN A11.sfotype_id IN (137, 147) AND A11.pcwo_reason_id IN (5)
      THEN A11.sfo_total_qty_asis
      ELSE 0
      END) AS qty_disc_piece_weigth_sfo_asis
   FROM ldl_p_lew_bil_ac.v_agg_store_day_item_sfo_asis_2 AS A11
    INNER JOIN ldl_p_lew_process_ac.v_bo_flop10_client_status_2 AS TODO ON A11.client_id = TODO.client_id
    INNER JOIN (SELECT *
     FROM (SELECT cal_dt,
         cal_dt_int AS abstract_time_unit,
         cy_week,
         cy_month,
         cy_week_seq,
         cy_month_seq,
         1 AS time_range_fg
        FROM ldl_p_lew_mart_msi.v_bo_flop10_cal_list_day_2
        WHERE day_range_fg = 1
        UNION ALL
        SELECT cal_dt,
         cy_week AS abstract_time_unit,
         cy_week,
         cy_month,
         cy_week_seq,
         cy_month_seq,
         2 AS time_range_fg
        FROM ldl_p_lew_mart_msi.v_bo_flop10_cal_list_day_2
        WHERE week_range_fg = 1
        UNION ALL
        SELECT cal_dt,
         cy_month AS abstract_time_unit,
         cy_week,
         cy_month,
         cy_week_seq,
         cy_month_seq,
         3 AS time_range_fg
        FROM ldl_p_lew_mart_msi.v_bo_flop10_cal_list_day_2
        WHERE month_range_fg = 1) AS t5) AS a17 ON A11.booking_dat = a17.cal_dt
   WHERE A11.sfotype_id IN (137, 147)
   GROUP BY A11.client_id,
    A11.loc_sid_store,
    A11.item_sid,
    a17.abstract_time_unit,
    a17.time_range_fg,
    A11.curr_cd
   UNION ALL
   SELECT mT.client_id,
    mT.st_loc_sid,
    mT.item_sid,
    mT.abstract_time_unit,
    mT.time_range_fg,
    C.curr_cd,
    CAST(NULL AS NUMERIC) AS val_rtl_rl_sfo,
    CAST(NULL AS NUMERIC) AS val_rtl_rl_net_sfo,
    CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_mhd_break,
    CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_other_stc_loss,
    CAST(NULL AS NUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
    CAST(NULL AS BIGNUMERIC) AS val_wrtoff_zero,
    CAST(NULL AS BIGNUMERIC) AS val_wrtoff_zero_net,
    CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_mhd_break,
    CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_other_stc_loss,
    CAST(NULL AS NUMERIC) AS val_wrtoff_zero_net_deliv_qlty,
    CAST(NULL AS NUMERIC) AS qty_total_sfo,
    CAST(NULL AS NUMERIC) AS qty_total_sfo_mhd_break,
    CAST(NULL AS NUMERIC) AS qty_total_sfo_other_stc_loss,
    CAST(NULL AS NUMERIC) AS qty_total_sfo_str_deliv_qlty,
    CAST(NULL AS BIGNUMERIC) AS `_val_discount_ejr`,
    CAST(NULL AS BIGNUMERIC) AS `_val_discount_net_ejr`,
    mT.`_val_rtl_ejr_adj`,
    mT.`_val_rtl_net_ejr_adj`,
    mT.qty_disc_piece_weigth_ejr_asis,
    CAST(NULL AS NUMERIC) AS qty_disc_piece_weigth_sfo_asis
   FROM (SELECT A11.client_id,
       A11.loc_sid_store AS st_loc_sid,
       A11.item_sid,
       A17.cal_dt_int AS abstract_time_unit,
       1 AS time_range_fg,
       SUM(IFNULL(A11.return_gross_val, 0) + IFNULL(A11.sales_gross_val, 0)) AS `_val_rtl_ejr_adj`,
       SUM(IFNULL(A11.return_net_val, 0) + IFNULL(A11.sales_net_val, 0)) AS `_val_rtl_net_ejr_adj`,
        - SUM(IFNULL(CASE
           WHEN A11.discount_sid > - 1 AND A11.discount_weight_qty <> 0
           THEN A11.sales_piece_qty
           ELSE 0
           END, 0)) - SUM(IFNULL(CASE
           WHEN A11.discount_sid > - 1 AND A11.discount_weight_qty <> 0
           THEN A11.sales_weight_qty
           ELSE 0
           END, 0)) AS qty_disc_piece_weigth_ejr_asis
      FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day_2 AS A11
       INNER JOIN ldl_p_lew_process_ac.v_bo_flop10_client_status_2 AS TODO ON A11.client_id = TODO.client_id
       INNER JOIN ldl_p_lew_mart_msi.v_bo_flop10_cal_list_day_2 AS A17 ON A11.dwh_cal_dt = A17.cal_dt AND A17.day_range_fg
          = 1
      GROUP BY A11.client_id,
       st_loc_sid,
       A11.item_sid,
       abstract_time_unit
      UNION ALL
      SELECT A11.client_id,
       A11.loc_sid_store AS st_loc_sid,
       A11.item_sid,
       A17.cy_week AS abstract_time_unit,
       2 AS time_range_fg,
       SUM(IFNULL(A11.return_gross_val, 0) + IFNULL(A11.sales_gross_val, 0)) AS `_val_rtl_ejr_adj`,
       SUM(IFNULL(A11.return_net_val, 0) + IFNULL(A11.sales_net_val, 0)) AS `_val_rtl_net_ejr_adj`,
        - SUM(IFNULL(CASE
           WHEN A11.discount_sid > - 1 AND A11.discount_weight_qty <> 0
           THEN A11.sales_piece_qty
           ELSE 0
           END, 0)) - SUM(IFNULL(CASE
           WHEN A11.discount_sid > - 1 AND A11.discount_weight_qty <> 0
           THEN A11.sales_weight_qty
           ELSE 0
           END, 0)) AS qty_disc_piece_weigth_ejr_asis
      FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day_2 AS A11
       INNER JOIN ldl_p_lew_process_ac.v_bo_flop10_client_status_2 AS TODO ON A11.client_id = TODO.client_id
       INNER JOIN ldl_p_lew_mart_msi.v_bo_flop10_cal_list_day_2 AS A17 ON A11.dwh_cal_dt = A17.cal_dt AND A17.week_range_fg
          = 1
      GROUP BY A11.client_id,
       st_loc_sid,
       A11.item_sid,
       abstract_time_unit
      UNION ALL
      SELECT A11.client_id,
       A11.loc_sid_store AS st_loc_sid,
       A11.item_sid,
       A17.cy_month AS abstract_time_unit,
       3 AS time_range_fg,
       SUM(IFNULL(A11.return_gross_val, 0) + IFNULL(A11.sales_gross_val, 0)) AS `_val_rtl_ejr_adj`,
       SUM(IFNULL(A11.return_net_val, 0) + IFNULL(A11.sales_net_val, 0)) AS `_val_rtl_net_ejr_adj`,
        - SUM(IFNULL(CASE
           WHEN A11.discount_sid > - 1 AND A11.discount_weight_qty <> 0
           THEN A11.sales_piece_qty
           ELSE 0
           END, 0)) - SUM(IFNULL(CASE
           WHEN A11.discount_sid > - 1 AND A11.discount_weight_qty <> 0
           THEN A11.sales_weight_qty
           ELSE 0
           END, 0)) AS qty_disc_piece_weigth_ejr_asis
      FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day_2 AS A11
       INNER JOIN ldl_p_lew_process_ac.v_bo_flop10_client_status_2 AS TODO ON A11.client_id = TODO.client_id
       INNER JOIN ldl_p_lew_mart_msi.v_bo_flop10_cal_list_day_2 AS A17 ON A11.dwh_cal_dt = A17.cal_dt AND A17.month_range_fg
          = 1
      GROUP BY A11.client_id,
       st_loc_sid,
       A11.item_sid,
       abstract_time_unit) AS mT
    INNER JOIN ldl_p_lew_core_ac.v_client_2 AS C ON mT.client_id = C.client_id) AS mT
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS IMAPK ON mT.client_id = IMAPK.client_id AND mT.item_sid = IMAPK.item_sid;