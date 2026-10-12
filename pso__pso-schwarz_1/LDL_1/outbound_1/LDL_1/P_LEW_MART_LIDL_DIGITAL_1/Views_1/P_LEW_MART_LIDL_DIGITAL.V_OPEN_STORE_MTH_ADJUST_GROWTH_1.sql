/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20211111_2971_st_open_mth_adj_hcal
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_lidl_digital_v_open_store_mth_adjust_growth.sql 17581 2021-11-17 12:34:46Z pmittler $
# $Revision: 17581 $
# $LastChangedBy: pmittler $
# $LastChangedDate: 2021-11-17 13:34:46 +0100 (Mi, 17 Nov 2021) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_lidl_digital/lew_mart_lidl_digital_v_open_store_mth_adjust_growth.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.1 2021-11-15 Patrick Mittler         Initial version
#  1.2 2021-11-22 Patrick Mittler         Edit counting days for current month
#                                         and create comments
#----------------------------------------------------------------------------

*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_open_store_mth_adjust_growth_1 (client_id, cy_month, adj_growth_fg,
reporting_start_dt, adjust_growth_start_date, cm_open_store_cnt, cm_cnt_days_start_digital,
cm_open_store_days_multiplied, pm_open_store_cnt, pm_cnt_days_start_digital, pm_open_store_days_multiplied,
pym_open_store_cnt, pym_cnt_days_start_digital, pym_open_store_days_multiplied) AS
/* ===============================================
   CM 
=============================================== */
/* ===============================================
   PM_1 
=============================================== */
/* ===============================================
   PYM 
=============================================== */
/* if pym is adjust_start_dt then cnt from same start date of the month */
/* ===============================================
   FROM  
=============================================== */
/* cnt days until the day before current day for current_month */ /* LKP adjust_growth_start_dt */
/* LKP adjust_growth_start_dt */ /* LKP adjust_growth_start_dt */ SELECT som.client_id,
 agc.cy_month,
 COALESCE(agc.adjust_growth_mth_fg, - 1) AS adj_growth_fg,
 cc.reporting_start_dt,
 agc.adjust_growth_start_dt AS adjust_growth_start_date,
 som.cm_mth_ending_str_open_fg AS cm_open_store_cnt,
 agc.cm_cnt_days_start_digital,
  som.cm_mth_ending_str_open_fg * agc.cm_cnt_days_start_digital AS cm_open_store_days_multiplied,
 som.pm_mth_ending_str_open_fg AS pm_open_store_cnt,
 pm_agc.cm_cnt_days_start_digital AS pm_cnt_days_start_digital,
  som.pm_mth_ending_str_open_fg * pm_agc.cm_cnt_days_start_digital AS pm_open_store_days_multiplied,
 som.pym_mth_ending_str_open_fg AS pym_open_store_cnt,
  CASE
  WHEN EXTRACT(MONTH FROM agc.adjust_growth_start_dt) = MM.month_id AND MM.cy = EXTRACT(YEAR FROM agc.adjust_growth_start_dt
     )
  THEN pym_agc.cm_cnt_days_start_digital - (EXTRACT(DAY FROM agc.adjust_growth_start_dt) - 1)
  ELSE pym_agc.cm_cnt_days_start_digital
  END AS pym_cnt_days_start_digital,
  som.pym_mth_ending_str_open_fg * CASE
   WHEN EXTRACT(MONTH FROM agc.adjust_growth_start_dt) = MM.month_id AND MM.cy = EXTRACT(YEAR FROM agc.adjust_growth_start_dt
      )
   THEN pym_agc.cm_cnt_days_start_digital - (EXTRACT(DAY FROM agc.adjust_growth_start_dt) - 1)
   ELSE pym_agc.cm_cnt_days_start_digital
   END AS pym_open_store_days_multiplied
FROM (SELECT client_id,
   cy_month,
   COUNT(DISTINCT CASE
     WHEN cm_mth_ending_str_open_fg = 1
     THEN move_to_store_id
     ELSE NULL
     END) AS cm_mth_ending_str_open_fg,
   COUNT(DISTINCT CASE
     WHEN pm_mth_ending_str_open_fg = 1
     THEN move_to_store_id
     ELSE NULL
     END) AS pm_mth_ending_str_open_fg,
   COUNT(DISTINCT CASE
     WHEN pym_mth_ending_str_open_fg = 1
     THEN move_to_store_id
     ELSE NULL
     END) AS pym_mth_ending_str_open_fg
  FROM ldl_p_lew_mart_lidl_digital.t_store_open_month_1 AS SOM
  WHERE move_to_store_id <> - 1
   AND aspect_id = 2
  GROUP BY client_id,
   cy_month) AS som
 INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS MM_1 ON som.cy_month = MM.cy_month AND MM.cy_month_seq <= 0
   /* ===============================================
   CM ADJ 
=============================================== */
 LEFT JOIN (SELECT AGC.client_id,
   AGC.cy_month,
   adj_start_dt.adjust_growth_start_dt,
   MAX(AGC.adjust_growth_mth_fg) AS adjust_growth_mth_fg,
   MAX(AGC.adjust_growth_pm_fg) AS adjust_growth_pm_fg,
    CASE
    WHEN CAL.cy_month_seq = 0
    THEN (SELECT day_of_month
     FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS C
     WHERE cy_day_seq = 0)
    ELSE CASE
     WHEN EXTRACT(DAY FROM MIN(AGC.cal_dt)) > 1
     THEN MAX(AGC.day_of_month) - EXTRACT(DAY FROM MIN(AGC.cal_dt)) + 1
     ELSE MAX(AGC.day_of_month)
     END
    END AS cm_cnt_days_start_digital
  FROM ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_1 AS AGC
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON AGC.cal_dt = CAL.cal_dt /* data until current month */ AND
     CAL.cy_month_seq <= 0
   INNER JOIN (SELECT client_id,
     MIN(cy_month) AS cy_month,
     MIN(cal_dt) AS adjust_growth_start_dt
    FROM ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_1 AS AGC
    WHERE adjust_growth_mth_fg = 1
    GROUP BY client_id) AS adj_start_dt ON AGC.client_id = adj_start_dt.client_id
  WHERE AGC.adjust_growth_mth_fg = 1
  GROUP BY AGC.client_id,
   AGC.cy_month,
   CAL.cy_month_seq,
   adj_start_dt.adjust_growth_start_dt) AS agc ON som.client_id = agc.client_id AND som.cy_month = agc.cy_month
   /* ===============================================
   PM_1 ADJ 
=============================================== */
 LEFT JOIN (SELECT AGC1.client_id,
   AGC1.cy_month,
   adj_start_dt.adjust_growth_start_dt,
   MAX(AGC1.adjust_growth_mth_fg) AS adjust_growth_mth_fg,
   MAX(AGC1.adjust_growth_pm_fg) AS adjust_growth_pm_fg,
    CASE
    WHEN EXTRACT(DAY FROM MIN(AGC1.cal_dt)) > 1
    THEN MAX(AGC1.day_of_month) - (EXTRACT(DAY FROM MIN(AGC1.cal_dt)) - 1)
    ELSE MAX(AGC1.day_of_month)
    END AS cm_cnt_days_start_digital
  FROM ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_1 AS AGC1
   INNER JOIN (SELECT client_id,
     MIN(cy_month) AS cy_month,
     MIN(cal_dt) AS adjust_growth_start_dt
    FROM ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_1 AS AGC
    WHERE adjust_growth_mth_fg = 1
    GROUP BY client_id) AS adj_start_dt ON AGC1.client_id = adj_start_dt.client_id
  GROUP BY AGC1.client_id,
   AGC1.cy_month,
   adj_start_dt.adjust_growth_start_dt) AS pm_agc ON som.client_id = pm_agc.client_id AND MM.cy_month_prev_1m = pm_agc.cy_month
   /* ===============================================
   PYM ADJ 
=============================================== */
 LEFT JOIN (SELECT AGC3.client_id,
   AGC3.cy_month,
   adj_start_dt.cy_month AS cy_month_adj_growth_start,
   adj_start_dt.adjust_growth_start_dt,
   MAX(AGC3.adjust_growth_mth_fg) AS adjust_growth_mth_fg,
   MAX(AGC3.adjust_growth_pm_fg) AS adjust_growth_pm_fg,
    CASE
    WHEN EXTRACT(DAY FROM MIN(AGC3.cal_dt)) > 1
    THEN MAX(AGC3.day_of_month) - (EXTRACT(DAY FROM MIN(AGC3.cal_dt)) - 1)
    ELSE MAX(AGC3.day_of_month)
    END AS cm_cnt_days_start_digital
  FROM ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_1 AS AGC3
   INNER JOIN (SELECT client_id,
     MIN(cy_month) AS cy_month,
     MIN(cal_dt) AS adjust_growth_start_dt
    FROM ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_1 AS AGC
    WHERE adjust_growth_mth_fg = 1
    GROUP BY client_id) AS adj_start_dt ON AGC3.client_id = adj_start_dt.client_id
  GROUP BY AGC3.client_id,
   AGC3.cy_month,
   cy_month_adj_growth_start,
   adj_start_dt.adjust_growth_start_dt) AS pym_agc ON som.client_id = pym_agc.client_id AND MM.cy_month_prev_1y =
   pym_agc.cy_month
 INNER JOIN (SELECT CC.client_id,
   CAL0.cy_month,
   CC.reporting_start_dt
  FROM ldl_p_lew_process_ac.v_lidlplus_config_client_1 AS CC
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL0 ON CC.reporting_start_dt = CAL0.cal_dt
  GROUP BY CC.client_id,
   CC.reporting_start_dt,
   CAL0.cy_month) AS cc ON agc.client_id = cc.client_id
WHERE agc.adjust_growth_mth_fg = 1;