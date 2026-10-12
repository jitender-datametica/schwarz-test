CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_agg_picking_performance_day AS
/* Gesellschaft */ -- qty_actual
 -- 1. Starting with the client ID

-- 2. Joining to the WAMAS performance table, filtering to day level by flag
 -- performance_type_cd = 'TAG'

-- 6. Joining the transport handling units
 SELECT C.client_id AS client_id, 
 WH.src_wh_id AS wh_id,
 PP.dwh_cal_dt AS dat_calendar,
 CAL.cy_week AS cy_week,
 CAL.cy_month AS cy_month,
 COALESCE(PMA.picking_main_area_nr_pp, 0) AS picking_main_area_nr_pp,
 COALESCE(PMA.picking_main_area_desc_pp, 'not defined') AS picking_main_area_desc_pp,
 PA.pick_area_id AS picking_area_nr_pp,
 PA.pick_area_descr AS picking_area_desc_pp,
 PP.pick_list_id AS picking_receipt_nr,
 CAST(PP.working_time_cnt AS NUMERIC) AS qty_sum_working_time_sec,
 PP.transport_method_cd AS means_of_transport_id,
 PP.act_pick_case_qty AS picked_cases,
  CASE
  WHEN SUBSTR(UPPER(PP.transport_method_cd), 1, 3) = 'PBV'
  THEN PP.act_pick_case_qty
  ELSE 0
  END AS picked_cases_by_pbv,
  CASE
  WHEN SUBSTR(UPPER(PP.transport_method_cd), 1, 3) <> 'PBV'
  THEN PP.act_pick_case_qty
  ELSE 0
  END AS picked_cases_not_by_pbv,
 SUM(COALESCE(POS.act_pick_qty, 0) * COALESCE(THM.factor_ep, 1)) AS picked_ep_places,
 SUM(CASE
   WHEN THM.orig_thm_nr = '1'
   THEN POS.act_pick_qty
   ELSE 0
   END) AS thm_1,
 SUM(CASE
   WHEN THM.orig_thm_nr = '2'
   THEN POS.act_pick_qty
   ELSE 0
   END) AS thm_2,
 SUM(CASE
   WHEN THM.orig_thm_nr = '3'
   THEN POS.act_pick_qty
   ELSE 0
   END) AS thm_3,
 SUM(CASE
   WHEN THM.orig_thm_nr = '4'
   THEN POS.act_pick_qty
   ELSE 0
   END) AS thm_4,
 SUM(CASE
   WHEN THM.orig_thm_nr = '5'
   THEN POS.act_pick_qty
   ELSE 0
   END) AS thm_5,
 SUM(CASE
   WHEN THM.orig_thm_nr IS NULL AND POS.act_pick_qty IS NOT NULL
   THEN POS.act_pick_qty
   ELSE 0
   END) AS thm_else
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country AS C
 INNER JOIN ldl_p_lew_core_ac.v_pick_performance AS PP ON C.client_id = PP.client_id AND PP.performance_type_cd = 'TAG'
   -- Auflösung WH

 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON PP.client_id = WH.client_id AND PP.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1 -- 3. Getting the calendar day table

 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON PP.dwh_cal_dt = CAL.cal_dt
  -- 4. Getting the picking area description - watch out for language ID

  -- 03.02.2016: All picking area descr. are stored with national language ID and

  -- Stiftung language ID 7, but there's no difference in the descr., no

  -- translation, so Stiftung's language is the selected one

 LEFT JOIN ldl_p_lew_core_ac.v_ref_pick_area_descr AS PA ON C.client_id = PA.client_id AND PP.loc_sid = PA.loc_sid AND
    PA.lang_sid = 2 AND PP.pick_area_id = PA.pick_area_id
 LEFT JOIN ldl_p_lew_mart_msi.v_itm_pp_picking_main_area AS PMA ON C.client_id = PMA.client_id AND WH.src_wh_id = PMA.wh_id_pp
     AND PP.pick_area_id = PMA.picking_area_nr_pp
   -- 5. Getting the picking details and filtering the result to transportation
 -- items by THM_CD = 1

   -- the receipt number is not unique until eternity, so additionally the

   -- pick start date is taken into account for the following date

 LEFT JOIN ldl_p_lew_core_ac.v_pick_list_pos AS POS ON C.client_id = POS.client_id AND PP.loc_sid = POS.loc_sid AND PP.pick_list_id
       = POS.pick_list_id AND PP.transport_method_cd = POS.transport_method_cd AND POS.thm_fg = 1 AND POS.pick_start_dt
   BETWEEN PP.dwh_cal_dt AND (DATE_ADD(PP.dwh_cal_dt, INTERVAL 1 DAY))
 LEFT JOIN ldl_p_lew_mart_msi.v_ref_thm AS THM ON C.client_id = THM.client_id AND POS.pick_item_nr = THM.orig_thm_nr
WHERE PP.working_time_cnt <> 0
GROUP BY C.client_id,
 wh_id,
 dat_calendar,
 CAL.cy_week,
 CAL.cy_month,
 picking_main_area_nr_pp,
 picking_main_area_desc_pp,
 picking_area_nr_pp,
 picking_area_desc_pp,
 picking_receipt_nr,
 PP.working_time_cnt,
 means_of_transport_id,
 picked_cases,
 picked_cases_by_pbv,
 picked_cases_not_by_pbv;
