
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_INV_TOP_20_CUM_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT 
     act.country_id,  
   act.cy_month,  
   act.wh_id, 
   act.client_id, 
   act.byr, 
   act.store_id,  
   act.diff_inv_cum / rate_currency_exchange          AS diff_inv_cum,  
   act.diff_net_inv_cum / rate_currency_exchange      AS diff_net_inv_cum,  
   act.ums_cum / rate_currency_exchange               AS ums_cum, 
   act.ums_net_cum / rate_currency_exchange           AS ums_net_cum, 
   py.diff_inv_cum / rate_currency_exchange           AS diff_inv_cum_py, 
   py.diff_net_inv_cum / rate_currency_exchange       AS diff_net_inv_cum_py, 
   py.ums_cum / rate_currency_exchange                AS ums_cum_py,  
   py.ums_net_cum / rate_currency_exchange            AS ums_net_cum_py,  
   act.diff_inv_ums_pct,  
   act.diff_net_inv_ums_pct,  
   cry.currency_iso_cd, 
   ROW_NUMBER () OVER ( PARTITION BY act.client_id, act.cy_month, act.wh_id, cry.currency_iso_cd  ORDER BY act.diff_inv_ums_pct DESC NULLS LAST, act.diff_inv_cum DESC NULLS LAST ) rank_wh_pct,  
   ROW_NUMBER () OVER ( PARTITION BY act.client_id, act.cy_month, cry.currency_iso_cd  ORDER BY act.diff_inv_ums_pct DESC NULLS LAST, act.diff_inv_cum DESC NULLS LAST  ) rank_client_pct 
  FROM  
  ( 
  SELECT  
    a12.client_id                  AS country_id, 
   a13.cy_month                   AS cy_month,  
   a12.wh_id                      AS wh_id, 
   a12.client_id                  AS client_id, 
   a13.byr                        AS byr, 
   a12.store_id                   AS store_id,  
   a12.client_id                  AS client_id0,  
   SUM(SUM(a11.diff_inv)) OVER ( PARTITION BY a12.client_id, a13.byr, a12.store_id, a12.client_id ORDER BY a13.cy_month ASC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  diff_inv_cum,  
   SUM(SUM(a11.diff_net_inv)) OVER ( PARTITION BY a12.client_id, a13.byr, a12.store_id, a12.client_id ORDER BY a13.cy_month ASC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  diff_net_inv_cum,  
   SUM(SUM(a11.val_retail_store_inv_stc)) OVER ( PARTITION BY a12.client_id, a13.byr, a12.store_id, a12.client_id ORDER BY a13.cy_month ASC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  ums_cum, 
   SUM(SUM(a11.val_retail_store_net_inv_stc)) OVER ( PARTITION BY a12.client_id, a13.byr, a12.store_id, a12.client_id ORDER BY a13.cy_month ASC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  ums_net_cum, 
   CAST(COALESCE(diff_inv_cum,0) AS DECIMAL(22,6)) / CASE WHEN ums_cum = 0 THEN NULL ELSE ums_cum END diff_inv_ums_pct, 
   CAST(COALESCE(diff_net_inv_cum,0) AS DECIMAL(22,6)) / CASE WHEN ums_net_cum = 0 THEN NULL ELSE ums_net_cum END diff_net_inv_ums_pct  
  
   FROM p_lew_mart_msi.v_org_store_skey_1 a12 
   CROSS JOIN p_lew_mart_msi.v_cal_month_1 a13  
   LEFT JOIN  
   (  
   SELECT 
       client_id, 
   st_loc_sid AS store_id,  
   diff_inv,  
   diff_net_inv,  
   val_retail_store_inv_stc,  
   val_retail_store_net_inv_stc,  
   dat_valid_until  
  FROM p_lew_core_ac.v_wawi_inv_store_1 
  WHERE inv_fg = 71 AND status_inv_sic = 64 
  ) a11 
   ON  (a11.client_id = a12.client_id 
   AND a11.store_id  =  a12.store_id) 
   AND (EXTRACT(YEAR FROM a11.dat_valid_until ) * 100 + EXTRACT(MONTH FROM a11.dat_valid_until ) = a13.cy_month)  
   INNER JOIN p_lew_mart_msi.v_cal_busyear_1 a14  
   ON  (a13.byr = a14.byr)  
  
   WHERE (a14.cy_by_sequence BETWEEN -1 AND 0)  
   AND a13.cy_month_sequence <=  0  
   GROUP BY 
     a11.client_id  
   , a13.cy_month 
   , a12.wh_id  
   , a12.client_id  
   , a13.byr  
   , a12.store_id 
   , a12.client_id  
   ) act  
   LEFT OUTER JOIN  
   (  
   SELECT 
     a12.client_id     AS country_id, 
   a13.cy_month      AS cy_month, 
   a12.wh_id         AS wh_id,  
   a12.client_id     AS client_id,  
   a13.byr           AS byr,  
   a12.store_id      AS store_id, 
   a12.client_id     AS client_id0, 
   SUM(SUM(a11.diff_inv)) OVER ( PARTITION BY a12.client_id, a13.byr, a12.store_id, a12.client_id ORDER BY a13.cy_month ASC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  diff_inv_cum,  
   SUM(SUM(a11.diff_net_inv)) OVER ( PARTITION BY a12.client_id, a13.byr, a12.store_id, a12.client_id ORDER BY a13.cy_month ASC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  diff_net_inv_cum,  
   SUM(SUM(a11.val_retail_store_inv_stc)) OVER ( PARTITION BY a12.client_id, a13.byr, a12.store_id, a12.client_id ORDER BY a13.cy_month ASC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  ums_cum, 
   SUM(SUM(a11.val_retail_store_net_inv_stc)) OVER ( PARTITION BY a12.client_id, a13.byr, a12.store_id, a12.client_id ORDER BY a13.cy_month ASC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  ums_net_cum, 
   CAST(COALESCE(diff_inv_cum,0) AS DECIMAL(22,6)) / CASE WHEN ums_cum = 0 THEN NULL ELSE ums_cum END diff_inv_ums_pct, 
   CAST(COALESCE(diff_net_inv_cum,0) AS DECIMAL(22,6)) / CASE WHEN ums_net_cum = 0 THEN NULL ELSE ums_net_cum END diff_net_inv_ums_pct  
   FROM p_lew_mart_msi.v_org_store_skey_1 a12 
   CROSS JOIN p_lew_mart_msi.v_cal_month_1 a13  
   CROSS JOIN 
   (  
   SELECT dat_calendar FROM p_lew_mart_msi.v_cal_calendarday_1  
   WHERE cy_day_sequence = 0  
   ) act_day  
   LEFT JOIN  
   (  
   SELECT 
   client_id, 
   st_loc_sid AS store_id,  
   diff_inv,  
   diff_net_inv,  
   val_retail_store_inv_stc,  
   val_retail_store_net_inv_stc,  
   dat_valid_until  
  FROM p_lew_core_ac.v_wawi_inv_store_1 
  WHERE inv_fg = 71 AND status_inv_sic = 64 
  ) a11 
   ON  (a11.client_id = a12.client_id 
   AND a11.store_id  =  a12.store_id) 
   AND (EXTRACT(YEAR FROM a11.dat_valid_until ) * 100 + EXTRACT(MONTH FROM a11.dat_valid_until ) = a13.prev_cy_month) 
   AND CASE WHEN a13.cy_month_sequence = 0 THEN EXTRACT(DAY FROM a11.dat_valid_until )  ELSE 0 END <= EXTRACT (DAY FROM dat_calendar) 
   INNER JOIN p_lew_mart_msi.v_cal_busyear_1 a14  
   ON a13.byr = a14.byr 
  
   WHERE (a14.cy_by_sequence BETWEEN -1 AND 0)  
   AND a13.cy_month_sequence <=  0  
  
   GROUP BY 
     a11.client_id  
   , a13.cy_month 
   , a12.wh_id  
   , a12.client_id  
   , a13.byr  
   , a12.store_id 
   , a12.client_id  
  
   ) py 
   ON act.client_id = py.client_id  
   AND act.cy_month = py.cy_month 
   AND act.wh_id  =  py.wh_id 
   AND act.byr = py.byr 
   AND act.store_id  =  py.store_id 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry  
   ON   act.client_id = cry.client_id 
   AND  CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end  
  
   WHERE act.diff_inv_cum IS NOT NULL OR diff_inv_cum_py IS NOT NULL;
