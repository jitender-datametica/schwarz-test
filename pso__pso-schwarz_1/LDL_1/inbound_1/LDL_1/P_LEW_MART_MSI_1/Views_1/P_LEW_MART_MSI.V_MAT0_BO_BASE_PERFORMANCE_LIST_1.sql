CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_BO_BASE_PERFORMANCE_LIST_1
AS
 /*
 * Created by Jens Thole
 * on 14.06.2018
 * Inhalt: Grundgesamtheit der Faktenauswahl für bo_perflist; tagesgranular;
 * Quellen: BIL:t_agg_work_time_store_day_1, Core:t_wawi_ptm_plantimeday_wh,BIL:t_agg_sales_store_day_1
 * ausgehend von einem Schlüsselgerüst aus Faktenauswahltagen MART_MSI:v_bo_perf_cal_list_day_1
 * und den Stores aus BIL:v_store_1 (aktiv, kein teststoe, kein pseudostore)
 * werden die Fakten der Quellen angeflanscht.
 * Letztere werden bzgl Store auf den letzten Gewinnerstore ihrer Fusions- bzw. Umzugshistorie) normiert und in Folge neu auf die
 * Granularität (Gewinnerstore, Tag_1) verdichtet
 * Hilfsattribute der Faktenauswahlzeit (MART_MSI:v_bo_perf_cal_list_day_1) werden übernommen.
 *--------------------------------------------------------------------------
 * Die View ist die erste Stufe zur Materialisierung der Tabelle p_lew_mart_msi.t_bo_base_performance_list_1
 **************************************************************************/
SELECT
dt_strs.client_id,
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
ums.val_retail,
ums.val_retail_net,
ums.cnt_customer,
hrs.time_working_netto_std,
hrs.miss_times_perf
FROM
(SELECT
s.client_id,
s.loc_sid_store,
s.orig_store_nr,
s.used_store_desc,
s.loc_sid_wh,
s.src_wh_id,
s.used_wh_desc,
s.addr_sid,
s.used_opening_dt,
s.used_closing_dt,
cal.cal_dt,
cal.cy_week,
cal.cy_week_seq,
cal.cy_month,
cal.py_caldt_shifted,
cal.py_week_shifted,
cal.py_week_seq_shifted,
cal.is_daily_level_row,
cal.is_weekly_normal_level_row,
cal.is_weekly_pyshift_level_row,
cal.is_monthly_level_row
FROM p_lew_mart_msi.v_bo_perf_cal_list_day_1 cal
CROSS JOIN (-- nur echte stores
SELECT
s.client_id,
s.loc_sid_store,
Cast(s.src_orig_store_nr AS INTEGER) orig_store_nr,
Coalesce(s.loc_name2,s.loc_name) used_store_desc,
os.loc_sid_wh,
os.src_wh_id,
Coalesce(owh.loc_name2,owh.loc_name) used_wh_desc,
s.addr_sid,
Coalesce( s.opening_dt, DATE'9999-12-30') used_opening_dt,
CASE WHEN used_opening_dt < DATE'9999-12-30'
                                      THEN Coalesce( s.dat_closing_ovis,  s.closing_dt, DATE'9999-12-30')
                                 ELSE DATE'1900-01-01' END used_closing_dt
FROM p_lew_bil_ac.v_store_1 s
--org_store_skey durch die BIL-Materialisierung ersetzt, die zudem den Vorteil hat permanent gefüllt zu sein (inkrementell NAchbefüllung.
--Schlimmstenfalls enthält die View noch nicht die tagesaktualisierten Werte, dies ist aber irrelevant, da neue Stores nicht sofort nach Auftauchen sofort
--Umsatz machen und auch ein Umhängen auf ein anderes WH nicht tageskritisch ist, da am nächsten Tag_1 die Vergangenheit ohnehin sofort nachgezogen würde.
INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS os
ON os.client_id = s.client_id
   AND os.loc_sid_store = s.loc_sid_store
INNER JOIN p_lew_core_ac.v_location_1 AS owh
ON os.client_id = owh.client_id
    AND os.loc_sid_wh = owh.loc_sid

WHERE s.dwh_actual_fg = 1
AND s.test_store_fg = 0
AND s.pseudo_store_fg = 0
) s
) dt_strs

-- Planumsatz und Planstunden alle Level, alle Zeiten
-- bei überlappenden Planwerten für Gewinner- und Verlierer-Stores soll nur der Planwert vom Gewinner-Store angezeigt werden
LEFT OUTER JOIN
(SELECT
ptm.cal_dt,
ptm.loc_sid_store_move_to,
ptm.client_id,
Sum(ptm.turnover_net_val)                                                                          AS plan_val_turnover,
Sum(ptm.turnover_net_val)                                                                          AS plan_val_turnover_net,
Sum(ptm.hours_inventory_cnt + ptm.hours_training_cnt + ptm.hours_misc_cnt + ptm.hours_working_cnt) AS plan_val_hours,
Sum(ptm.hours_inventory_cnt + ptm.hours_training_cnt + ptm.hours_misc_cnt)                         AS plan_val_inv_training
FROM (SELECT
a11.cal_dt,
a12.loc_sid_store_move_to,
a11.client_id,
a11.turnover_net_val,
a11.hours_working_cnt,
a11.hours_inventory_cnt,
a11.hours_training_cnt,
a11.hours_misc_cnt
FROM p_lew_core_ac.v_workingtime_plan_store_day_1 a11

INNER JOIN p_lew_bil_ac.v_store_relocation_1 a12
ON a11.client_id = a12.client_id
AND a11.loc_sid_store = a12.loc_sid_store

INNER JOIN p_lew_process_ac.v_bo_perf_client_status_1 todo
ON todo.client_id=a11.client_id
QUALIFY a12.move_fg = Min(a12.move_fg) Over (PARTITION BY a11.cal_dt, a12.loc_sid_store_move_to, a11.client_id)
) AS ptm
GROUP BY 1,2,3
) plan
ON plan.cal_dt                    = dt_strs.cal_dt
AND plan.client_id             = dt_strs.client_id
AND plan.loc_sid_store_move_to = dt_strs.loc_sid_store

LEFT OUTER JOIN  -- Istumsatz alle Level, alle Zeiten
(SELECT
a11.dat_formdate,
a12.loc_sid_store_move_to,
a11.client_id,
Sum(a11.val_retail)                           AS val_retail,
Sum(a11.val_retail_net)                       AS val_retail_net,
Sum(a11.cnt_customer)                         AS cnt_customer
FROM p_lew_bil_ac.v_agg_sales_store_day_1 a11

INNER JOIN p_lew_bil_ac.v_store_relocation_1 a12
ON a11.client_id = a12.client_id
    AND a11.loc_sid_store = a12.loc_sid_store

INNER JOIN p_lew_process_ac.v_bo_perf_client_status_1 todo
ON todo.client_id=a11.client_id
GROUP BY 1,2,3
) ums
ON ums.dat_formdate              = dt_strs.cal_dt
AND ums.client_id             = dt_strs.client_id
AND ums.loc_sid_store_move_to = dt_strs.loc_sid_store

LEFT OUTER JOIN -- Iststunden / Schulungsstunden alle Level, alle Zeiten
(SELECT
a11.dwh_cal_dt AS dat_working,
a12.loc_sid_store_move_to,
a11.client_id,
Sum(a11.work_time_net_hr)    AS time_working_netto_std,
Sum(a11.perform_relev_absence_hr)      AS miss_times_perf
FROM p_lew_bil_ac.v_agg_work_time_store_day_1 AS a11

INNER JOIN p_lew_bil_ac.v_store_relocation_1 a12
ON a11.client_id = a12.client_id
AND a11.loc_sid_store = a12.loc_sid_store

INNER JOIN p_lew_process_ac.v_bo_perf_client_status_1 todo
ON todo.client_id=a11.client_id
WHERE a11.work_time_net_hr IS NOT NULL
OR a11.perform_relev_absence_hr IS NOT NULL
GROUP BY 1,2,3
) hrs
ON hrs.dat_working               = dt_strs.cal_dt
AND hrs.client_id             = dt_strs.client_id
AND hrs.loc_sid_store_move_to = dt_strs.loc_sid_store
WHERE plan.client_id IS NOT NULL OR ums.client_id IS NOT NULL OR hrs.client_id IS NOT NULL
;



