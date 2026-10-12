/*######################################################################################################################
#  Change management: 
# 1. first version designed at 2024-06-18
# 2. Change at 2024-06-25: Integration EWM KPI with WAMAS KPI when union the WAMAS and EWM calculation
#	  - Picked cases
#	  - EP Pallets
#	  - Qty_sum_workting_time_sec
# 3. Change at 2024-07-25: Integration Work_package_nr (warehouse order) and work_package_grp_nr (Queue)
# 4. 2025-09-23: Remapping EWM Queue to Wh_task_grp_nr
#
########################################################################################################################*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_picking_performance_day_wamas_ewm_1 (client_id, wh_id, wh_loc_sid,
dat_calendar, cy_week, cy_month, picking_main_area_nr_pp, picking_main_area_desc_pp, picking_area_nr_pp,
picking_area_desc_pp, picking_receipt_nr, order_nr, qty_sum_working_time_sec, means_of_transport_id, picked_cases,
picked_cases_by_pbv, picked_cases_not_by_pbv, picked_ep_places, thm_1, thm_2, thm_3, thm_4, thm_5, thm_else, thm_bb,
thm_bd, thm_cohu, thm_dtot, thm_epos, thm_es, thm_gma, thm_hg, thm_hs, thm_ip, thm_qg, thm_qp, thm_sg, thm_sp, thm_tb,
thm_tote, first_entry_fg, work_package_grp_nr, wh_task_grp_nr OPTIONS(description='Queue'), datenquelle) AS SELECT
 client_id,
 wh_id,
 wh_loc_sid,
 dwh_cal_dt AS dat_calendar,
 cy_week,
 cy_month,
 picking_main_area_nr_pp,
 picking_main_area_desc_pp,
 picking_area_nr_pp,
 picking_area_desc_pp,
 picking_receipt_nr,
 order_nr,
 qty_sum_working_time_sec,
 means_of_transport_id,
 picked_cases,
 picked_cases_by_pbv,
 picked_cases_not_by_pbv,
 picked_ep_places,
 thm_1,
 thm_2,
 thm_3,
 thm_4,
 thm_5,
 thm_else,
 0 AS thm_bb,
 0 AS thm_bd,
 0 AS thm_cohu,
 0 AS thm_dtot,
 0 AS thm_epos,
 0 AS thm_es,
 0 AS thm_gma,
 0 AS thm_hg,
 0 AS thm_hs,
 0 AS thm_ip,
 0 AS thm_qg,
 0 AS thm_qp,
 0 AS thm_sg,
 0 AS thm_sp,
 0 AS thm_tb,
 0 AS thm_tote,
 first_entry_fg,
 'N/A' AS work_package_grp_nr,
 'N/A' AS wh_task_grp_nr,
 'WAMAS' AS datenquelle
FROM ldl_p_lew_mart_lead.t_agg_picking_performance_day_1
UNION ALL
SELECT client_id,
 wh_id,
 wh_loc_sid,
 wh_task_confirm_dt AS dat_calendar,
 cy_week,
 cy_month,
 pick_main_area_nr AS picking_main_area_nr_pp,
 pick_main_area_descr AS picking_main_area_desc_pp,
 pick_area_nr AS picking_area_nr_pp,
 pick_area_descr AS picking_area_desc_pp,
 CAST(NULL AS NUMERIC) AS picking_receipt_nr,
 CAST(NULL AS STRING) AS order_nr,
  IFNULL(work_time_sec, 0) - IFNULL(sum_break_sec, 0) AS qty_sum_working_time_sec,
 CAST(NULL AS STRING) AS means_of_transport_id,
 pick_case_qty AS picked_cases,
 0 AS picked_cases_by_pbv,
 0 AS picked_cases_not_by_pbv,
 pick_pallet_qty AS picked_ep_places,
 thm_1,
 thm_2,
 thm_3,
 thm_4,
 thm_5,
 thm_else,
 thm_bb,
 thm_bd,
 thm_cohu,
 thm_dtot,
 thm_epos,
 thm_es,
 thm_gma,
 thm_hg,
 thm_hs,
 thm_ip,
 thm_qg,
 thm_qp,
 thm_sg,
 thm_sp,
 thm_tb,
 thm_tote,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(pick_main_area_nr AS STRING), CAST(pick_area_nr AS STRING)
       , work_package_nr ORDER BY pick_main_area_nr IS NULL, pick_main_area_nr, pick_area_nr IS NULL, pick_area_nr,
       work_package_nr IS NULL, work_package_nr)) = 1
  THEN 1
  ELSE 0
  END AS first_entry_fg,
 work_package_grp_nr,
 wh_task_grp_nr,
 'EWM' AS datenquelle
FROM ldl_p_lew_mart_lead.v_ewm_picking_rate_1;

