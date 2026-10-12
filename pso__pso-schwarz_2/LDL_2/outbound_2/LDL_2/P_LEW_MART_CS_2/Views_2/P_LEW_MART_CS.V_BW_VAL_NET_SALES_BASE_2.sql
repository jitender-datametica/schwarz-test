/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_VAL_NET_SALES_BASE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* Total turnover Warehouse per month EJR net */ /* Total turnover Warehouse Business Year */
/* Total turnover Country_2 per month */ /* Ratio% per level country_2/month, BGES/month, VGES/month */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_val_net_sales_base_2 (client_id, iso_cd, busyear, cy_month, kpi_aspect,
wh_id, wh_descr, v_id, v_descr, currency_iso_cd, turnover_wh_month_val, turnover_wh_country_by_val,
turnover_country_month_val, wh_country_month_percent) AS /* Total turnover Warehouse per month EJR net */
/* Total turnover Warehouse Business Year */ /* Total turnover Country_2 per month */
/* Ratio% per level country_2/month, BGES/month, VGES/month */ SELECT AGG.client_id,
 CL.src_country_lidl_cd AS iso_cd,
 BYR.busyear,
 AGG.cy_month,
  CASE
  WHEN AGG.aspect_id = 1
  THEN 'BGES'
  ELSE 'VGES'
  END AS kpi_aspect,
 MAX(CASE
   WHEN AGG.aspect_id = 1
   THEN LOC.src_wh_id
   ELSE 0
   END) OVER (PARTITION BY CAST(WHMA.parent_wh_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS wh_id,
 UPPER(SUBSTR(MAX(CASE
     WHEN AGG.aspect_id = 1
     THEN WHMA.wh_desc
     ELSE ''
     END) OVER (PARTITION BY CAST(WHMA.parent_wh_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING), 1, 3)) AS wh_descr,
  CASE
  WHEN AGG.aspect_id = 2
  THEN LOC.src_wh_id
  ELSE NULL
  END AS v_id,
 UPPER(SUBSTR(CASE
    WHEN AGG.aspect_id = 2
    THEN WHMA.wh_desc
    ELSE ''
    END, 1, 3)) AS v_descr,
 CRY.curr_cd_to AS currency_iso_cd,
 ROUND(SUM(AGG.sales_net_val) + SUM(AGG.return_net_val), 2) AS turnover_wh_month_val,
 ROUND(SUM(ROUND(SUM(AGG.sales_net_val) + SUM(AGG.return_net_val), 2)) OVER (PARTITION BY CAST(AGG.client_id AS STRING)
     , CAST(AGG.aspect_id AS STRING), CRY.curr_cd_to, CAST(BYR.busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
   UNBOUNDED FOLLOWING), 2) AS turnover_wh_country_by_val,
 ROUND(SUM(ROUND(SUM(AGG.sales_net_val) + SUM(AGG.return_net_val), 2)) OVER (PARTITION BY CAST(AGG.client_id AS STRING)
     , CAST(AGG.aspect_id AS STRING), CAST(AGG.cy_month AS STRING), CRY.curr_cd_to RANGE BETWEEN UNBOUNDED PRECEDING AND
   UNBOUNDED FOLLOWING), 2) AS turnover_country_month_val,
 ROUND(ROUND(SUM(AGG.sales_net_val) + SUM(AGG.return_net_val), 2) / NULLIF(ROUND(SUM(ROUND(SUM(AGG.sales_net_val) + SUM(AGG
          .return_net_val), 2)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(AGG.aspect_id AS STRING), CAST(AGG.cy_month AS STRING)
         , CRY.curr_cd_to RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 2), 0) * 100, 2) AS
 wh_country_month_percent
FROM ldl_p_lew_bil_ac.v_agg_pos_wh_org_day_item_asis_2 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CL ON AGG.client_id = CL.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_merge_act_2 AS WHMA ON AGG.client_id = WHMA.client_id AND AGG.loc_sid_wh =
    WHMA.wh_loc_sid AND AGG.aspect_id
   /* #------------------------------------------------------------------------------
#Laut Anforderungen letztes Geschaeftsjahr und dieses Geschaeftsjahr soll selektiert werden
#------------------------------------------------------------------------------ */
   = WHMA.aspect_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON AGG.dwh_cal_dt = CAL.cal_dt
 INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_2 AS BYR ON CAL.busyear = BYR.busyear AND BYR.cy_by_seq IN (0, - 1)
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON AGG.client_id = LOC.client_id AND AGG.loc_sid_wh = LOC.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON AGG.client_id = CRY.client_id AND CRY.curr_cd_from =
     'EUR' /* Filtering for Home currency */ AND CURRENT_DATE BETWEEN CRY.active_from_dt AND CRY.active_to_dt
    /* latest rate (point in history) */ AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
   /* latest history (version) */
   /* #------------------------------------------------------------------------------
#Einschraenkung auf relevanten Kurstyp
#------------------------------------------------------------------------------ */
   
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS ERT ON CRY.client_id = ERT.client_id AND CRY.x_rate_type_sid = ERT
    .x_rate_type_sid AND ERT.src_kurst = '@BEWE'
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON AGG.client_id = ITMP.client_id AND AGG.item_sid = ITMP.item_sid
GROUP BY AGG.client_id,
 iso_cd,
 AGG.cy_month,
 AGG.aspect_id,
 LOC.src_wh_id,
 currency_iso_cd,
 CRY.exchange_rate,
 BYR.busyear,
 WHMA.wh_desc,
 WHMA.parent_wh_loc_sid;