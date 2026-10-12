/*
  Story           : https://jira.schwarz/browse/REP4-10237
  Database        : LDL_PRODUCTION_CLONE_LEAD_LEW_MART
  Target          : P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_MTH_1

  Source
    P_LEW_CORE_AC
    ptm           : v_workingtime_plan_store_day_1 (via p_lew_bil_ac.v_ptm_plan_time_store_day_1)
    c             : v_client_1
    cal           : v_cal_calendarday_1
    inv           : v_wawi_inv_store_1
    store_act     : v_wawi_org_store_act_1
    store_reloc   : v_wawi_org_all_store_reloc_act_1

    P_LEW_BIL_AC
    txj           : v_agg_store_day_piece_perf_1
    plan          : v_agg_store_day_piece_perf_plan_pep_1 (via p_lew_bil_ac.v_ptm_plan_time_store_day_1)
    sfo           : v_agg_store_day_sfo_1
    org           : v_org_store_merge_1

    P_LEW_MART_MSI
    d             : v_bo_descs_1


  History:
    2021-11-03  zied.nanaa_ext@mail.schwarz      Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_store_overview_mth.sql
    2022-05-12  Marcin Malec                     Instead of p_lew_core_ac.v_workingtime_plan_store_day_1 and p_lew_bil_ac.v_agg_store_day_piece_perf_plan_pep_1
                                                 view p_lew_bil_ac.v_ptm_plan_time_store_day_1 is used, which combines them and has an adjustment for France turnover calculation
    2022-08-23  Marcin Malec                     Stueckleistung part 2 / SPEC0165308 - Adding columns sales_pieces_ber, sales_pieces_py.
    2022-10-14  Michael Morris INC4885338, User Story: 343128 - Line 634: Added PCWO_REASON_ID 152 to list
    2022-10-14  Michael Morris INC5306134, User Story: 343128 - Missing CROSS JOIN criteria to currency table line 827.
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_bo_store_overview_mth_1
OPTIONS(DESCRIPTION = 'STÜCKLEISTUNG OVERVIEW MONTH (FILIALÜBERSICHT)')
AS
/* Neue Spalten für Stückleistung */ /* Ende neuen Spalten */ /* Neue Spalten für Stückleistung */
/* Ende neuen Spalten */ /* act_productivity */ /* act_productivity_net */ /* Planumsatz und Planstunden */
/* Monatserster des letzten Tages im Betrachtungszeitraum */
/* Monatsletzter des ersten Tages im Betrachtungszeitraum */ /* Istumsatz & Stunden_1 */
/* Monatserster des letzten Tages im Betrachtungszeitraum */ /* Abschriften_1 */
/* Monatserster des letzten Tages im Betrachtungszeitraum */ /* Inventurdaten */
/* Monatserster des letzten Tages im Betrachtungszeitraum */ /* Vorjahresdaten Umsatz und Kundenanzahl */
/* Monatserster des letzten Tages im Betrachtungszeitraum */ /* Buchung liegt vor Filialschließung */
SELECT t31.client_id,
 t31.country_desc,
 t31.country_id,
 t31.country_iso_cd,
 t31.store_id,
 t31.orig_store_nr,
 t31.store_desc,
 t31.city,
 t31.wh_id,
 t31.wh_desc,
 t31.sales_manager_id,
 t31.sales_manager_name,
 t31.account_manager_id,
 t31.account_manager_name,
 t31.dat_calendar,
 t31.cy_month,
 t31.currency_iso_cd,
 SUM(t31.plan_val_turnover) AS plan_val_turnover,
 SUM(t31.plan_val_turnover_net) AS plan_val_turnover_net,
 SUM(t31.plan_val_hours) AS plan_val_hours,
 SUM(t31.plan_val_inv_training) AS plan_val_inv_training,
 SUM(t31.plan_sales_pieces) AS plan_sales_pieces,
 AVG(t31.plan_avg_sales_price) AS plan_avg_sales_price,
  CASE
  WHEN SUM(t31.plan_sales_pieces) <> 0 AND SUM(t31.plan_val_hours) <> 0
  THEN SUM(t31.plan_sales_pieces) / SUM(t31.plan_val_hours)
  ELSE NULL
  END AS plan_piece_performance,
 SUM(t31.sales_pieces) AS sales_pieces,
 SUM(t31.sales_pieces_ber) AS sales_pieces_ber,
 SUM(t31.sales_pieces_py) AS sales_pieces_py,
 AVG(t31.avg_sales_price) AS avg_sales_price,
 AVG(t31.piece_receipt) AS piece_receipt,
  CASE
  WHEN SUM(t31.sales_pieces) <> 0 AND SUM(t31.time_working_netto_std) <> 0
  THEN SUM(t31.sales_pieces) / SUM(t31.time_working_netto_std)
  ELSE NULL
  END AS piece_performance,
 SUM(t31.val_retail) AS val_retail_asis,
 SUM(t31.val_retail_net) AS val_retail_net_asis,
 SUM(t31.cnt_customer) AS cnt_customer_asis,
 SUM(t31.val_retail_ber) AS val_retail_asis_ber,
 SUM(t31.val_retail_net_ber) AS val_retail_net_asis_ber,
 SUM(t31.cnt_customer_ber) AS cnt_customer_asis_ber,
 SUM(t31.val_retail_py) AS val_retail_asis_py,
 SUM(t31.val_retail_net_py) AS val_retail_net_asis_py,
 SUM(t31.cnt_customer_py) AS cnt_customer_asis_py,
 SUM(t31.sales_pieces_py) AS sales_pieces_asis_py,
  CASE
  WHEN SUM(t31.sales_pieces_py) <> 0 AND SUM(t31.time_working_netto_std_py) <> 0
  THEN SUM(t31.sales_pieces_py) / SUM(t31.time_working_netto_std_py)
  ELSE NULL
  END AS piece_performance_py,
 SUM(t31.time_working_netto_std) AS time_working_netto_std,
 SUM(t31.miss_times_perf) AS miss_times_perf,
 SUM(t31.`A118652`) AS plan_turnover_calc_ums_diff,
 SUM(t31.`A118653`) AS plan_turnover_calc_ums_dif_net,
 SUM(t31.`A118656`) AS plan_sales_qty_calc_abv_diff,
 SUM(t31.`A118657`) AS plan_sales_qty_calc_prod_diff,
 SUM(t31.`A118658`) AS plan_hours_calc_hrs_diff,
   SUM(t31.time_working_netto_std) + SUM(t31.miss_times_perf) - SUM(t31.`A118658`) AS diff_hours,
  SUM(t31.plan_val_turnover) / IF(SUM(t31.plan_val_hours) = 0, NULL, SUM(t31.plan_val_hours)) AS plan_productivity,
  SUM(t31.plan_val_turnover_net) / IF(SUM(t31.plan_val_hours) = 0, NULL, SUM(t31.plan_val_hours)) AS
 plan_productivity_net,
 SUM(t31.`A118660`) AS val_retail_calc_prod_diff,
 SUM(t31.`A118661`) AS val_retail_calc_prod_diff_net,
 SUM(t31.`A118662`) AS hrs_calc_prod_diff,
 COALESCE(SUM(t31.`A118663`), 0) AS miss_times_perf_calc_prod_diff,
 SUM(t31.val_rtl_rl_sfo_store) AS val_rtl_rl_sfo_store,
 SUM(t31.val_rtl_rl_net_sfo_store) AS val_rtl_rl_net_sfo_store,
  SUM(t31.val_rtl_rl_sfo_store) / IF(SUM(t31.val_retail) = 0, NULL, SUM(t31.val_retail)) AS sfo_to_val_retail_pct,
  SUM(t31.val_rtl_rl_net_sfo_store) / IF(SUM(t31.val_retail_net) = 0, NULL, SUM(t31.val_retail_net)) AS
 sfo_to_val_retail_net_pct,
 SUM(t31.val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
 SUM(t31.val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
 SUM(t31.val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
 SUM(t31.`A118654`) AS plan_turnover_calc_prod_diff,
 SUM(t31.`A118655`) AS plan_turnover_calc_pro_dif_net,
 SUM(t31.`A118659`) AS plan_hours_calc_prod_diff,
    (SUM(t31.val_retail) - SUM(t31.`A118652`)) / IF(SUM(t31.`A118652`) = 0, NULL, SUM(t31.`A118652`)) * 100 AS
 diff_val_retail_pct,
    (SUM(t31.val_retail_net) - SUM(t31.`A118653`)) / IF(SUM(t31.`A118653`) = 0, NULL, SUM(t31.`A118653`)) * 100 AS
 diff_val_retail_net_pct,
  SUM(t31.`A118660`) / IF(SUM(t31.`A118662`) + COALESCE(SUM(t31.`A118663`), 0) = 0, NULL, SUM(t31.`A118662`) + COALESCE(SUM(t31.`A118663`
      ), 0)) AS act_productivity,
  SUM(t31.`A118661`) / IF(SUM(t31.`A118662`) + COALESCE(SUM(t31.`A118663`), 0) = 0, NULL, SUM(t31.`A118662`) + COALESCE(SUM(t31.`A118663`
      ), 0)) AS act_productivity_net,
   SUM(t31.`A118660`) / IF(SUM(t31.`A118662`) + COALESCE(SUM(t31.`A118663`), 0) = 0, NULL, SUM(t31.`A118662`) + COALESCE(SUM(t31.`A118663`
       ), 0)) - SUM(t31.`A118654`) / IF(SUM(t31.`A118659`) = 0, NULL, SUM(t31.`A118659`)) AS diff_plan_act_productivity,
   SUM(t31.`A118661`) / IF(SUM(t31.`A118662`) + COALESCE(SUM(t31.`A118663`), 0) = 0, NULL, SUM(t31.`A118662`) + COALESCE(SUM(t31.`A118663`
       ), 0)) - SUM(t31.`A118655`) / IF(SUM(t31.`A118659`) = 0, NULL, SUM(t31.`A118659`)) AS diff_plan_act_productivity_net,
 SUM(t31.diff_inv) AS diff_inv,
 SUM(t31.diff_net_inv) AS diff_net_inv,
 SUM(t31.val_retail_store_inv_stc) AS val_retail_store_inv_stc,
 SUM(t31.val_retail_store_net_inv_stc) AS val_retail_store_net_inv_stc
FROM (SELECT agg_lvl1.client_id,
   agg_lvl1.store_id,
   agg_lvl1.cy_month,
   agg_lvl1.dat_calendar,
   D.orig_store_nr,
   D.store_desc,
   D.country_desc,
   D.country_id,
   D.country_iso_cd,
   D.city,
   D.wh_id,
   D.wh_desc,
   D.sales_manager_id,
   D.sales_manager_name,
   D.account_manager_id,
   D.account_manager_name,
   C0.curr_cd AS currency_iso_cd,
   agg_lvl1.plan_val_turnover,
   agg_lvl1.plan_val_turnover_net,
   agg_lvl1.plan_val_hours,
   agg_lvl1.plan_val_inv_training,
   agg_lvl1.plan_sales_pieces,
   agg_lvl1.plan_avg_sales_price,
   agg_lvl1.sales_pieces,
   agg_lvl1.sales_pieces_ber,
   agg_lvl1.avg_sales_price,
   agg_lvl1.piece_receipt,
   agg_lvl1.val_retail,
   agg_lvl1.val_retail_net,
   agg_lvl1.cnt_customer,
   agg_lvl1.val_retail_ber,
   agg_lvl1.val_retail_net_ber,
   agg_lvl1.cnt_customer_ber,
   agg_lvl1.val_retail_py,
   agg_lvl1.val_retail_net_py,
   agg_lvl1.cnt_customer_py,
   agg_lvl1.sales_pieces_py,
   agg_lvl1.time_working_netto_std_py,
   agg_lvl1.time_working_netto_std,
   agg_lvl1.miss_times_perf,
   agg_lvl1.val_rtl_rl_sfo_store,
   agg_lvl1.val_rtl_rl_net_sfo_store,
   agg_lvl1.val_rtl_net_sfo_mhd_break,
   agg_lvl1.val_rtl_net_sfo_other_stc_loss,
   agg_lvl1.val_rtl_net_sfo_str_deliv_qlty,
   agg_lvl1.diff_inv,
   agg_lvl1.diff_net_inv,
   agg_lvl1.val_retail_store_inv_stc,
   agg_lvl1.val_retail_store_net_inv_stc,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact
    THEN agg_lvl1.plan_val_turnover
    ELSE NULL
    END AS `A118652`,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact
    THEN agg_lvl1.plan_val_turnover_net
    ELSE NULL
    END AS `A118653`,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact AND agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING)
          , CAST(agg_lvl1.store_id AS STRING), agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))
    THEN agg_lvl1.plan_val_turnover
    ELSE NULL
    END AS `A118654`,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact AND agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING)
          , CAST(agg_lvl1.store_id AS STRING), agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))
    THEN agg_lvl1.plan_val_turnover_net
    ELSE NULL
    END AS `A118655`,
    CASE
    WHEN agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING), CAST(agg_lvl1.store_id AS STRING)
         , agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
    THEN agg_lvl1.plan_sales_pieces
    ELSE NULL
    END AS `A118656`,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact AND agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING)
          , CAST(agg_lvl1.store_id AS STRING), agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))
    THEN agg_lvl1.plan_sales_pieces
    ELSE NULL
    END AS `A118657`,
    CASE
    WHEN agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING), CAST(agg_lvl1.store_id AS STRING)
         , agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
    THEN agg_lvl1.plan_val_hours
    ELSE NULL
    END AS `A118658`,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact AND agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING)
          , CAST(agg_lvl1.store_id AS STRING), agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))
    THEN agg_lvl1.plan_val_hours
    ELSE NULL
    END AS `A118659`,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact AND agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING)
          , CAST(agg_lvl1.store_id AS STRING), agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))
    THEN agg_lvl1.val_retail
    ELSE NULL
    END AS `A118660`,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact AND agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING)
          , CAST(agg_lvl1.store_id AS STRING), agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))
    THEN agg_lvl1.val_retail_net
    ELSE NULL
    END AS `A118661`,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact AND agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING)
          , CAST(agg_lvl1.store_id AS STRING), agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))
    THEN agg_lvl1.time_working_netto_std
    ELSE NULL
    END AS `A118662`,
    CASE
    WHEN agg_lvl1.dat_fact <= agg_lvl1.max_ums_dat_fact AND agg_lvl1.dat_fact <= (MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY CAST(agg_lvl1.client_id AS STRING)
          , CAST(agg_lvl1.store_id AS STRING), agg_lvl1.dat_calendar RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))
    THEN agg_lvl1.miss_times_perf
    ELSE NULL
    END AS `A118663`
  FROM (SELECT client_id,
     store_id,
     dat_calendar,
     cy_month,
     dat_fact,
     SUM(plan_val_turnover) AS plan_val_turnover,
     SUM(plan_val_turnover_net) AS plan_val_turnover_net,
     SUM(plan_val_hours) AS plan_val_hours,
     SUM(plan_val_inv_training) AS plan_val_inv_training,
     SUM(plan_sales_pieces) AS plan_sales_pieces,
     AVG(plan_avg_sales_price) AS plan_avg_sales_price,
     SUM(sales_pieces) AS sales_pieces,
     SUM(sales_pieces_ber) AS sales_pieces_ber,
     AVG(avg_sales_price) AS avg_sales_price,
     AVG(piece_receipt) AS piece_receipt,
     SUM(val_retail) AS val_retail,
     SUM(val_retail_net) AS val_retail_net,
     SUM(cnt_customer) AS cnt_customer,
     SUM(val_retail_ber) AS val_retail_ber,
     SUM(val_retail_net_ber) AS val_retail_net_ber,
     SUM(cnt_customer_ber) AS cnt_customer_ber,
     SUM(val_retail_py) AS val_retail_py,
     SUM(val_retail_net_py) AS val_retail_net_py,
     SUM(cnt_customer_py) AS cnt_customer_py,
     SUM(sales_pieces_py) AS sales_pieces_py,
     SUM(time_working_netto_std_py) AS time_working_netto_std_py,
     SUM(time_working_netto_std) AS time_working_netto_std,
     SUM(IFNULL(miss_times_perf, 0)) AS miss_times_perf,
     SUM(val_rtl_rl_sfo_store) AS val_rtl_rl_sfo_store,
     SUM(val_rtl_rl_net_sfo_store) AS val_rtl_rl_net_sfo_store,
     SUM(val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
     SUM(val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
     SUM(val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
     MAX(max_ums_dat_fact) AS max_ums_dat_fact,
     MAX(max_hrs_dat_fact) AS max_hrs_dat_fact,
     SUM(diff_inv) AS diff_inv,
     SUM(diff_net_inv) AS diff_net_inv,
     SUM(val_retail_store_inv_stc) AS val_retail_store_inv_stc,
     SUM(val_retail_store_net_inv_stc) AS val_retail_store_net_inv_stc
    FROM (SELECT PTM_PLAN.client_id,
        PTM_PLAN.store_id,
        cal.cal_dt AS dat_calendar,
        PTM_PLAN.currency_iso_cd,
        cal.cy_month,
        PTM_PLAN.dat_plantime AS dat_fact,
        PTM_PLAN.val_turnover AS plan_val_turnover,
        PTM_PLAN.val_turnover AS plan_val_turnover_net,
           PTM_PLAN.val_inventory + PTM_PLAN.val_training + PTM_PLAN.val_misc + PTM_PLAN.val_working AS plan_val_hours,
          PTM_PLAN.val_inventory + PTM_PLAN.val_training + PTM_PLAN.val_misc AS plan_val_inv_training,
        CAST(PTM_PLAN.val_sales_pieces_pep AS BIGNUMERIC) AS plan_sales_pieces,
        CAST(PTM_PLAN.val_avg_price_pep AS BIGNUMERIC) AS plan_avg_sales_price,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces_ber,
        CAST(NULL AS BIGNUMERIC) AS avg_sales_price,
        CAST(NULL AS BIGNUMERIC) AS piece_receipt,
        CAST(NULL AS BIGNUMERIC) AS val_retail,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer,
        CAST(NULL AS BIGNUMERIC) AS val_retail_ber,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net_ber,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer_ber,
        CAST(NULL AS BIGNUMERIC) AS val_retail_py,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net_py,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer_py,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces_py,
        CAST(NULL AS BIGNUMERIC) AS time_working_netto_std_py,
        CAST(NULL AS BIGNUMERIC) AS time_working_netto_std,
        CAST(NULL AS BIGNUMERIC) AS miss_times_perf,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_sfo_store,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_net_sfo_store,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_mhd_break,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_other_stc_loss,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
        DATE(NULL) AS max_ums_dat_fact,
        DATE(NULL) AS max_hrs_dat_fact,
        CAST(NULL AS BIGNUMERIC) AS diff_inv,
        CAST(NULL AS BIGNUMERIC) AS diff_net_inv,
        CAST(NULL AS BIGNUMERIC) AS val_retail_store_inv_stc,
        CAST(NULL AS BIGNUMERIC) AS val_retail_store_net_inv_stc
       FROM ldl_p_lew_bil_ac.v_ptm_plan_time_store_day_1 AS PTM_PLAN
        INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON PTM_PLAN.client_id = C.client_id AND PTM_PLAN.currency_iso_cd = C
          .curr_cd
        INNER JOIN (SELECT CAL.cal_dt,
          CAL.cy_month,
          DATE_ADD(DATE_SUB(CAL.cal_dt, INTERVAL CAST(ROUND(CAL.day_of_month) AS INTEGER) DAY), INTERVAL 1 DAY) AS
          dt_from,
          DATE_SUB(IF(DATE_ADD(DATE_SUB(CAL.cal_dt, INTERVAL SAFE_CAST(ROUND(CAL.day_of_month) as INTEGER) DAY),
              INTERVAL 1 DAY) = LAST_DAY(DATE_ADD(DATE_SUB(CAL.cal_dt, INTERVAL SAFE_CAST(ROUND(CAL.day_of_month) as INTEGER
                 ) DAY), INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_ADD(DATE_SUB(CAL.cal_dt, INTERVAL SAFE_CAST(ROUND(CAL
                  .day_of_month) as INTEGER) DAY), INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_ADD(DATE_SUB(CAL
               .cal_dt, INTERVAL SAFE_CAST(ROUND(CAL.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY), INTERVAL 1
             MONTH)), INTERVAL 1 DAY) AS dt_to
         FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL
          INNER JOIN (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
            MAX(cal_dt) AS date_to
           FROM ldl_p_lew_core_ac.v_cal_calendarday_1
           WHERE cy_day_seq BETWEEN - 18 AND 0
            AND cal_dt < CURRENT_DATE) AS zeitbereich ON CAL.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
           ) AS cal ON PTM_PLAN.dat_plantime BETWEEN cal.dt_from AND cal.dt_to
       UNION ALL
       SELECT TXJ.client_id,
        TXJ.loc_sid_store AS store_id,
        cal.cal_dt AS dat_calendar,
        TXJ.currency_iso_cd,
        cal.cy_month,
        TXJ.dwh_cal_dt AS dat_fact,
        CAST(NULL AS BIGNUMERIC) AS plan_val_turnover,
        CAST(NULL AS BIGNUMERIC) AS plan_val_turnover_net,
        CAST(NULL AS BIGNUMERIC) AS plan_val_hours,
        CAST(NULL AS BIGNUMERIC) AS plan_val_inv_training,
        CAST(NULL AS BIGNUMERIC) AS plan_sales_pieces,
        CAST(NULL AS BIGNUMERIC) AS plan_avg_sales_price,
        CAST(TXJ.sales_pieces AS BIGNUMERIC) AS sales_pieces,
         CASE
         WHEN TXJ.dwh_cal_dt BETWEEN STORE_ACT.dat_calc_start_py AND STORE_ACT.dat_calc_end_py OR TXJ.dwh_cal_dt >=
             STORE_ACT.dat_calc_start_py AND STORE_RELOC.move_fg = 1 OR TXJ.dwh_cal_dt >= STORE_ACT.dat_calc_start_py
           AND STORE_ACT.dat_calc_end_py IS NULL
         THEN CAST(TXJ.sales_pieces AS BIGNUMERIC)
         ELSE NULL
         END AS sales_pieces_ber,
        CAST(TXJ.avg_sales_price AS BIGNUMERIC) AS avg_sales_price,
        CAST(TXJ.piece_receipt AS BIGNUMERIC) AS piece_receipt,
        TXJ.val_rtl_net AS val_retail,
        TXJ.val_rtl_net AS val_retail_net,
        TXJ.cnt_customer,
         CASE
         WHEN TXJ.dwh_cal_dt BETWEEN STORE_ACT.dat_calc_start_py AND STORE_ACT.dat_calc_end_py OR TXJ.dwh_cal_dt >=
             STORE_ACT.dat_calc_start_py AND STORE_RELOC.move_fg = 1 OR TXJ.dwh_cal_dt >= STORE_ACT.dat_calc_start_py
           AND STORE_ACT.dat_calc_end_py IS NULL
         THEN TXJ.val_rtl_net
         ELSE NULL
         END AS val_retail_ber,
         CASE
         WHEN TXJ.dwh_cal_dt BETWEEN STORE_ACT.dat_calc_start_py AND STORE_ACT.dat_calc_end_py OR TXJ.dwh_cal_dt >=
             STORE_ACT.dat_calc_start_py AND STORE_RELOC.move_fg = 1 OR TXJ.dwh_cal_dt >= STORE_ACT.dat_calc_start_py
           AND STORE_ACT.dat_calc_end_py IS NULL
         THEN TXJ.val_rtl_net
         ELSE NULL
         END AS val_retail_net_ber,
         CASE
         WHEN TXJ.dwh_cal_dt BETWEEN STORE_ACT.dat_calc_start_py AND STORE_ACT.dat_calc_end_py OR TXJ.dwh_cal_dt >=
             STORE_ACT.dat_calc_start_py AND STORE_RELOC.move_fg = 1 OR TXJ.dwh_cal_dt >= STORE_ACT.dat_calc_start_py
           AND STORE_ACT.dat_calc_end_py IS NULL
         THEN TXJ.cnt_customer
         ELSE NULL
         END AS cnt_customer_ber,
        CAST(NULL AS BIGNUMERIC) AS val_retail_py,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net_py,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer_py,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces_py,
        CAST(NULL AS BIGNUMERIC) AS time_working_netto_std_py,
        CAST(TXJ.work_time_total_hr AS BIGNUMERIC) AS time_working_netto_std,
        CAST(TXJ.training_time_hr AS BIGNUMERIC) AS miss_times_perf,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_sfo_store,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_net_sfo_store,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_mhd_break,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_other_stc_loss,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
        MAX(TXJ.dwh_cal_dt) OVER (PARTITION BY CAST(TXJ.client_id AS STRING), CAST(TXJ.loc_sid_store AS STRING), cal.cal_dt
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_ums_dat_fact,
        MAX(TXJ.dwh_cal_dt) OVER (PARTITION BY CAST(TXJ.client_id AS STRING), CAST(TXJ.loc_sid_store AS STRING), cal.cal_dt
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_hrs_dat_fact,
        CAST(NULL AS BIGNUMERIC) AS diff_inv,
        CAST(NULL AS BIGNUMERIC) AS diff_net_inv,
        CAST(NULL AS BIGNUMERIC) AS val_retail_store_inv_stc,
        CAST(NULL AS BIGNUMERIC) AS val_retail_store_net_inv_stc
       FROM ldl_p_lew_bil_ac.v_agg_store_day_piece_perf_1 AS TXJ
        INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON TXJ.client_id = C.client_id AND TXJ.currency_iso_cd = C.curr_cd
          /* LKP Kalender */
        INNER JOIN (SELECT CAL.cal_dt,
          CAL.cy_month,
          DATE_ADD(DATE_SUB(CAL.cal_dt, INTERVAL CAST(ROUND(CAL.day_of_month) AS INTEGER) DAY), INTERVAL 1 DAY) AS
          dt_from
         FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL
          INNER JOIN (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
            MAX(cal_dt) AS date_to
           FROM ldl_p_lew_core_ac.v_cal_calendarday_1
           WHERE cy_day_seq BETWEEN - 18 AND 0
            AND cal_dt < CURRENT_DATE) AS zeitbereich ON CAL.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
           ) AS cal ON TXJ.dwh_cal_dt BETWEEN cal.dt_from AND cal.cal_dt /* Store-Infos */
        INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_reloc_act_1 AS STORE_RELOC ON TXJ.client_id = STORE_RELOC.client_id
           AND TXJ.loc_sid_store = STORE_RELOC.st_loc_sid
        LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_act_1 AS STORE_ACT ON STORE_RELOC.client_id = STORE_ACT.client_id AND
          STORE_RELOC.st_loc_sid = STORE_ACT.st_loc_sid
       UNION ALL
       SELECT SFO.client_id,
        ORG.loc_sid_store_move_to AS store_id,
        cal.cal_dt AS dat_calendar,
        C.curr_cd AS currency_iso_cd,
        cal.cy_month,
        SFO.booking_dat AS dat_fact,
        CAST(NULL AS BIGNUMERIC) AS plan_val_turnover,
        CAST(NULL AS BIGNUMERIC) AS plan_val_turnover_net,
        CAST(NULL AS BIGNUMERIC) AS plan_val_hours,
        CAST(NULL AS BIGNUMERIC) AS plan_val_inv_training,
        CAST(NULL AS BIGNUMERIC) AS plan_sales_pieces,
        CAST(NULL AS BIGNUMERIC) AS plan_avg_sales_price,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces_ber,
        CAST(NULL AS BIGNUMERIC) AS avg_sales_price,
        CAST(NULL AS BIGNUMERIC) AS piece_receipt,
        CAST(NULL AS BIGNUMERIC) AS val_retail,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer,
        CAST(NULL AS BIGNUMERIC) AS val_retail_ber,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net_ber,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer_ber,
        CAST(NULL AS BIGNUMERIC) AS val_retail_py,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net_py,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer_py,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces_py,
        CAST(NULL AS BIGNUMERIC) AS time_working_netto_std_py,
        CAST(NULL AS BIGNUMERIC) AS time_working_netto_std,
        CAST(NULL AS BIGNUMERIC) AS miss_times_perf,
        SFO.sfo_total_rtl_rl_val_asis AS val_rtl_rl_sfo_store,
        SFO.sfo_total_rtl_rl_net_val_asis AS val_rtl_rl_net_sfo_store,
         CASE
         WHEN SFO.pcwo_reason_id IN (1, 127, 134, 135, 2, 128)
         THEN SFO.sfo_total_rtl_rl_net_val_asis
         ELSE 0
         END AS val_rtl_net_sfo_mhd_break,
         CASE
         WHEN SFO.pcwo_reason_id IN (3, 136, 137, 152, 4, 101, 102, 110, 111, 129, 7, 130, 131)
         THEN SFO.sfo_total_rtl_rl_net_val_asis
         ELSE 0
         END AS val_rtl_net_sfo_other_stc_loss,
         CASE
         WHEN SFO.pcwo_reason_id IN (8)
         THEN SFO.sfo_total_rtl_rl_net_val_asis
         ELSE 0
         END AS val_rtl_net_sfo_str_deliv_qlty,
        DATE(NULL) AS max_ums_dat_fact,
        DATE(NULL) AS max_hrs_dat_fact,
        CAST(NULL AS BIGNUMERIC) AS diff_inv,
        CAST(NULL AS BIGNUMERIC) AS diff_net_inv,
        CAST(NULL AS BIGNUMERIC) AS val_retail_store_inv_stc,
        CAST(NULL AS BIGNUMERIC) AS val_retail_store_net_inv_stc
       FROM ldl_p_lew_bil_ac.v_agg_store_day_sfo_1 AS SFO
        INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON SFO.client_id = C.client_id /* LKP Kalender */
        INNER JOIN (SELECT CAL.cal_dt,
          CAL.cy_month,
          DATE_ADD(DATE_SUB(CAL.cal_dt, INTERVAL CAST(ROUND(CAL.day_of_month) AS INTEGER) DAY), INTERVAL 1 DAY) AS
          dt_from
         FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL
          INNER JOIN (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
            MAX(cal_dt) AS date_to
           FROM ldl_p_lew_core_ac.v_cal_calendarday_1
           WHERE cy_day_seq BETWEEN - 18 AND 0
            AND cal_dt < CURRENT_DATE) AS zeitbereich ON CAL.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
           ) AS cal ON SFO.booking_dat BETWEEN cal.dt_from AND cal.cal_dt
        INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_1 AS ORG ON SFO.client_id = ORG.client_id AND SFO.loc_sid_store =
           ORG.loc_sid_store AND ORG.aspect_id = 1
       WHERE SFO.sfotype_id IN (137, 147)
       UNION ALL
       SELECT INV.client_id,
        ORG.loc_sid_store_move_to AS store_id,
        cal.cal_dt AS dat_calendar,
        C.curr_cd AS currency_iso_cd,
        cal.cy_month,
        INV.dat_valid_until AS dat_fact,
        CAST(NULL AS BIGNUMERIC) AS plan_val_turnover,
        CAST(NULL AS BIGNUMERIC) AS plan_val_turnover_net,
        CAST(NULL AS BIGNUMERIC) AS plan_val_hours,
        CAST(NULL AS BIGNUMERIC) AS plan_val_inv_training,
        CAST(NULL AS BIGNUMERIC) AS plan_sales_pieces,
        CAST(NULL AS BIGNUMERIC) AS plan_avg_sales_price,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces_ber,
        CAST(NULL AS BIGNUMERIC) AS avg_sales_price,
        CAST(NULL AS BIGNUMERIC) AS piece_receipt,
        CAST(NULL AS BIGNUMERIC) AS val_retail,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer,
        CAST(NULL AS BIGNUMERIC) AS val_retail_ber,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net_ber,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer_ber,
        CAST(NULL AS BIGNUMERIC) AS val_retail_py,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net_py,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer_py,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces_py,
        CAST(NULL AS BIGNUMERIC) AS time_working_netto_std_py,
        CAST(NULL AS BIGNUMERIC) AS time_working_netto_std,
        CAST(NULL AS BIGNUMERIC) AS miss_times_perf,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_sfo_store,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_net_sfo_store,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_mhd_break,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_other_stc_loss,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
        DATE(NULL) AS ums_dat_fact,
        DATE(NULL) AS hrs_dat_fact,
        INV.diff_inv,
        INV.diff_net_inv,
        INV.val_retail_store_inv_stc,
        INV.val_retail_store_net_inv_stc
       FROM ldl_p_lew_core_ac.v_wawi_inv_store_1 AS INV
        INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON INV.client_id = C.client_id /* LKP Kalender */
        INNER JOIN (SELECT CAL.cal_dt,
          CAL.cy_month,
          DATE_ADD(DATE_SUB(CAL.cal_dt, INTERVAL CAST(ROUND(CAL.day_of_month) AS INTEGER) DAY), INTERVAL 1 DAY) AS
          dt_from
         FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL
          INNER JOIN (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
            MAX(cal_dt) AS date_to
           FROM ldl_p_lew_core_ac.v_cal_calendarday_1
           WHERE cy_day_seq BETWEEN - 18 AND 0
            AND cal_dt < CURRENT_DATE) AS zeitbereich ON CAL.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
           ) AS cal ON INV.dat_valid_until BETWEEN cal.dt_from AND cal.cal_dt
        INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_1 AS ORG ON INV.client_id = ORG.client_id AND INV.st_loc_sid = ORG.loc_sid_store
            AND ORG.aspect_id = 1
       WHERE INV.inv_fg = 71 /* Inventur_1 */
        AND INV.status_inv_sic = 64
         /* Inventur_1 ist gespeichert und verbucht (Logik von eLWIS DWH übernommen, im WaWI DWH existiert diese Bedingung nicht) */
         
       UNION ALL
       SELECT SALES.client_id,
        SALES.loc_sid_store AS store_id,
        cal.cal_dt AS dat_calendar,
        SALES.currency_iso_cd,
        cal.cy_month,
        IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)),
         DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) AS dat_fact,
        CAST(NULL AS BIGNUMERIC) AS plan_val_turnover,
        CAST(NULL AS BIGNUMERIC) AS plan_val_turnover_net,
        CAST(NULL AS BIGNUMERIC) AS plan_val_hours,
        CAST(NULL AS BIGNUMERIC) AS plan_val_inv_training,
        CAST(NULL AS BIGNUMERIC) AS plan_sales_pieces,
        CAST(NULL AS BIGNUMERIC) AS plan_avg_sales_price,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces,
        CAST(NULL AS BIGNUMERIC) AS sales_pieces_ber,
        CAST(NULL AS BIGNUMERIC) AS avg_sales_price,
        CAST(NULL AS BIGNUMERIC) AS piece_receipt,
        CAST(NULL AS BIGNUMERIC) AS val_retail,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer,
        CAST(NULL AS BIGNUMERIC) AS val_retail_ber,
        CAST(NULL AS BIGNUMERIC) AS val_retail_net_ber,
        CAST(NULL AS BIGNUMERIC) AS cnt_customer_ber,
         CASE
         WHEN IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH))
              , DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) >= STORE_ACT.dat_calc_start_py AND STORE_RELOC.move_fg =
             1 OR IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12
               MONTH)), DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) BETWEEN STORE_ACT.dat_calc_start_py AND STORE_ACT
            .dat_calc_end_py OR IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt,
               INTERVAL 12 MONTH)), DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) >= STORE_ACT.dat_calc_start_py AND
           STORE_ACT.dat_calc_end_py IS NULL
         THEN SALES.val_rtl_net
         ELSE 0
         END AS val_retail_py,
         CASE
         WHEN IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH))
              , DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) >= STORE_ACT.dat_calc_start_py AND STORE_RELOC.move_fg =
             1 OR IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12
               MONTH)), DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) BETWEEN STORE_ACT.dat_calc_start_py AND STORE_ACT
            .dat_calc_end_py OR IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt,
               INTERVAL 12 MONTH)), DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) >= STORE_ACT.dat_calc_start_py AND
           STORE_ACT.dat_calc_end_py IS NULL
         THEN SALES.val_rtl_net
         ELSE 0
         END AS val_retail_net_py,
         CASE
         WHEN IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH))
              , DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) >= STORE_ACT.dat_calc_start_py AND STORE_RELOC.move_fg =
             1 OR IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12
               MONTH)), DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) BETWEEN STORE_ACT.dat_calc_start_py AND STORE_ACT
            .dat_calc_end_py OR IF(SALES.dwh_cal_dt = LAST_DAY(SALES.dwh_cal_dt), LAST_DAY(DATE_ADD(SALES.dwh_cal_dt,
               INTERVAL 12 MONTH)), DATE_ADD(SALES.dwh_cal_dt, INTERVAL 12 MONTH)) >= STORE_ACT.dat_calc_start_py AND
           STORE_ACT.dat_calc_end_py IS NULL
         THEN SALES.cnt_customer
         ELSE 0
         END AS cnt_customer_py,
        CAST(SALES.sales_pieces AS BIGNUMERIC) AS sales_pieces_py,
        CAST(SALES.work_time_total_hr AS BIGNUMERIC) AS time_working_netto_std_py,
        CAST(NULL AS BIGNUMERIC) AS time_working_netto_std,
        CAST(NULL AS BIGNUMERIC) AS miss_times_perf,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_sfo_store,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_net_sfo_store,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_mhd_break,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_other_stc_loss,
        CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
        MAX(SALES.dwh_cal_dt) OVER (PARTITION BY CAST(SALES.client_id AS STRING), CAST(SALES.loc_sid_store AS STRING),
           cal.cal_dt RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_ums_dat_fact,
        DATE(NULL) AS max_hrs_dat_fact,
        CAST(NULL AS BIGNUMERIC) AS diff_inv,
        CAST(NULL AS BIGNUMERIC) AS diff_net_inv,
        CAST(NULL AS BIGNUMERIC) AS val_retail_store_inv_stc,
        CAST(NULL AS BIGNUMERIC) AS val_retail_store_net_inv_stc
       FROM ldl_p_lew_bil_ac.v_agg_store_day_piece_perf_1 AS SALES_1
        INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON SALES.client_id = C.client_id AND SALES.currency_iso_cd = C.curr_cd
          /* LKP Kalender */
        INNER JOIN (SELECT CAL.cal_dt,
          CAL.cy_month,
          DATE_ADD(DATE_SUB(CAL.cal_dt_prev_1y, INTERVAL CAST(ROUND(CAL.day_of_month) AS INTEGER) DAY), INTERVAL 1
           DAY) AS dt_from,
          CAL.cal_dt_prev_1y AS dt_to
         FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL
          INNER JOIN (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
            MAX(cal_dt) AS date_to
           FROM ldl_p_lew_core_ac.v_cal_calendarday_1
           WHERE cy_day_seq BETWEEN - 18 AND 0
            AND cal_dt < CURRENT_DATE) AS zeitbereich ON CAL.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
           ) AS cal ON SALES.dwh_cal_dt BETWEEN cal.dt_from AND cal.dt_to /* Reloc */
        INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_reloc_act_1 AS STORE_RELOC ON SALES.client_id = STORE_RELOC.client_id
           AND SALES.loc_sid_store = STORE_RELOC.st_loc_sid
        LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_act_1 AS STORE_ACT ON STORE_RELOC.client_id = STORE_ACT.client_id AND
          STORE_RELOC.st_loc_sid = STORE_ACT.st_loc_sid) AS agg_lvl0
    GROUP BY client_id,
     store_id,
     dat_calendar,
     cy_month,
     dat_fact) AS agg_lvl1
   INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C0 ON agg_lvl1.client_id = C0.client_id
   INNER JOIN ldl_p_lew_mart_msi.v_bo_descs_1 AS D ON agg_lvl1.client_id = D.client_id AND agg_lvl1.store_id = D.store_id
  WHERE agg_lvl1.dat_fact <= COALESCE(D.dat_closing_ovis, D.dat_closing, PARSE_DATE('%d.%m.%Y', '31.12.9999'))
   AND D.orig_store_nr <> D.wh_id /* Ausschluss von Dummy_1-Filialen hinter denen ein WH steckt */) AS t31
GROUP BY t31.client_id,
 t31.store_id,
 t31.cy_month,
 t31.dat_calendar,
 t31.orig_store_nr,
 t31.store_desc,
 t31.country_desc,
 t31.country_id,
 t31.country_iso_cd,
 t31.city,
 t31.wh_id,
 t31.wh_desc,
 t31.sales_manager_id,
 t31.sales_manager_name,
 t31.account_manager_id,
 t31.account_manager_name,
 t31.currency_iso_cd;
