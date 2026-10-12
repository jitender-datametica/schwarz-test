
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SFO_EJR_DAY_JOIN 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 8128 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)   
   #DescEnd#   
   */ 
   
   SELECT   
      ejr.client_id, 
   ejr.store_id,  
   ejr.dat_calendar, 
   ejr.currency_iso_cd, 
   sfo.qty_total_sfo_asis, 
   sfo.qty_t_sfo_wrtoff_zero_asis,  
   sfo.val_rtl_rl_sfo_asis,   
   sfo.val_rtl_rl_net_sfo_asis,  
   sfo.val_wrtoff_zero_asis,  
   sfo.val_wrtoff_zero_net_asis, 
   ejr.val_retail_asis, 
   ejr.val_retail_net_asis,   
   ejr.cnt_customer_asis,  
   ejr.val_retail_asis_py_sw, 
   ejr.val_retail_net_asis_py_sw,   
   ejr.cnt_customer_asis_py_sw,  
   ejr.val_retail_asis_py_sd, 
   ejr.val_retail_net_asis_py_sd,   
   ejr.cnt_customer_asis_py_sd,  
   ejr.val_retail_asis_adj,   
   ejr.val_retail_net_asis_adj,  
   ejr.cnt_customer_asis_adj, 
   ejr.cnt_store_open_rev  
   FROM  
   (  
     SELECT 
        sfo.client_id,  
   sfo.st_loc_sid                                                     AS store_id,  
   sfo.dat_formdate, 
   cry.currency_iso_cd                                                AS currency_iso_cd_asis,  
   SUM (sfo.qty_total_sfo)                                            AS qty_total_sfo_asis, 
   SUM (sfo.qty_total_sfo_wrtoff_zero)                                AS qty_t_sfo_wrtoff_zero_asis,  
   SUM (sfo.val_rtl_rl_sfo/ rate_currency_exchange)                   AS val_rtl_rl_sfo_asis,   
   SUM (sfo.val_wrtoff_zero/ rate_currency_exchange)                  AS val_wrtoff_zero_asis,  
   SUM (sfo.val_rtl_rl_net_sfo/ rate_currency_exchange)               AS val_rtl_rl_net_sfo_asis,  
   SUM (sfo.val_wrtoff_zero_net/ rate_currency_exchange)              AS val_wrtoff_zero_net_asis  
   FROM p_lew_core_ac.v_wawi_agg_store_day_sfo AS sfo 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate  AS cry  
   ON sfo.client_id = cry.client_id 
   AND CURRENT_DATE  BETWEEN cry.dat_rec_start AND cry.dat_rec_end   
   INNER JOIN  
   (  
     SELECT 
        calday.dat_calendar,  
   calday.cy_week 
       FROM p_lew_mart_msi.v_cal_calendarday AS calday   
   
   JOIN p_lew_mart_msi.v_cal_busyear byr  
   ON calday.byr = byr.byr 
   
   WHERE cy_by_sequence BETWEEN -3 AND 0  
 ) a13   
   ON sfo.dat_formdate = a13.dat_calendar 
   AND sfo.sfotype_id IN (137,147)  
   
 GROUP BY   
    sfo.client_id 
   ,sfo.st_loc_sid   
   ,sfo.dat_formdate 
   ,cry.currency_iso_cd 
) sfo 
   RIGHT JOIN  
   (  
     SELECT 
        a12.client_id,  
   a12.store_id,  
   a13.dat_calendar, 
   cry.currency_iso_cd, 
   ums.sales_gross_val / rate_currency_exchange AS val_retail_asis,  
   ums.cnt_customer AS cnt_customer_asis, 
   cal.prev_cy_dat_calendar_samewday,  
   cal.prev_cy_dat_calendar,  
   CASE WHEN a13.dat_calendar <= COALESCE(cal.prev_cy_dat_calendar_samewday, COALESCE(cal.dat_calendar - 364 , '9999-12-31')) OR a14.move_fg =1 THEN ums.sales_gross_val / rate_currency_exchange ELSE NULL END val_retail_asis_py_sw, 
   CASE WHEN a13.dat_calendar <= COALESCE(cal.prev_cy_dat_calendar_samewday, COALESCE(cal.dat_calendar - 364 , '9999-12-31')) OR a14.move_fg =1 THEN ums.cnt_customer ELSE NULL END cnt_customer_asis_py_sw,   
   CASE WHEN a13.dat_calendar <= COALESCE(cal.prev_cy_dat_calendar, COALESCE(ADD_MONTHS(cal.dat_calendar , -12) , '9999-12-31')) OR a14.move_fg =1 THEN ums.sales_gross_val / rate_currency_exchange ELSE NULL END val_retail_asis_py_sd, 
   CASE WHEN a13.dat_calendar <= COALESCE(cal.prev_cy_dat_calendar, COALESCE(ADD_MONTHS(cal.dat_calendar , -12) , '9999-12-31')) OR a14.move_fg =1 THEN ums.cnt_customer ELSE NULL END cnt_customer_asis_py_sd,   
   CASE WHEN a13.dat_calendar <= a12.dat_closing_ovis OR a12.dat_closing_ovis IS NULL THEN sales_gross_val / rate_currency_exchange      ELSE NULL END val_retail_asis_adj,   
   CASE WHEN a13.dat_calendar <= a12.dat_closing_ovis OR a12.dat_closing_ovis IS NULL THEN ums.cnt_customer ELSE NULL END cnt_customer_asis_adj,   
   CASE WHEN ( 
                    (a13.dat_calendar >=  a12.dat_opening_ovis  AND a13.dat_calendar <= a12.dat_closing_ovis)  
                    OR  
                    (a13.dat_calendar >=  a12.dat_opening_ovis  AND a12.dat_closing_ovis IS NULL)  
                  )  
                  AND ums.sales_gross_val > 0.0 
             THEN 1  
             ELSE 0  
        END AS cnt_store_open_rev,  
   ums.sales_net_val / rate_currency_exchange AS val_retail_net_asis,   
   CASE WHEN a13.dat_calendar <= a12.dat_closing_ovis OR a12.dat_closing_ovis IS NULL THEN ums.sales_net_val / rate_currency_exchange ELSE NULL END val_retail_net_asis_adj,  
   CASE WHEN a13.dat_calendar <= COALESCE(cal.prev_cy_dat_calendar, COALESCE(ADD_MONTHS(cal.dat_calendar , -12) , '9999-12-31')) OR a14.move_fg =1 THEN ums.sales_net_val / rate_currency_exchange ELSE NULL END val_retail_net_asis_py_sd,  
   CASE WHEN a13.dat_calendar <= COALESCE(cal.prev_cy_dat_calendar_samewday, COALESCE(cal.dat_calendar - 364 , '9999-12-31')) OR a14.move_fg =1 THEN ums.sales_net_val / rate_currency_exchange ELSE NULL END val_retail_net_asis_py_sw   
   FROM p_lew_mart_msi.v_org_store AS a12 
   LEFT JOIN p_lew_mart_msi.v_cal_calendarday AS cal  
   ON dat_calc_end_py = cal.dat_calendar  
   INNER JOIN p_lew_mart_msi.v_org_all_store_reloc AS a14   
   ON a12.store_id  = a14.store_id  
   AND a12.client_id = a14.client_id   
   CROSS JOIN  
   (  
     SELECT 
        calday.dat_calendar,  
   calday.cy_week 
       FROM p_lew_mart_msi.v_cal_calendarday AS calday   
   INNER JOIN p_lew_mart_msi.v_cal_busyear AS byr  
   ON calday.byr = byr.byr 
   
   WHERE cy_by_sequence BETWEEN -3 AND 0  
     AND calday.cy_day_sequence <=-0   
 ) a13   
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate  AS cry  
   ON a12.client_id = cry.client_id 
   AND CURRENT_DATE  BETWEEN cry.dat_rec_start AND cry.dat_rec_end   
   LEFT OUTER JOIN p_lew_bil_ac.v_agg_pos_txj_wawi_store_day AS ums  
   ON ums.client_id = a12.client_id 
   AND ums.loc_sid = a12.store_id   
   AND ums.dwh_cal_dt = a13.dat_calendar  
   
) ejr 
   ON sfo.client_id = ejr.client_id 
   AND sfo.store_id = ejr.store_id  
   AND sfo.dat_formdate = ejr.dat_calendar   
   AND sfo.currency_iso_cd_asis = ejr.currency_iso_cd 
;
