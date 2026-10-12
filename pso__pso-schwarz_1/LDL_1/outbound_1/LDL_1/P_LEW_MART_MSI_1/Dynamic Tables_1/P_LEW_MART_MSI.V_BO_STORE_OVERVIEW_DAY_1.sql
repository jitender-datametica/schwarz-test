/*
  Story       : https://jira.schwarz/browse/REP4-10237
  Database    : LDL_PRODUCTION_CLONE_LEAD_LEW_MART
  Target      : P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_DAY_1
  Source
    P_LEW_CORE_AC
        ptm   : v_workingtime_plan_store_day_1 (via p_lew_bil_ac.v_ptm_plan_time_store_day_1)
        c     : v_client_1
        d     : v_bo_descs_1
        cal   : v_cal_calendarday_1
        inv   : v_wawi_inv_store_1
        org   : v_org_store_merge_1
        
    P_LEW_BIL_AC
        txj   : v_agg_store_day_piece_perf_1
        plan  : v_agg_store_day_piece_perf_plan_pep_1 (via p_lew_bil_ac.v_ptm_plan_time_store_day_1)
        sfo   : v_agg_store_day_sfo_1
        s2wlk : v_store_to_warehouse_lastknown_1
     
  History:
    2021-11-03  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_store_overview_day.sql
    2022-05-12  Marcin Malec                    Instead of p_lew_core_ac.v_workingtime_plan_store_day_1 and p_lew_bil_ac.v_agg_store_day_piece_perf_plan_pep_1
                                                view p_lew_bil_ac.v_ptm_plan_time_store_day_1 is used, which combines them and has an adjustment for France turnover calculation
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding column sales_pieces_py.
    2022-10-14  Michael Morris INC4885338, User Story: 343128 - Line 446: Added PCWO_REASON_ID 152 to list
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_bo_store_overview_day_1
OPTIONS(DESCRIPTION = 'STÜCKLEISTUNG OVERVIEW DAY (FILIALÜBERSICHT)')
AS
/* Stückleistung Spelaten */ /* Ende Stückleistung Spalten */ /* writeoffs for mhd and break of stores */
/* writeoffs for other stock losses of stores */ /* writeoffs for quality of delivery */
/* writeoffs for mhd and break of stores */ /* writeoffs for other stock losses of stores */
/* writeoffs for quality of delivery */ /* Dummy_1 Satz für Store und Tag_1, falls es keine Daten gibt */
/* New Plan columns */ /* New reported columns */ /* Planumsatz und Planstunden */ /* Istumsatz & Stunden_1 */
/* Abschriften_1 */ /* writeoffs for mhd and break of stores */ /* writeoffs for other stock losses of stores */
/* writeoffs for quality of delivery */ /* Vorjahresdaten Umsatz, Kundenanzahl & Stunden_1 */
/* Buchung liegt vor Filialschließung */ SELECT D.account_manager_id,
 D.account_manager_name,
  SUM(agg_lvl0.val_retail) / IF(SUM(agg_lvl0.time_working_netto_std) + COALESCE(SUM(agg_lvl0.miss_times_perf), 0) = 0,
   NULL, SUM(agg_lvl0.time_working_netto_std) + COALESCE(SUM(agg_lvl0.miss_times_perf), 0)) AS act_productivity,
  SUM(agg_lvl0.val_retail_net) / IF(SUM(agg_lvl0.time_working_netto_std) + COALESCE(SUM(agg_lvl0.miss_times_perf), 0) =
    0, NULL, SUM(agg_lvl0.time_working_netto_std) + COALESCE(SUM(agg_lvl0.miss_times_perf), 0)) AS act_productivity_net
 ,
 D.city,
 agg_lvl0.client_id,
 SUM(agg_lvl0.cnt_customer) AS cnt_customer_asis,
 D.country_desc,
 D.country_id,
 D.country_iso_cd,
 C0.curr_cd AS currency_iso_cd,
 agg_lvl0.dat_calendar,
   SUM(agg_lvl0.time_working_netto_std) + SUM(COALESCE(agg_lvl0.miss_times_perf, 0)) - SUM(agg_lvl0.plan_val_hours) AS
 diff_hours,
  CASE
  WHEN SUM(agg_lvl0.val_retail) IS NOT NULL
  THEN (SUM(agg_lvl0.val_retail) - SUM(agg_lvl0.plan_val_turnover)) / IF(SUM(agg_lvl0.plan_val_turnover) = 0, NULL, SUM(agg_lvl0
      .plan_val_turnover)) * 100
  ELSE NULL
  END AS diff_val_retail_pct,
  CASE
  WHEN SUM(agg_lvl0.val_retail_net) IS NOT NULL
  THEN (SUM(agg_lvl0.val_retail_net) - SUM(agg_lvl0.plan_val_turnover_net)) / IF(SUM(agg_lvl0.plan_val_turnover_net) = 0
      , NULL, SUM(agg_lvl0.plan_val_turnover_net)) * 100
  ELSE NULL
  END AS diff_val_retail_net_pct,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_ums_dat_fact) AND agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_hrs_dat_fact
     )
  THEN SUM(agg_lvl0.time_working_netto_std)
  ELSE NULL
  END AS hrs_calc_prod_diff,
 IFNULL(SUM(IFNULL(agg_lvl0.miss_times_perf, 0)), 0) AS miss_times_perf,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_ums_dat_fact) AND agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_hrs_dat_fact
     )
  THEN COALESCE(SUM(IFNULL(agg_lvl0.miss_times_perf, 0)), 0)
  ELSE 0
  END AS miss_times_perf_calc_prod_diff,
 D.orig_store_nr,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_hrs_dat_fact)
  THEN SUM(agg_lvl0.plan_val_hours)
  ELSE NULL
  END AS plan_hours_calc_hrs_diff,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_ums_dat_fact) AND agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_hrs_dat_fact
     )
  THEN SUM(agg_lvl0.plan_val_hours)
  ELSE NULL
  END AS plan_hours_calc_prod_diff,
  SUM(agg_lvl0.plan_val_turnover) / IF(SUM(agg_lvl0.plan_val_hours) = 0, NULL, SUM(agg_lvl0.plan_val_hours)) AS
 plan_productivity,
  SUM(agg_lvl0.plan_val_turnover_net) / IF(SUM(agg_lvl0.plan_val_hours) = 0, NULL, SUM(agg_lvl0.plan_val_hours)) AS
 plan_productivity_net,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_ums_dat_fact) AND agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_hrs_dat_fact
     )
  THEN SUM(agg_lvl0.plan_val_turnover)
  ELSE NULL
  END AS plan_turnover_calc_prod_diff,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_ums_dat_fact) AND agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_hrs_dat_fact
     )
  THEN SUM(agg_lvl0.plan_val_turnover_net)
  ELSE NULL
  END AS plan_turnover_calc_pro_dif_net,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_ums_dat_fact)
  THEN SUM(agg_lvl0.plan_val_turnover)
  ELSE NULL
  END AS plan_turnover_calc_ums_diff,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_ums_dat_fact)
  THEN SUM(agg_lvl0.plan_val_turnover_net)
  ELSE NULL
  END AS plan_turnover_calc_ums_dif_net,
 SUM(agg_lvl0.plan_val_hours) AS plan_val_hours,
 SUM(agg_lvl0.plan_val_inv_training) AS plan_val_inv_training,
 SUM(agg_lvl0.plan_val_turnover) AS plan_val_turnover,
 SUM(agg_lvl0.plan_val_turnover_net) AS plan_val_turnover_net,
 SUM(agg_lvl0.plan_sales_pieces) AS plan_sales_pieces,
 SUM(agg_lvl0.plan_avg_sales_price) AS plan_avg_sales_price,
 SUM(agg_lvl0.plan_piece_performance) AS plan_piece_performance,
 SUM(agg_lvl0.sales_pieces) AS sales_pieces,
 SUM(agg_lvl0.sales_pieces_py) AS sales_pieces_py,
 SUM(agg_lvl0.avg_sales_price) AS avg_sales_price,
 SUM(agg_lvl0.piece_receipt) AS piece_receipt,
 SUM(agg_lvl0.piece_performance) AS piece_performance,
 D.sales_manager_id,
 D.sales_manager_name,
 CAST(SUM(agg_lvl0.val_rtl_rl_sfo_store) / IF(SUM(agg_lvl0.val_retail) = 0, NULL, SUM(agg_lvl0.val_retail)) * 100 AS BIGNUMERIC)
 AS sfo_to_val_retail_pct,
 CAST(SUM(agg_lvl0.val_rtl_rl_net_sfo_store) / IF(SUM(agg_lvl0.val_retail_net) = 0, NULL, SUM(agg_lvl0.val_retail_net)) * 100 AS BIGNUMERIC)
 AS sfo_to_val_retail_net_pct,
 D.store_desc,
 agg_lvl0.store_id,
 SUM(agg_lvl0.time_working_netto_std) AS time_working_netto_std,
 SUM(agg_lvl0.val_retail) AS val_retail_asis,
 SUM(agg_lvl0.val_retail_net) AS val_retail_net_asis,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_ums_dat_fact) AND agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_hrs_dat_fact
     )
  THEN SUM(agg_lvl0.val_retail)
  ELSE NULL
  END AS val_retail_calc_prod_diff,
  CASE
  WHEN agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_ums_dat_fact) AND agg_lvl0.dat_calendar <= MAX(agg_lvl0.max_hrs_dat_fact
     )
  THEN SUM(agg_lvl0.val_retail_net)
  ELSE NULL
  END AS val_retail_calc_prod_diff_net,
 SUM(agg_lvl0.val_rtl_rl_sfo_store) AS val_rtl_rl_sfo_store,
 SUM(agg_lvl0.val_rtl_rl_net_sfo_store) AS val_rtl_rl_net_sfo_store,
 SUM(agg_lvl0.val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
 SUM(agg_lvl0.val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
 SUM(agg_lvl0.val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
 D.wh_desc,
 D.wh_id
FROM (SELECT S2WLK.client_id,
    S2WLK.loc_sid_store AS store_id,
    cal.cal_dt AS dat_calendar,
    C.curr_cd AS currency_iso_cd,
    CAST(NULL AS BIGNUMERIC) AS plan_val_turnover,
    CAST(NULL AS BIGNUMERIC) AS plan_val_turnover_net,
    CAST(NULL AS BIGNUMERIC) AS plan_val_hours,
    CAST(NULL AS BIGNUMERIC) AS plan_val_inv_training,
    CAST(NULL AS BIGNUMERIC) AS plan_sales_pieces,
    CAST(NULL AS BIGNUMERIC) AS plan_avg_sales_price,
    CAST(NULL AS BIGNUMERIC) AS plan_piece_performance,
    CAST(NULL AS BIGNUMERIC) AS val_retail,
    CAST(NULL AS BIGNUMERIC) AS val_retail_net,
    CAST(NULL AS BIGNUMERIC) AS cnt_customer,
    CAST(NULL AS BIGNUMERIC) AS time_working_netto_std,
    CAST(NULL AS BIGNUMERIC) AS miss_times_perf,
    CAST(NULL AS BIGNUMERIC) AS sales_pieces,
    CAST(NULL AS BIGNUMERIC) AS sales_pieces_py,
    CAST(NULL AS BIGNUMERIC) AS avg_sales_price,
    CAST(NULL AS BIGNUMERIC) AS piece_receipt,
    CAST(NULL AS BIGNUMERIC) AS piece_performance,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_sfo_store,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_net_sfo_store,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_mhd_break,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_other_stc_loss,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
    DATE(NULL) AS max_ums_dat_fact,
    DATE(NULL) AS max_hrs_dat_fact
   FROM ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS S2WLK
    INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON S2WLK.client_id = C.client_id
    INNER JOIN (SELECT CAL.cal_dt
     FROM (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
        MAX(cal_dt) AS date_to
       FROM ldl_p_lew_core_ac.v_cal_calendarday_1
       WHERE cy_day_seq BETWEEN - 18 AND 0
        AND cal_dt < CURRENT_DATE) AS zeitbereich
      INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON CAL.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich
       .date_to) AS cal ON TRUE
   UNION ALL
   SELECT PTM_PLAN.client_id,
    PTM_PLAN.store_id,
    PTM_PLAN.dat_plantime AS dat_calendar,
    PTM_PLAN.currency_iso_cd,
    PTM_PLAN.val_turnover AS plan_val_turnover,
    PTM_PLAN.val_turnover AS plan_val_turnover_net,
       PTM_PLAN.val_inventory + PTM_PLAN.val_training + PTM_PLAN.val_misc + PTM_PLAN.val_working AS plan_val_hours,
      PTM_PLAN.val_inventory + PTM_PLAN.val_training + PTM_PLAN.val_misc AS plan_val_inv_training,
    CAST(PTM_PLAN.val_sales_pieces_pep AS BIGNUMERIC) AS plan_sales_pieces,
    CAST(PTM_PLAN.val_avg_price_pep AS BIGNUMERIC) AS plan_avg_sales_price,
     CASE
     WHEN PTM_PLAN.val_sales_pieces_pep <> 0 AND PTM_PLAN.val_hours <> 0
     THEN CAST(PTM_PLAN.val_sales_pieces_pep / PTM_PLAN.val_hours AS BIGNUMERIC)
     ELSE NULL
     END AS plan_piece_performance,
    CAST(NULL AS BIGNUMERIC) AS val_retail,
    CAST(NULL AS BIGNUMERIC) AS val_retail_net,
    CAST(NULL AS BIGNUMERIC) AS cnt_customer,
    CAST(NULL AS BIGNUMERIC) AS time_working_netto_std,
    CAST(NULL AS BIGNUMERIC) AS miss_times_perf,
    CAST(NULL AS BIGNUMERIC) AS sales_pieces,
    CAST(NULL AS BIGNUMERIC) AS sales_pieces_py,
    CAST(NULL AS BIGNUMERIC) AS avg_sales_price,
    CAST(NULL AS BIGNUMERIC) AS piece_receipt,
    CAST(NULL AS BIGNUMERIC) AS piece_performance,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_sfo_store,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_net_sfo_store,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_mhd_break,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_other_stc_loss,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
    DATE(NULL) AS max_ums_dat_fact,
    DATE(NULL) AS max_hrs_dat_fact
   FROM ldl_p_lew_bil_ac.v_ptm_plan_time_store_day_1 AS PTM_PLAN
    INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON PTM_PLAN.client_id = C.client_id AND PTM_PLAN.currency_iso_cd = C.curr_cd
      
    INNER JOIN (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
      MAX(cal_dt) AS date_to
     FROM ldl_p_lew_core_ac.v_cal_calendarday_1
     WHERE cy_day_seq BETWEEN - 18 AND 0
      AND cal_dt < CURRENT_DATE) AS cal ON PTM_PLAN.dat_plantime BETWEEN cal.date_from AND cal.date_to
   UNION ALL
   SELECT TXJ.client_id,
    TXJ.loc_sid_store AS store_id,
    TXJ.dwh_cal_dt AS dat_calendar,
    TXJ.currency_iso_cd,
    CAST(NULL AS BIGNUMERIC) AS plan_val_turnover,
    CAST(NULL AS BIGNUMERIC) AS plan_val_turnover_net,
    CAST(NULL AS BIGNUMERIC) AS plan_val_hours,
    CAST(NULL AS BIGNUMERIC) AS plan_val_inv_training,
    CAST(NULL AS BIGNUMERIC) AS plan_sales_pieces,
    CAST(NULL AS BIGNUMERIC) AS plan_avg_sales_price,
    CAST(NULL AS BIGNUMERIC) AS plan_piece_performance,
    TXJ.val_rtl_net AS val_retail,
    TXJ.val_rtl_net AS val_retail_net,
    TXJ.cnt_customer,
    CAST(TXJ.work_time_total_hr AS BIGNUMERIC) AS time_working_netto_std,
    CAST(TXJ.training_time_hr AS BIGNUMERIC) AS miss_times_perf,
    CAST(TXJ.sales_pieces AS BIGNUMERIC) AS sales_pieces,
    CAST(NULL AS BIGNUMERIC) AS sales_pieces_py,
    CAST(TXJ.avg_sales_price AS BIGNUMERIC) AS avg_sales_price,
    CAST(TXJ.piece_receipt AS BIGNUMERIC) AS piece_receipt,
    CAST(TXJ.piece_performance AS BIGNUMERIC) AS piece_performance,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_sfo_store,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_net_sfo_store,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_mhd_break,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_other_stc_loss,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
    MAX(TXJ.dwh_cal_dt) OVER (PARTITION BY CAST(TXJ.client_id AS STRING), CAST(TXJ.loc_sid_store AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_ums_dat_fact,
    MAX(TXJ.dwh_cal_dt) OVER (PARTITION BY CAST(TXJ.client_id AS STRING), CAST(TXJ.loc_sid_store AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_hrs_dat_fact
   FROM ldl_p_lew_bil_ac.v_agg_store_day_piece_perf_1 AS TXJ
    INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON TXJ.client_id = C.client_id AND TXJ.currency_iso_cd = C.curr_cd
      /* LKP Kalender */
    INNER JOIN (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
      MAX(cal_dt) AS date_to
     FROM ldl_p_lew_core_ac.v_cal_calendarday_1
     WHERE cy_day_seq BETWEEN - 18 AND 0
      AND cal_dt < CURRENT_DATE) AS cal ON TXJ.dwh_cal_dt BETWEEN cal.date_from AND cal.date_to
   UNION ALL
   SELECT SFO.client_id,
    ORG.loc_sid_store_move_to AS store_id,
    SFO.booking_dat AS dat_calendar,
    C.curr_cd AS currency_iso_cd,
    CAST(NULL AS BIGNUMERIC) AS plan_val_turnover,
    CAST(NULL AS BIGNUMERIC) AS plan_val_turnover_net,
    CAST(NULL AS BIGNUMERIC) AS plan_val_hours,
    CAST(NULL AS BIGNUMERIC) AS plan_val_inv_training,
    CAST(NULL AS BIGNUMERIC) AS plan_sales_pieces,
    CAST(NULL AS BIGNUMERIC) AS plan_avg_sales_price,
    CAST(NULL AS BIGNUMERIC) AS plan_piece_performance,
    CAST(NULL AS BIGNUMERIC) AS val_retail,
    CAST(NULL AS BIGNUMERIC) AS val_retail_net,
    CAST(NULL AS BIGNUMERIC) AS cnt_customer,
    CAST(NULL AS BIGNUMERIC) AS time_working_netto_std,
    CAST(NULL AS BIGNUMERIC) AS miss_times_perf,
    CAST(NULL AS BIGNUMERIC) AS sales_pieces,
    CAST(NULL AS BIGNUMERIC) AS sales_pieces_py,
    CAST(NULL AS BIGNUMERIC) AS avg_sales_price,
    CAST(NULL AS BIGNUMERIC) AS piece_receipt,
    CAST(NULL AS BIGNUMERIC) AS piece_performance,
    SFO.sfo_total_rtl_rl_val_asis AS val_rtl_rl_sfo_store,
    SFO.sfo_total_rtl_rl_net_val_asis AS val_rtl_rl_net_sfo_store,
     CASE
     WHEN SFO.pcwo_reason_id IN (1, 127, 134, 135 /* mhd */, 2, 128 /* break */) /* in total store writeoffs */
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END AS val_rtl_net_sfo_mhd_break,
     CASE
     WHEN SFO.pcwo_reason_id IN (3, 136, 137, 152 /* force majeure */, 4, 101, 102, 110, 111, 129
       /* Warenentnahme Filiale */, 7, 130, 131 /* Spenden Filiale */) /* in total "other stock losses" */
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END AS val_rtl_net_sfo_other_stc_loss,
     CASE
     WHEN SFO.pcwo_reason_id IN (8)
     THEN SFO.sfo_total_rtl_rl_net_val_asis
     ELSE 0
     END AS val_rtl_net_sfo_str_deliv_qlty,
    DATE(NULL) AS max_ums_dat_fact,
    DATE(NULL) AS max_hrs_dat_fact
   FROM ldl_p_lew_bil_ac.v_agg_store_day_sfo_1 AS SFO
    INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON SFO.client_id = C.client_id /* LKP Kalender */
    INNER JOIN (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
      MAX(cal_dt) AS date_to
     FROM ldl_p_lew_core_ac.v_cal_calendarday_1
     WHERE cy_day_seq BETWEEN - 18 AND 0
      AND cal_dt < CURRENT_DATE) AS cal ON SFO.booking_dat BETWEEN cal.date_from AND cal.date_to
    INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_1 AS ORG ON SFO.client_id = ORG.client_id AND SFO.loc_sid_store = ORG.loc_sid_store
        AND ORG.aspect_id = 1
   WHERE SFO.sfotype_id IN (137, 147)
   UNION ALL
   SELECT SALES.client_id,
    SALES.loc_sid_store AS store_id,
    cal.cal_dt AS dat_calendar,
    SALES.currency_iso_cd,
    CAST(NULL AS BIGNUMERIC) AS plan_val_turnover,
    CAST(NULL AS BIGNUMERIC) AS plan_val_turnover_net,
    CAST(NULL AS BIGNUMERIC) AS plan_val_hours,
    CAST(NULL AS BIGNUMERIC) AS plan_val_inv_training,
    CAST(NULL AS BIGNUMERIC) AS plan_sales_pieces,
    CAST(NULL AS BIGNUMERIC) AS plan_avg_sales_price,
    CAST(NULL AS BIGNUMERIC) AS plan_piece_performance,
    CAST(NULL AS BIGNUMERIC) AS val_retail,
    CAST(NULL AS BIGNUMERIC) AS val_retail_net,
    CAST(NULL AS BIGNUMERIC) AS cnt_customer,
    CAST(NULL AS BIGNUMERIC) AS time_working_netto_std,
    CAST(NULL AS BIGNUMERIC) AS miss_times_perf,
    CAST(NULL AS BIGNUMERIC) AS sales_pieces,
    CAST(SALES.sales_pieces AS BIGNUMERIC) AS sales_pieces_py,
    CAST(NULL AS BIGNUMERIC) AS avg_sales_price,
    CAST(NULL AS BIGNUMERIC) AS piece_receipt,
    CAST(NULL AS BIGNUMERIC) AS piece_performance,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_sfo_store,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_rl_net_sfo_store,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_mhd_break,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_other_stc_loss,
    CAST(NULL AS BIGNUMERIC) AS val_rtl_net_sfo_str_deliv_qlty,
    DATE(NULL) AS max_ums_dat_fact,
    DATE(NULL) AS max_hrs_dat_fact
   FROM ldl_p_lew_bil_ac.v_agg_store_day_piece_perf_1 AS SALES_1
    INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON SALES.client_id = C.client_id AND SALES.currency_iso_cd = C.curr_cd
      /* Gleichen Wochentag des Vorjahres bestimmen */
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL_PY ON SALES.dwh_cal_dt /* LKP Kalender */ = CAL_PY.cal_dt_swday_prev_1y
     
    INNER JOIN (SELECT CAL.cal_dt
     FROM (SELECT DATE_SUB(MAX(cal_dt), INTERVAL 9 DAY) AS date_from,
        MAX(cal_dt) AS date_to
       FROM ldl_p_lew_core_ac.v_cal_calendarday_1
       WHERE cy_day_seq BETWEEN - 18 AND 0
        AND cal_dt < CURRENT_DATE) AS zeitbereich
      INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON CAL.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich
       .date_to) AS cal ON CAL_PY.cal_dt = cal.cal_dt /* Reloc */
    INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_reloc_act_1 AS STORE_RELOC ON SALES.client_id = STORE_RELOC.client_id
       AND SALES.loc_sid_store = STORE_RELOC.st_loc_sid
    LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_act_1 AS STORE_ACT ON STORE_RELOC.client_id = STORE_ACT.client_id AND
      STORE_RELOC.st_loc_sid = STORE_ACT.st_loc_sid) AS agg_lvl0
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C0 ON agg_lvl0.client_id = C0.client_id
 INNER JOIN ldl_p_lew_mart_msi.v_bo_descs_1 AS D ON agg_lvl0.client_id = D.client_id AND agg_lvl0.store_id = D.store_id
WHERE agg_lvl0.dat_calendar <= COALESCE(D.dat_closing_ovis, D.dat_closing, PARSE_DATE('%d.%m.%Y', '31.12.9999'))
 AND D.orig_store_nr <> D.wh_id /* Ausschluss von Dummy_1-Filialen hinter denen ein WH steckt */
GROUP BY D.orig_store_nr,
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
 currency_iso_cd,
 agg_lvl0.client_id,
 agg_lvl0.store_id,
 agg_lvl0.dat_calendar;