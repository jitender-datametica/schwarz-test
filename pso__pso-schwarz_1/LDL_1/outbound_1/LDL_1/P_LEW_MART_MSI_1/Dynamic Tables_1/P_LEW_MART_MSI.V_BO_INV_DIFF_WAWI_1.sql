CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_bo_inv_diff_wawi_1
AS SELECT act.client_id,
 CTRY.country_name AS country_desc,
 CTRY.country_sid AS country_id,
 CTRY.src_country_lidl_cd AS country_iso_cd,
 act.store_id,
 OSA.src_orig_store_nr AS orig_store_nr,
 COALESCE(OSA.loc_name, OSA.loc_name2) AS store_desc,
 ADR.city,
 act.wh_id,
 COALESCE(OWH.loc_name, OWH.loc_name2) AS wh_desc,
 COALESCE(MGR_INFOS.sales_manager_id, - 100) AS sales_manager_id,
 COALESCE(MGR_INFOS.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
 COALESCE(MGR_INFOS.account_manager_id, - 1) AS account_manager_id,
 COALESCE(MGR_INFOS.account_manager_name, 'Vertriebsleiter') AS account_manager_name,
 act.inv_id,
 act.cy_month,
 act.busyear,
 act.dat_formdate,
 act.dat_valid_from,
 act.dat_valid_until,
 act.currency_iso_cd,
 act.day_cnt,
 act.diff_inv,
 act.diff_net_inv,
  act.diff_inv / CASE
   WHEN act.day_cnt = 0
   THEN NULL
   ELSE act.day_cnt
   END AS avg_diff_per_day,
 act.val_retail,
 act.val_retail_net,
 act.val_retail_cum_byr,
 act.val_retail_net_cum_byr,
 CAST(COALESCE(act.diff_inv / CASE
      WHEN act.val_retail = 0
      THEN NULL
      ELSE act.val_retail
      END, 0) * 100 AS BIGNUMERIC) AS inv_diff_to_val_rtl_pct,
 ROUND(CAST(COALESCE(act.diff_net_inv / CASE
       WHEN act.val_retail_net = 0
       THEN NULL
       ELSE act.val_retail_net
       END, 0) * 100 AS BIGNUMERIC), 4) AS inv_diff_to_val_rtl_net_pct,
 act.diff_busyear_cum,
 act.diff_net_busyear_cum,
  act.diff_busyear_cum / CASE
   WHEN act.day_cnt_cum_byr = 0
   THEN NULL
   ELSE act.day_cnt_cum_byr
   END AS avg_diff_per_day_cum,
 CAST(act.diff_busyear_cum / CASE
     WHEN act.val_retail_cum_byr = 0
     THEN NULL
     ELSE act.val_retail_cum_byr
     END * 100 AS BIGNUMERIC) AS inv_diff_pct_cum,
 ROUND(CAST(act.diff_net_busyear_cum / CASE
      WHEN act.val_retail_net_cum_byr = 0
      THEN NULL
      ELSE act.val_retail_net_cum_byr
      END * 100 AS BIGNUMERIC), 4) AS inv_diff_net_pct_cum,
 CAST(py.diff_busyear_cum / CASE
     WHEN py.val_retail_cum_byr = 0
     THEN NULL
     ELSE py.val_retail_cum_byr
     END * 100 AS BIGNUMERIC) AS inv_diff_pct_cum_py,
 ROUND(CAST(py.diff_net_busyear_cum / CASE
      WHEN py.val_retail_net_cum_byr = 0
      THEN NULL
      ELSE py.val_retail_net_cum_byr
      END * 100 AS BIGNUMERIC), 4) AS inv_diff_net_pct_cum_py,
 act.day_cnt_cum_byr,
  CAST(act.diff_busyear_cum / CASE
      WHEN act.val_retail_cum_byr = 0
      THEN NULL
      ELSE act.val_retail_cum_byr
      END * 100 AS BIGNUMERIC) - CAST(py.diff_busyear_cum / CASE
      WHEN py.val_retail_cum_byr = 0
      THEN NULL
      ELSE py.val_retail_cum_byr
      END * 100 AS BIGNUMERIC) AS diff_inv_diff_pct_cum_act_py,
  ROUND(CAST(act.diff_net_busyear_cum / CASE
       WHEN act.val_retail_net_cum_byr = 0
       THEN NULL
       ELSE act.val_retail_net_cum_byr
       END * 100 AS BIGNUMERIC), 4) - ROUND(CAST(py.diff_net_busyear_cum / CASE
       WHEN py.val_retail_net_cum_byr = 0
       THEN NULL
       ELSE py.val_retail_net_cum_byr
       END * 100 AS BIGNUMERIC), 4) AS diff_inv_diff_net_pct_cum_py,
 top_20.inv_diff_top_20 AS top20_inv_diff_to_val_rtl_pct,
 top_20.inv_diff_top_20_net AS top20_inv_dif_val_rtl_net_pct
FROM (SELECT A.client_id,
   A.st_loc_sid AS store_id,
   TOS.src_wh_id AS wh_id,
   TOS.loc_sid_wh,
   A.inv_id,
   B.cy_month,
   C.busyear,
   A.dat_formdate,
   A.dat_valid_from,
   A.dat_valid_until,
    DATE_DIFF(A.dat_valid_until, A.dat_valid_from, DAY) + 1 AS day_cnt,
   SUM(DATE_DIFF(A.dat_valid_until, A.dat_valid_from, DAY) + 1) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.st_loc_sid AS STRING)
      , CAST(C.busyear AS STRING) ORDER BY A.dat_valid_until IS NULL, A.dat_valid_until ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW) AS day_cnt_cum_byr,
   A.val_retail_store_inv_stc AS val_retail,
   A.val_retail_store_net_inv_stc AS val_retail_net,
   A.val_retail_busyear AS val_retail_cum_byr,
   A.val_retail_net_busyear AS val_retail_net_cum_byr,
   A.diff_inv,
   A.diff_net_inv,
   A.diff_busyear_cum,
   A.diff_net_busyear_cum,
   CRY.curr_cd AS currency_iso_cd
  FROM ldl_p_lew_core_ac.v_wawi_inv_store_1 AS A
   INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS B ON B.cy_month = ROUND(CAST(CONCAT(CAST(EXTRACT(YEAR FROM A.dat_valid_until) AS STRING FORMAT '0000')
       , TRIM(CAST(EXTRACT(MONTH FROM A.dat_valid_until) AS STRING FORMAT '00'))) AS BIGNUMERIC), 0)
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS TOS ON A.client_id = TOS.client_id AND A.st_loc_sid =
     TOS.loc_sid_store
   INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_1 AS C ON B.busyear = C.busyear
   INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CRY ON A.client_id = CRY.client_id
  WHERE C.cy_by_seq IN (0, - 1)
   AND A.inv_fg = 71
   AND A.status_inv = 1) AS act
 INNER JOIN ldl_p_lew_bil_ac.v_store_1 AS OSA ON act.client_id = OSA.client_id AND act.store_id = OSA.loc_sid_store AND
     OSA.dwh_actual_fg = 1 AND OSA.deleted_fg = 0 AND OSA.test_store_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_address_1 AS ADR ON act.client_id = ADR.client_id AND OSA.addr_sid = ADR.addr_sid
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS OWH ON act.client_id = OWH.client_id AND act.wh_id = OWH.src_wh_id AND OWH.dwh_actual_fg
      = 1 AND OWH.bges_active_fg = 1 AND OWH.deleted_fg = 0
 LEFT JOIN (SELECT A0.client_id,
   A0.st_loc_sid AS store_id,
   TOS0.src_wh_id AS wh_id,
   A0.inv_id,
   B0.cy_month,
   C0.busyear,
   A0.dat_formdate,
   A0.dat_valid_from,
   A0.dat_valid_until,
    DATE_DIFF(A0.dat_valid_until, A0.dat_valid_from, DAY) + 1 AS day_cnt,
   SUM(DATE_DIFF(A0.dat_valid_until, A0.dat_valid_from, DAY) + 1) OVER (PARTITION BY CAST(A0.client_id AS STRING), CAST(A0.st_loc_sid AS STRING)
      , CAST(C0.busyear AS STRING) ORDER BY A0.dat_valid_until IS NULL, A0.dat_valid_until ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS day_cnt_cum_byr,
   A0.val_retail_store_inv_stc AS val_retail,
   A0.val_retail_store_net_inv_stc AS val_retail_net,
   A0.val_retail_busyear AS val_retail_cum_byr,
   A0.val_retail_net_busyear AS val_retail_net_cum_byr,
   A0.diff_inv,
   A0.diff_net_inv,
   A0.diff_busyear_cum,
   A0.diff_net_busyear_cum,
   CRY0.curr_cd AS currency_iso_cd
  FROM ldl_p_lew_core_ac.v_wawi_inv_store_1 AS A0
   INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS B0 ON B0.cy_month = ROUND(CAST(CONCAT(CAST(EXTRACT(YEAR FROM A0.dat_valid_until) AS STRING FORMAT '0000')
       , TRIM(CAST(EXTRACT(MONTH FROM A0.dat_valid_until) AS STRING FORMAT '00'))) AS BIGNUMERIC), 0)
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS TOS0 ON A0.client_id = TOS0.client_id AND A0.st_loc_sid
      = TOS0.loc_sid_store
   INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_1 AS C0 ON B0.busyear = C0.busyear
   INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CRY0 ON A0.client_id = CRY0.client_id
  WHERE C0.cy_by_seq IN (- 1, - 2)
   AND A0.inv_fg = 71
   AND A0.status_inv = 1) AS py ON act.client_id = py.client_id AND act.store_id = py.store_id AND act.busyear - 1 = py
    .busyear AND IF(DATE_ADD(act.dat_valid_until, INTERVAL 1 DAY) = LAST_DAY(DATE_ADD(act.dat_valid_until, INTERVAL 1
       DAY)), LAST_DAY(DATE_ADD(DATE_ADD(act.dat_valid_until, INTERVAL 1 DAY), INTERVAL - 12 MONTH)), DATE_ADD(DATE_ADD(act
      .dat_valid_until, INTERVAL 1 DAY), INTERVAL - 12 MONTH)) > py.dat_valid_until
 LEFT JOIN (SELECT t12.client_id,
   t12.busyear,
   t12.wh_id,
   t12.dat_valid_until,
   CAST(AVG(t12.diff_busyear_cum0) / AVG(t12.val_retail_cum_byr0) * 100 AS BIGNUMERIC) AS inv_diff_top_20,
   CAST(AVG(t12.diff_net_busyear_cum0) / AVG(t12.`A118612`) * 100 AS BIGNUMERIC) AS inv_diff_top_20_net,
   COUNT(*) AS cnt
  FROM (SELECT all_comb.client_id,
     all_comb.busyear,
     all_comb.wh_id,
     all_comb.dat_valid_until,
     CAST(act.diff_busyear_cum AS BIGNUMERIC) AS diff_busyear_cum0,
     CAST(act.val_retail_cum_byr AS BIGNUMERIC) AS val_retail_cum_byr0,
     CAST(act.diff_net_busyear_cum AS BIGNUMERIC) AS diff_net_busyear_cum0,
      CASE
      WHEN CAST(act.val_retail_net_cum_byr AS BIGNUMERIC) = 0
      THEN NULL
      ELSE CAST(act.val_retail_net_cum_byr AS BIGNUMERIC)
      END AS `A118612`
    FROM (SELECT A1.client_id,
       A1.st_loc_sid AS store_id,
       TOS1.src_wh_id AS wh_id,
       A1.inv_id,
       B1.cy_month,
       C1.busyear,
       A1.dat_formdate,
       A1.dat_valid_from,
       A1.dat_valid_until,
       A1.val_retail_busyear AS val_retail_cum_byr,
       A1.val_retail_net_busyear AS val_retail_net_cum_byr,
       A1.diff_busyear_cum,
       A1.diff_net_busyear_cum,
        CAST(A1.diff_busyear_cum AS BIGNUMERIC) / A1.val_retail_busyear AS inv_diff
      FROM ldl_p_lew_core_ac.v_wawi_inv_store_1 AS A1
       INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS B1 ON B1.cy_month = ROUND(CAST(CONCAT(CAST(EXTRACT(YEAR FROM A1.dat_valid_until) AS STRING FORMAT '0000')
           , TRIM(CAST(EXTRACT(MONTH FROM A1.dat_valid_until) AS STRING FORMAT '00'))) AS BIGNUMERIC), 0)
       INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS TOS1 ON A1.client_id = TOS1.client_id AND A1.st_loc_sid
          = TOS1.loc_sid_store
       INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_1 AS C1 ON B1.busyear = C1.busyear
       INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CRY1 ON A1.client_id = CRY1.client_id
      WHERE C1.cy_by_seq IN (0, - 1)
       AND A1.val_retail_busyear <> 0
       AND A1.inv_fg = 71
       AND A1.status_inv = 1) AS act
     INNER JOIN (SELECT A2.client_id,
       TOS2.src_wh_id AS wh_id,
       B2.busyear,
       A2.dat_valid_until
      FROM ldl_p_lew_core_ac.v_wawi_inv_store_1 AS A2
       INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS B2 ON B2.cy_month = ROUND(CAST(CONCAT(CAST(EXTRACT(YEAR FROM A2.dat_valid_until) AS STRING FORMAT '0000')
           , TRIM(CAST(EXTRACT(MONTH FROM A2.dat_valid_until) AS STRING FORMAT '00'))) AS BIGNUMERIC), 0)
       INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS TOS2 ON A2.client_id = TOS2.client_id AND A2.st_loc_sid
          = TOS2.loc_sid_store
       INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_1 AS C2 ON B2.busyear = C2.busyear
      WHERE C2.cy_by_seq IN (0, - 1)
       AND A2.inv_fg = 71
       AND A2.status_inv = 1
      GROUP BY A2.client_id,
       wh_id,
       B2.busyear,
       A2.dat_valid_until) AS all_comb ON act.client_id = all_comb.client_id AND act.wh_id = all_comb.wh_id AND act.dat_valid_until
         <= all_comb.dat_valid_until AND act.busyear = all_comb.busyear
    QUALIFY (RANK() OVER (PARTITION BY CAST(all_comb.client_id AS STRING), CAST(all_comb.busyear AS STRING), CAST(all_comb.wh_id AS STRING)
          , all_comb.dat_valid_until ORDER BY act.inv_diff IS NULL, act.inv_diff)) <= 20) AS t12
  GROUP BY t12.client_id,
   t12.busyear,
   t12.wh_id,
   t12.dat_valid_until) AS top_20 ON act.client_id = top_20.client_id AND act.busyear = top_20.busyear AND act.wh_id =
    top_20.wh_id AND act.dat_valid_until = top_20.dat_valid_until
 LEFT JOIN ldl_p_lew_bil_ac.v_location_organization_1 AS MGR_INFOS ON act.client_id = MGR_INFOS.client_id AND act.loc_sid_wh
     = MGR_INFOS.loc_sid_wh AND act.store_id = MGR_INFOS.loc_sid_store
   /* v_view.v_ref_client_country_1 rcc
v_view.v_ref_country_act_1 rct
v_view.v_ref_country_desc rcd */
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS CTRY ON act.client_id = CTRY.country_sid
QUALIFY (RANK() OVER (PARTITION BY CAST(act.client_id AS STRING), CAST(act.store_id AS STRING), CAST(act.inv_id AS STRING)
      , CAST(act.cy_month AS STRING), CAST(act.busyear AS STRING), act.dat_formdate, act.dat_valid_from, act.dat_valid_until
      ORDER BY py.dat_valid_until IS NULL, py.dat_valid_until)) = 1;

