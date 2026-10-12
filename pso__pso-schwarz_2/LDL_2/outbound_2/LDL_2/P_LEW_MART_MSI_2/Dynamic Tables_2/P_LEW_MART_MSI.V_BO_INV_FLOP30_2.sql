CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_inv_flop30_2 (client_id, country_desc, country_id, country_iso_cd, store_id
, orig_store_nr, store_desc, city, wh_id, wh_desc, sales_manager_id, sales_manager_name, account_manager_id,
account_manager_name, inv_id, cy_month, busyear, dat_valid_from, dat_valid_until, itm_consgrp_id, cons_orig_item_nr,
cons_dat_valid_from_item, itm_consgrp_desc, cons_item_desc, currency_iso_cd, val_rtl_ejr_adj, val_rtl_net_ejr_adj,
diff_inv_stc_calc_val, diff_inv_stc_calc_val_net, diff_inv_stc_calc_cnt, prev_diff_inv_stc_calc_val,
prev_diff_inv_stc_calc_val_net, prev_diff_inv_stc_calc_cnt, inv_diff_to_val_rtl_pct, inv_diff_to_val_rtl_net_pct,
rnk_inv_flop_item) AS SELECT act.client_id,
 RCD.country_desc,
 RCD.country_id,
 RCT.country_iso_cd,
 act.store_id,
 OSA.src_orig_store_nr AS orig_store_nr,
 COALESCE(OSA.loc_name, OSA.loc_name2) AS store_desc,
 OSC.city,
 act.wh_id,
 COALESCE(OWH.loc_name, OWH.loc_name2) AS wh_desc,
 act.sales_manager_id,
 act.sales_manager_name,
 act.account_manager_id,
 act.account_manager_name,
 act.inv_id,
 act.cy_month,
 act.busyear,
 act.dat_valid_from,
 act.dat_valid_until,
 act.itm_consgrp_id,
 act.cons_orig_item_nr,
 act.cons_dat_valid_from_item,
 act.itm_consgrp_desc,
 act.cons_item_desc,
 act.currency_iso_cd,
 act.val_rtl_ejr_adj,
 act.val_rtl_net_ejr_adj,
 act.diff_inv_stc_calc_val,
 act.diff_inv_stc_calc_val_net,
 act.diff_inv_stc_calc_cnt,
 act.prev_diff_inv_stc_calc_val,
 act.prev_diff_inv_stc_calc_val_net,
 act.prev_diff_inv_stc_calc_cnt,
 ROUND(CAST(COALESCE(act.diff_inv_stc_calc_val / CASE
       WHEN act.val_rtl_ejr_adj = 0
       THEN NULL
       ELSE act.val_rtl_ejr_adj
       END, 0) * 100 AS NUMERIC), 4) AS inv_diff_to_val_rtl_pct,
 ROUND(CAST(COALESCE(act.diff_inv_stc_calc_val_net / CASE
       WHEN act.val_rtl_net_ejr_adj = 0
       THEN NULL
       ELSE act.val_rtl_net_ejr_adj
       END, 0) * 100 AS NUMERIC), 4) AS inv_diff_to_val_rtl_net_pct,
  CASE
  WHEN ABS(act.diff_inv_stc_calc_val) IS NULL OR ABS(act.diff_inv_stc_calc_val) = 0
  THEN -1
  ELSE CAST(ROW_NUMBER() OVER (PARTITION BY act.client_id, act.store_id, act.inv_id, act.cy_month, act.dat_valid_from, act.dat_valid_until ORDER BY ABS(act.diff_inv_stc_calc_val) NULLS LAST, ABS(act.prev_diff_inv_stc_calc_cnt) NULLS LAST, act.itm_consgrp_id NULLS LAST, act.cons_orig_item_nr
      NULLS LAST, act.cons_dat_valid_from_item NULLS LAST) AS INTEGER)
  END AS rnk_inv_flop_item
FROM (SELECT t26.client_id,
   t26.store_id,
   COALESCE(t26.sales_manager_id, -100) AS sales_manager_id,
   COALESCE(t26.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
   COALESCE(t26.account_manager_id, -1) AS account_manager_id,
   COALESCE(t26.account_manager_name, 'Vertriebsleiter') AS account_manager_name,
   t26.loc_sid_wh,
   t26.wh_id,
   t26.inv_id,
   t26.cy_month,
   t26.busyear,
   t26.dat_valid_from,
   t26.dat_valid_until,
   t26.itm_consgrp_id,
   t26.cons_orig_item_nr,
   t26.cons_dat_valid_from_item,
   t26.itm_consgrp_desc,
   t26.cons_item_desc,
   t26.currency_iso_cd,
   t26.val_rtl_ejr_adj,
   t26.val_rtl_net_ejr_adj,
   t26.diff_inv_stc_calc_val,
   t26.diff_inv_stc_calc_val_net,
   t26.diff_inv_stc_calc_cnt,
   t26.prev_diff_inv_stc_calc_val,
   t26.prev_diff_inv_stc_calc_val_net,
   t26.prev_diff_inv_stc_calc_cnt
  FROM (SELECT a.client_id,
     a.store_id,
     MGR_INFOS.sales_manager_id,
     MGR_INFOS.sales_manager_name,
     MGR_INFOS.account_manager_id,
     MGR_INFOS.account_manager_name,
     OSS.loc_sid_wh,
     OSS.src_wh_id AS wh_id,
     a.inv_id,
     a.cy_month,
     a.busyear,
     a.dat_valid_from,
     a.dat_valid_until,
     cons.itm_consgrp_id,
     cons.cons_orig_item_nr,
     cons.cons_dat_valid_from_item,
     cons.itm_consgrp_desc,
      CASE
      WHEN cons.itm_consgrp_id = -1
      THEN cons.item_descr
      ELSE NULL
      END AS cons_item_desc,
     CRY.curr_cd AS currency_iso_cd,
     SUM(a.n_val_rtl_ejr_adj) AS val_rtl_ejr_adj,
     SUM(a.n_val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj,
     SUM(a.n_diff_inv_stc_calc_val) AS diff_inv_stc_calc_val,
     SUM(a.n_diff_inv_stc_calc_val_net) AS diff_inv_stc_calc_val_net,
     SUM(a.n_diff_inv_stc_calc_cnt) AS diff_inv_stc_calc_cnt,
     SUM(a.p_diff_inv_stc_calc_val) AS prev_diff_inv_stc_calc_val,
     SUM(a.p_diff_inv_stc_calc_val_net) AS prev_diff_inv_stc_calc_val_net,
     SUM(a.p_diff_inv_stc_calc_cnt) AS prev_diff_inv_stc_calc_cnt
    FROM (SELECT A2.client_id,
        A2.st_loc_sid AS store_id,
        A2.inv_id,
        A2.cy_month,
        A2.dat_valid_from,
        A2.dat_valid_until,
        A2.item_sid AS item_id,
        A2.dat_formdate,
        BSY.busyear,
         SUM(A2.val_rtl_ejr) + SUM(A2.val_return_ejr) AS n_val_rtl_ejr_adj,
         SUM(A2.val_rtl_net_ejr) + SUM(A2.val_return_net_ejr) AS n_val_rtl_net_ejr_adj,
        SUM(A2.diff_inv_stc_calc_val) AS n_diff_inv_stc_calc_val,
        SUM(A2.diff_inv_stc_calc_net_val) AS n_diff_inv_stc_calc_val_net,
        SUM(A2.diff_inv_stc_calc_cnt) AS n_diff_inv_stc_calc_cnt,
        CAST(NULL AS NUMERIC) AS p_diff_inv_stc_calc_val,
        CAST(NULL AS NUMERIC) AS p_diff_inv_stc_calc_val_net,
        CAST(NULL AS NUMERIC) AS p_diff_inv_stc_calc_cnt
       FROM ldl_p_lew_bil_ac.v_agg_store_item_inv_all_wawi_2 AS A2
        INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS BSY ON A2.dat_valid_until = BSY.cal_dt AND A2.cy_month = BSY.cy_month
          
       WHERE BSY.busyear_seq IN (0, -1)
       GROUP BY A2.client_id,
        store_id,
        A2.inv_id,
        A2.cy_month,
        A2.dat_valid_from,
        A2.dat_valid_until,
        item_id,
        A2.dat_formdate,
        BSY.busyear
       HAVING n_diff_inv_stc_calc_val <> 0
       UNION ALL
       SELECT d.client_id,
        d.store_id,
        d.inv_id,
        ROUND(CAST(FORMAT_DATE('%Y%m', d.dat_valid_until) AS BIGNUMERIC), 0) AS cy_month,
        d.dat_valid_from,
        d.dat_valid_until,
        A2.item_sid AS item_id,
        d.dat_formdate,
        BSY.busyear,
        CAST(NULL AS NUMERIC),
        CAST(NULL AS NUMERIC),
        CAST(NULL AS NUMERIC),
        CAST(NULL AS NUMERIC),
        CAST(NULL AS NUMERIC),
        SUM(A2.diff_inv_stc_calc_val) AS p_diff_inv_stc_calc_val,
        SUM(A2.diff_inv_stc_calc_net_val) AS p_diff_inv_stc_calc_val_net,
        SUM(A2.diff_inv_stc_calc_cnt) AS p_diff_inv_stc_calc_cnt
       FROM (SELECT client_id,
          st_loc_sid AS store_id,
          inv_id,
          dat_formdate,
          dat_valid_from,
          dat_valid_until,
          MIN(inv_id) OVER (PARTITION BY client_id, st_loc_sid ORDER BY dat_valid_from NULLS LAST, dat_valid_until
             NULLS LAST, inv_id NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS prev_inv_id,
          MIN(dat_formdate) OVER (PARTITION BY client_id, st_loc_sid ORDER BY dat_valid_from NULLS LAST, dat_valid_until
             NULLS LAST, inv_id NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS prev_dat_formdate,
          MIN(dat_valid_from) OVER (PARTITION BY client_id, st_loc_sid ORDER BY dat_valid_from NULLS LAST,
             dat_valid_until NULLS LAST, inv_id NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS
          prev_dat_valid_from,
          MIN(dat_valid_until) OVER (PARTITION BY client_id, st_loc_sid ORDER BY dat_valid_from NULLS LAST,
             dat_valid_until NULLS LAST, inv_id NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS
          prev_dat_valid_until
         FROM ldl_p_lew_core_ac.v_wawi_inv_store_2 AS I
         WHERE inv_fg = 71) AS d
        INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS BSY ON d.dat_valid_until = BSY.cal_dt
        INNER JOIN ldl_p_lew_bil_ac.v_agg_store_item_inv_all_wawi_2 AS A2 ON d.client_id = A2.client_id AND d.store_id =
              A2.st_loc_sid AND d.prev_inv_id = A2.inv_id AND d.prev_dat_formdate = A2.dat_formdate AND d.prev_dat_valid_from
            = A2.dat_valid_from AND d.prev_dat_valid_until = A2.dat_valid_until
       WHERE BSY.busyear_seq IN (0, -1)
       GROUP BY d.client_id,
        d.store_id,
        d.inv_id,
        d.dat_valid_from,
        d.dat_valid_until,
        item_id,
        d.dat_formdate,
        BSY.busyear) AS a
     INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS OSS ON a.client_id = OSS.client_id AND a.store_id =
       OSS.loc_sid_store
     INNER JOIN (SELECT i.client_id,
       i.wh_id,
       i.item_id,
       i.itm_consgrp_id,
       i.cons_item_id,
        CASE
        WHEN i.itm_consgrp_id = -1
        THEN a.orig_item_nr
        ELSE -1
        END AS cons_orig_item_nr,
        CASE
        WHEN i.itm_consgrp_id = -1
        THEN a.dat_valid_from
        ELSE DATE '1900-01-01'
        END AS cons_dat_valid_from_item,
        CASE
        WHEN i.itm_consgrp_id = -1
        THEN 0
        ELSE 1
        END AS cons_fg,
       CGP.itm_consgrp_desc,
       a.item_descr
      FROM (SELECT i1.client_id,
          i1.wh_id,
          i1.item_id,
          C1.itm_consgrp_id,
          -1 AS cons_item_id
         FROM (SELECT B.client_id,
            F.loc_sid_wh AS wh_id,
            B.item_sid AS item_id,
            B.dwh_valid_from AS dat_rec_start,
            B.dwh_valid_to AS dat_rec_end
           FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_2 AS B
            INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS F ON B.client_id = F.client_id AND B.loc_sid = F.loc_sid_wh AND F
                  .dwh_actual_fg = 1 AND F.deleted_fg = 0 AND F.bges_active_fg = 1 AND B.deleted_fg = 0 AND CURRENT_DATE
              BETWEEN B.dwh_valid_from AND B.dwh_valid_to) AS i1
          INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_2 AS C1 ON i1.client_id = C1.client_id AND i1.item_id
              = C1.item_sid AND i1.wh_id = C1.wh_loc_sid
         WHERE CURRENT_DATE BETWEEN C1.dat_rec_start AND C1.dat_rec_end
          AND CURRENT_DATE BETWEEN i1.dat_rec_start AND i1.dat_rec_end
         UNION ALL
         SELECT client_id,
          wh_id,
          item_id,
          -1 AS itm_consgrp_id,
          item_id AS cons_item_id
         FROM (SELECT B.client_id,
            F.loc_sid_wh AS wh_id,
            B.item_sid AS item_id,
            B.dwh_valid_from AS dat_rec_start,
            B.dwh_valid_to AS dat_rec_end
           FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_2 AS B
            INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS F ON B.client_id = F.client_id AND B.loc_sid = F.loc_sid_wh AND F
                  .dwh_actual_fg = 1 AND F.deleted_fg = 0 AND F.bges_active_fg = 1 AND B.deleted_fg = 0 AND CURRENT_DATE
              BETWEEN B.dwh_valid_from AND B.dwh_valid_to) AS i2
         WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
          AND NOT EXISTS (SELECT 1
           FROM ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_2 AS C2
           WHERE i2.client_id = client_id
            AND i2.item_id = item_sid
            AND i2.wh_id = wh_loc_sid
            AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end)) AS i
       INNER JOIN (SELECT I0.client_id,
         I0.item_sid,
         I0.item_sid_config,
         DESCR.item_descr,
         I0.src_matnr,
         I0.src_dat_valid_from AS dat_valid_from,
         SAFE_CAST(ROUND(CAST(COALESCE(I0.src_orig_item_nr, I0.config_item_cd, I0.src_matnr) AS FLOAT64)) AS INTEGER) AS
         orig_item_nr,
         COALESCE(I0.src_dat_valid_from, MAX(I0.src_dat_valid_from) OVER (PARTITION BY I0.client_id, COALESCE(I0.item_sid_config
              , I0.item_sid) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), MAX(I0.src_dat_valid_from) OVER
           (PARTITION BY I0.client_id, I0.src_orig_item_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
         AS max_dat_valid_from,
         ITMFGH.sub_item_grp_sid
        FROM ldl_p_lew_core_ac.v_item_2 AS I0
         INNER JOIN ldl_p_lew_core_ac.v_country_2 AS C ON I0.client_id = C.country_sid
         INNER JOIN ldl_p_lew_core_ac.v_item_descr_2 AS DESCR ON I0.client_id = DESCR.client_id AND I0.item_sid = DESCR.item_sid
             AND C.lang_sid = DESCR.lang_sid
         INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS IH ON I0.client_id = IH.client_id AND I0.item_sid = IH.item_sid AND
           CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
         INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_2 AS ITMFGH ON IH.client_id = ITMFGH.client_id AND IH.item_fam_grp_sid
             = ITMFGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN ITMFGH.dwh_valid_from AND ITMFGH.dwh_valid_to) AS a ON i
         .client_id = a.client_id AND i.item_id = a.item_sid
       LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_consolidationgroup_2 AS CGP ON i.client_id = CGP.client_id AND i.wh_id = CGP
           .wh_loc_sid AND i.itm_consgrp_id = CGP.itm_consgrp_id AND CURRENT_DATE BETWEEN CGP.dat_rec_start AND CGP.dat_rec_end
         ) AS cons ON a.client_id = cons.client_id AND OSS.loc_sid_wh = cons.wh_id AND a.item_id = cons.item_id
     INNER JOIN (SELECT I1.client_id,
       I1.item_sid,
       I1.item_sid_config,
       DESCR0.item_descr,
       I1.src_matnr,
       SAFE_CAST(ROUND(CAST(COALESCE(I1.src_orig_item_nr, I1.config_item_cd, I1.src_matnr) AS FLOAT64)) AS INTEGER) AS
       orig_item_nr,
       COALESCE(I1.src_dat_valid_from, MAX(I1.src_dat_valid_from) OVER (PARTITION BY I1.client_id, COALESCE(I1.item_sid_config
            , I1.item_sid) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), MAX(I1.src_dat_valid_from) OVER (PARTITION BY
           I1.client_id, I1.src_orig_item_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS
       max_dat_valid_from,
       ITMFGH0.sub_item_grp_sid,
       SIG.src_subitemgrp_cd,
       SIG.sub_item_grp_name,
       SIG.item_grp_int_sid
      FROM ldl_p_lew_core_ac.v_item_2 AS I1
       INNER JOIN ldl_p_lew_core_ac.v_country_2 AS C0 ON I1.client_id = C0.country_sid
       INNER JOIN ldl_p_lew_core_ac.v_item_descr_2 AS DESCR0 ON I1.client_id = DESCR0.client_id AND I1.item_sid = DESCR0.item_sid
           AND C0.lang_sid = DESCR0.lang_sid
       INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS IH0 ON I1.client_id = IH0.client_id AND I1.item_sid = IH0.item_sid
        AND CURRENT_DATE BETWEEN IH0.dwh_valid_from AND IH0.dwh_valid_to
       INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_2 AS ITMFGH0 ON IH0.client_id = ITMFGH0.client_id AND IH0.item_fam_grp_sid
           = ITMFGH0.item_fam_grp_sid AND CURRENT_DATE BETWEEN ITMFGH0.dwh_valid_from AND ITMFGH0.dwh_valid_to
       INNER JOIN ldl_p_lew_bil_ac.v_subitemgroup_2 AS SIG ON I1.client_id = SIG.client_id AND ITMFGH0.sub_item_grp_sid =
         SIG.sub_item_grp_sid) AS iia ON a.client_id = iia.client_id AND a.item_id = iia.item_sid
     LEFT JOIN ldl_p_lew_bil_ac.v_location_organization_2 AS MGR_INFOS ON OSS.client_id = MGR_INFOS.client_id AND OSS.loc_sid_wh
         = MGR_INFOS.loc_sid_wh AND OSS.loc_sid_store = MGR_INFOS.loc_sid_store
     INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CRY ON a.client_id = CRY.client_id
    WHERE CAST(iia.src_subitemgrp_cd AS FLOAT64) <> 996
    GROUP BY a.client_id,
     a.store_id,
     MGR_INFOS.sales_manager_id,
     MGR_INFOS.sales_manager_name,
     MGR_INFOS.account_manager_id,
     MGR_INFOS.account_manager_name,
     OSS.loc_sid_wh,
     wh_id,
     a.inv_id,
     a.cy_month,
     a.busyear,
     a.dat_valid_from,
     a.dat_valid_until,
     cons.itm_consgrp_id,
     cons.cons_orig_item_nr,
     cons.cons_dat_valid_from_item,
     cons.itm_consgrp_desc,
     cons_item_desc,
     currency_iso_cd
    HAVING diff_inv_stc_calc_val IS NOT NULL AND diff_inv_stc_calc_cnt <> 0) AS t26) AS act
 INNER JOIN ldl_p_lew_bil_ac.v_store_2 AS OSA ON act.client_id = OSA.client_id AND act.store_id = OSA.loc_sid_store AND
      OSA.dwh_actual_fg = 1 AND OSA.deleted_fg = 0 AND OSA.test_store_fg = 0 AND OSA.pseudo_store_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_address_2 AS OSC ON OSA.client_id = OSC.client_id AND OSA.addr_sid = OSC.addr_sid
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS OWH ON act.client_id = OWH.client_id AND act.loc_sid_wh = OWH.loc_sid_wh AND
     OWH.dwh_actual_fg = 1 AND OWH.bges_active_fg = 1 AND OWH.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS RCC ON act.client_id = RCC.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_act_2 AS RCT ON RCC.country_id = RCT.country_id AND RCT.language_id = RCT
   .country_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_desc_2 AS RCD ON RCC.country_id = RCD.country_id AND RCD.language_id =
   RCD.country_id
QUALIFY CASE
   WHEN ABS(act.diff_inv_stc_calc_val) IS NULL OR ABS(act.diff_inv_stc_calc_val) = 0
   THEN -1
   ELSE CAST(ROW_NUMBER() OVER (PARTITION BY act.client_id, act.store_id, act.inv_id, act.cy_month, act.dat_valid_from, act.dat_valid_until ORDER BY ABS(act.diff_inv_stc_calc_val) NULLS LAST, ABS(act.prev_diff_inv_stc_calc_cnt) NULLS LAST, act.itm_consgrp_id NULLS LAST, act.cons_orig_item_nr
       NULLS LAST, act.cons_dat_valid_from_item NULLS LAST) AS INTEGER)
   END BETWEEN 1 AND 30;