--org_store_skey durch die BIL-Materialisierung ersetzt, die zudem den Vorteil hat permanent gefüllt zu sein (inkrementell NAchbefüllung.
--Schlimmstenfalls enthält die View noch nicht die tagesaktualisierten Werte, dies ist aber irrelevant, da neue Stores nicht sofort nach Auftauchen sofort
--Umsatz machen und auch ein Umhängen auf ein anderes WH nicht tageskritisch ist, da am nächsten Tag die Vergangenheit ohnehin sofort nachgezogen würde.
-- Planumsatz und Planstunden alle Level, alle Zeiten
-- bei überlappenden Planwerten für Gewinner- und Verlierer-Stores soll nur der Planwert vom Gewinner-Store angezeigt werden
-- Istumsatz alle Level, alle Zeiten

-- nur echte stores
-- Iststunden / Schulungsstunden alle Level, alle Zeiten
 -- Istumsatz alle Level, alle Zeiten


/* * Created by Jens Thole
 * on 14.06.2018
 * Inhalt: Grundgesamtheit der Faktenauswahl für bo_perflist; tagesgranular;
 * Quellen: BIL:t_agg_work_time_store_day, Core:t_wawi_ptm_plantimeday_wh,BIL:t_agg_sales_store_day
 * ausgehend von einem Schlüsselgerüst aus Faktenauswahltagen MART_MSI:v_bo_perf_cal_list_day
 * und den Stores aus BIL:v_store (aktiv, kein teststoe, kein pseudostore)
 * werden die Fakten der Quellen angeflanscht.
 * Letztere werden bzgl Store auf den letzten Gewinnerstore ihrer Fusions- bzw. Umzugshistorie) normiert und in Folge neu auf die
 * Granularität (Gewinnerstore, Tag) verdichtet
 * Hilfsattribute der Faktenauswahlzeit (MART_MSI:v_bo_perf_cal_list_day) werden übernommen.
 *--------------------------------------------------------------------------
 * Die View ist die erste Stufe zur Materialisierung der Tabelle p_lew_mart_msi.t_bo_base_performance_list
 ************************************************************************* */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_bo_base_performance_list AS SELECT dt_strs.client_id,
 dt_strs.loc_sid_store,
 dt_strs.cal_dt,
 dt_strs.py_caldt_shifted,
 dt_strs.cy_week,
 dt_strs.py_week_shifted,
 dt_strs.cy_week_seq,
 dt_strs.py_week_seq_shifted,
 dt_strs.cy_month,
 dt_strs.orig_store_nr,
 dt_strs.used_store_desc,
 dt_strs.loc_sid_wh,
 dt_strs.src_wh_id,
 dt_strs.used_wh_desc,
 dt_strs.addr_sid,
 dt_strs.used_opening_dt,
 dt_strs.used_closing_dt,
 dt_strs.is_daily_level_row,
 dt_strs.is_weekly_normal_level_row,
 dt_strs.is_weekly_pyshift_level_row,
 dt_strs.is_monthly_level_row,
 plan.plan_val_turnover,
 plan.plan_val_turnover_net,
 plan.plan_val_hours,
 plan.plan_val_inv_training,
 t8.val_retail,
 t8.val_retail_net,
 t8.cnt_customer,
 hrs.time_working_netto_std,
 hrs.miss_times_perf
FROM (SELECT s.client_id,
   s.loc_sid_store,
   s.orig_store_nr,
   s.used_store_desc,
   s.loc_sid_wh,
   s.src_wh_id,
   s.used_wh_desc,
   s.addr_sid,
   s.used_opening_dt,
   s.used_closing_dt,
   CAL.cal_dt,
   CAL.cy_week,
   CAL.cy_week_seq,
   CAL.cy_month,
   CAL.py_caldt_shifted,
   CAL.py_week_shifted,
   CAL.py_week_seq_shifted,
   CAL.is_daily_level_row,
   CAL.is_weekly_normal_level_row,
   CAL.is_weekly_pyshift_level_row,
   CAL.is_monthly_level_row
  FROM ldl_p_lew_mart_msi.v_bo_perf_cal_list_day AS CAL
   INNER JOIN (SELECT S.client_id,
     S.loc_sid_store,
     CAST(S.src_orig_store_nr AS BIGNUMERIC) AS orig_store_nr,
     COALESCE(S.loc_name2, S.loc_name) AS used_store_desc,
     OS.loc_sid_wh,
     OS.src_wh_id,
     COALESCE(OWH.loc_name2, OWH.loc_name) AS used_wh_desc,
     S.addr_sid,
     COALESCE(S.opening_dt, DATE '9999-12-30') AS used_opening_dt,
      CASE
      WHEN COALESCE(S.opening_dt, DATE '9999-12-30') < DATE '9999-12-30'
      THEN COALESCE(S.dat_closing_ovis, S.closing_dt, DATE '9999-12-30')
      ELSE DATE '1900-01-01'
      END AS used_closing_dt
    FROM ldl_p_lew_bil_ac.v_store AS S
     INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS OS ON S.client_id = OS.client_id AND S.loc_sid_store
       = OS.loc_sid_store
     INNER JOIN ldl_p_lew_core_ac.v_location AS OWH ON OS.client_id = OWH.client_id AND OS.loc_sid_wh = OWH.loc_sid
    WHERE S.dwh_actual_fg = 1
     AND S.test_store_fg = 0
     AND S.pseudo_store_fg = 0) AS s ON TRUE) AS dt_strs
 LEFT JOIN (SELECT t4.cal_dt,
   t4.loc_sid_store_move_to,
   t4.client_id,
   SUM(t4.turnover_net_val) AS plan_val_turnover,
   SUM(t4.turnover_net_val) AS plan_val_turnover_net,
   SUM(t4.`A11868`) AS plan_val_hours,
   SUM(t4.`A11869`) AS plan_val_inv_training
  FROM (SELECT A11.cal_dt,
     A12.loc_sid_store_move_to,
     A11.client_id,
     A11.turnover_net_val,
        A11.hours_inventory_cnt + A11.hours_training_cnt + A11.hours_misc_cnt + A11.hours_working_cnt AS `A11868`,
       A11.hours_inventory_cnt + A11.hours_training_cnt + A11.hours_misc_cnt AS `A11869`
    FROM ldl_p_lew_core_ac.v_workingtime_plan_store_day AS A11
     INNER JOIN ldl_p_lew_bil_ac.v_store_relocation AS A12 ON A11.client_id = A12.client_id AND A11.loc_sid_store = A12
       .loc_sid_store
     INNER JOIN ldl_p_lew_process_ac.v_bo_perf_client_status AS TODO ON A11.client_id = TODO.client_id
    QUALIFY A12.move_fg = (MIN(A12.move_fg) OVER (PARTITION BY A11.cal_dt, CAST(A12.loc_sid_store_move_to AS STRING), CAST(A11.client_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t4
  GROUP BY t4.cal_dt,
   t4.loc_sid_store_move_to,
   t4.client_id) AS plan ON dt_strs.cal_dt = plan.cal_dt AND dt_strs.client_id = plan.client_id AND dt_strs.loc_sid_store
    = plan.loc_sid_store_move_to
 LEFT JOIN (SELECT A110.dat_formdate,
   A120.loc_sid_store_move_to,
   A110.client_id,
   SUM(A110.val_retail) AS val_retail,
   SUM(A110.val_retail_net) AS val_retail_net,
   SUM(A110.cnt_customer) AS cnt_customer
  FROM ldl_p_lew_bil_ac.v_agg_sales_store_day AS A110
   INNER JOIN ldl_p_lew_bil_ac.v_store_relocation AS A120 ON A110.client_id = A120.client_id AND A110.loc_sid_store =
     A120.loc_sid_store
   INNER JOIN ldl_p_lew_process_ac.v_bo_perf_client_status AS TODO0 ON A110.client_id = TODO0.client_id
  GROUP BY A110.client_id,
   A110.dat_formdate,
   A120.loc_sid_store_move_to) AS t8 ON dt_strs.cal_dt = t8.dat_formdate AND dt_strs.client_id = t8.client_id AND
   dt_strs.loc_sid_store = t8.loc_sid_store_move_to
 LEFT JOIN (SELECT A111.dwh_cal_dt AS dat_working,
   A121.loc_sid_store_move_to,
   A111.client_id,
   SUM(A111.work_time_net_hr) AS time_working_netto_std,
   SUM(A111.perform_relev_absence_hr) AS miss_times_perf
  FROM ldl_p_lew_bil_ac.v_agg_work_time_store_day AS A111
   INNER JOIN ldl_p_lew_bil_ac.v_store_relocation AS A121 ON A111.client_id = A121.client_id AND A111.loc_sid_store =
     A121.loc_sid_store
   INNER JOIN ldl_p_lew_process_ac.v_bo_perf_client_status AS TODO1 ON A111.client_id = TODO1.client_id
  WHERE A111.work_time_net_hr IS NOT NULL
   OR A111.perform_relev_absence_hr IS NOT NULL
  GROUP BY dat_working,
   A121.loc_sid_store_move_to,
   A111.client_id) AS hrs ON dt_strs.cal_dt = hrs.dat_working AND dt_strs.client_id = hrs.client_id AND dt_strs.loc_sid_store
    = hrs.loc_sid_store_move_to
WHERE plan.client_id IS NOT NULL
 OR t8.client_id IS NOT NULL
 OR hrs.client_id IS NOT NULL;
