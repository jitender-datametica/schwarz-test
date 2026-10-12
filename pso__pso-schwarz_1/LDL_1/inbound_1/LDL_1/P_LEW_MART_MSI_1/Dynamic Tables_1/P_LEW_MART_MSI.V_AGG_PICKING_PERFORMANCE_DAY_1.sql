
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_PICKING_PERFORMANCE_DAY_1
(
	client_id
	,wh_id
	,dat_calendar
	,cy_week
	,cy_month
	,picking_main_area_nr_pp
	,picking_main_area_desc_pp
	,picking_area_nr_pp
	,picking_area_desc_pp
	,picking_receipt_nr
	,qty_sum_working_time_sec
	,means_of_transport_id
	,picked_cases
	,picked_cases_by_pbv
	,picked_cases_not_by_pbv
	,picked_ep_places
	,thm_1
	,thm_2
	,thm_3
	,thm_4
	,thm_5
	,thm_else
)

TARGET_LAG = '1 hour, 30 minutes' -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS

SELECT
c.client_id
,wh.src_wh_id AS wh_id                        /* Gesellschaft */
,pp.dwh_cal_dt AS dat_calendar
,cal.cy_week
,cal.cy_month
,Coalesce(pma.picking_main_area_nr_pp, 0) AS picking_main_area_nr_pp
,Coalesce(pma.picking_main_area_desc_pp, 'not defined') AS picking_main_area_desc_pp
,pa.pick_area_id AS picking_area_nr_pp
,pa.pick_area_descr AS picking_area_desc_pp
,pp.pick_list_id AS picking_receipt_nr
,CAST(pp.working_time_cnt AS DECIMAL(18,4)) AS qty_sum_working_time_sec
,pp.transport_method_cd AS means_of_transport_id
,pp.act_pick_case_qty AS picked_cases
,CASE WHEN SUBSTR( Upper(pp.transport_method_cd), 1, 3) = 'PBV'
THEN pp.act_pick_case_qty
ELSE 0
END AS picked_cases_by_pbv
,CASE WHEN SUBSTR( Upper(pp.transport_method_cd), 1, 3) <> 'PBV'
THEN pp.act_pick_case_qty
ELSE 0
END AS picked_cases_not_by_pbv
,Sum(Coalesce(pos.act_pick_qty, 0) * Coalesce(thm.factor_ep, 1)) AS picked_ep_places
,Sum(CASE WHEN thm.orig_thm_nr = '1'
                  THEN pos.act_pick_qty
              ELSE 0
         END) AS thm_1
,Sum(CASE WHEN thm.orig_thm_nr = '2'
                  THEN pos.act_pick_qty
              ELSE 0
         END) AS thm_2
,Sum(CASE WHEN thm.orig_thm_nr = '3'
                  THEN pos.act_pick_qty
              ELSE 0
         END) AS thm_3
,Sum(CASE WHEN thm.orig_thm_nr = '4'
                  THEN pos.act_pick_qty
              ELSE 0
         END) AS thm_4
,Sum(CASE WHEN thm.orig_thm_nr = '5'
                  THEN pos.act_pick_qty-- qty_actual
              ELSE 0
         END) AS thm_5
,Sum(CASE WHEN thm.orig_thm_nr IS NULL AND pos.act_pick_qty IS NOT NULL
                  THEN pos.act_pick_qty
              ELSE 0
         END) AS thm_else

-- 1. Starting with the client ID
FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS c

-- 2. Joining to the WAMAS performance table, filtering to day level by flag
-- performance_type_cd = 'TAG_1'
INNER JOIN p_lew_core_ac.v_pick_performance_1 AS pp
ON  c.client_id = pp.client_id
AND pp.performance_type_cd = 'TAG_1'
-- Auflösung WH
INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
ON  wh.client_id = pp.client_id
AND wh.loc_sid_wh = pp.loc_sid
AND wh.dwh_actual_fg = 1

-- 3. Getting the calendar_1 day table
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
ON  pp.dwh_cal_dt = cal.cal_dt

-- 4. Getting the picking area description - watch out for language ID
-- 03.02.2016: All picking area descr. are stored with national language ID and
-- Stiftung language ID 7, but there's no difference in the descr., no
-- translation, so Stiftung's language is the selected one
LEFT OUTER JOIN p_lew_core_ac.v_ref_pick_area_descr_1 AS pa
ON  c.client_id = pa.client_id
AND pp.loc_sid  = pa.loc_sid
AND pa.lang_sid = 2
AND pp.pick_area_id = pa.pick_area_id

LEFT OUTER JOIN p_lew_mart_msi.v_itm_pp_picking_main_area_1 AS pma
ON  c.client_id = pma.client_id
AND wh.src_wh_id =   pma.wh_id_pp
AND pp.pick_area_id = pma.picking_area_nr_pp

-- 5. Getting the picking details and filtering the result to transportation
-- items by THM_CD = 1
-- the receipt number is not unique until eternity, so additionally the
-- pick start date is taken into account_1 for the following date
LEFT OUTER JOIN p_lew_core_ac.v_pick_list_pos_1 AS pos
ON  c.client_id = pos.client_id
AND pp.loc_sid  =  pos.loc_sid
AND pp.pick_list_id = pos.pick_list_id
AND pp.transport_method_cd = pos.transport_method_cd
AND pos.thm_fg = 1
AND pos.pick_start_dt BETWEEN pp.dwh_cal_dt AND pp.dwh_cal_dt + 1

-- 6. Joining the transport handling units
LEFT OUTER JOIN p_lew_mart_msi.v_ref_thm_1 AS thm
ON  c.client_id = thm.client_id
AND pos.pick_item_nr = thm.orig_thm_nr

WHERE pp.working_time_cnt <> 0

GROUP BY c.client_id
    , wh.src_wh_id
    , pp.dwh_cal_dt
    , cal.cy_week
    , cal.cy_month
    , Coalesce(pma.picking_main_area_nr_pp, 0)
    , Coalesce(pma.picking_main_area_desc_pp, 'not defined')
    , pa.pick_area_id
    , pa.pick_area_descr
    , pp.pick_list_id
    , pp.working_time_cnt
    , pp.transport_method_cd
    , pp.act_pick_case_qty
    , CASE WHEN SUBSTR( Upper(pp.transport_method_cd), 1, 3) = 'PBV'
THEN pp.act_pick_case_qty
ELSE 0
END
, CASE WHEN SUBSTR( Upper(pp.transport_method_cd), 1, 3) <> 'PBV'
THEN pp.act_pick_case_qty
ELSE 0
END
;



