
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STORE_DAY_BER_PPYM_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT 
      ejr_txj.client_id                                                  AS client_id,  
   ejr_txj.loc_sid                                                    AS store_id,  
   cur.curr_cd_from                                                   AS currency_iso_cd, 
   cal_month_ber.dat_calendar_amd                                     AS dat_formdate,  
   CAST(ejr_txj.sales_gross_val / cur.exchange_rate AS DECIMAL(18,4)) AS val_retail_asis_ber, 
   ejr_txj.sales_net_val / cur.exchange_rate                          AS val_retail_net_asis_ber, 
   ejr_txj.cnt_customer                                               AS cnt_customer_asis_ber  
   FROM p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_2 AS ejr_txj  
   INNER JOIN p_lew_mart_msi.v_report_fixed_exchange_rate_2 AS cur  
   ON ejr_txj.client_id = cur.client_id 
   AND CURRENT_DATE BETWEEN cur.active_from_dt AND cur.active_to_dt 
   INNER JOIN 
   (  
     SELECT 
        dd.cal_dt AS dat_calendar_amd -- aktueller Kalendertag  
   ,  
   pd.cal_dt AS dat_calendar_pmd -- dazugehöriger Kalendertag des Vormonats 
   ,  
   CASE WHEN (ppy.cal_dt IS NULL AND pd.cal_dt IS NULL) 
             THEN Add_Months(dd.cal_dt, -24)  
             ELSE ppy.cal_dt  
        END AS dat_calendar_ppy -- dazugehörige Kalendertag im Vorvorjahr 
     FROM p_lew_core_ac.v_cal_month_2 AS mm_2 
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS dd 
   ON mm.cy_month = dd.cy_month 
   LEFT OUTER JOIN p_lew_core_ac.v_cal_calendarday_2 AS pd_2  
   ON mm.cy_month_prev_1m = pd.cy_month 
   AND dd.cal_dt = Add_Months(pd.cal_dt, 1) 
   LEFT OUTER JOIN p_lew_core_ac.v_cal_calendarday_2 ppy  
   ON mm.cy_month = ppy.cy_month + 200  
   AND dd.cal_dt = Add_Months(ppy.cal_dt, 24) 
   AND pd.cal_dt = Add_Months(ppy.cal_dt, 23) 
  
 WHERE dd.cal_dt IS NOT NULL  
   AND dd.cal_dt >= CAST('2005-01-01' AS VARCHAR) 
) cal_month_ber 
   ON ejr_txj.dwh_cal_dt = cal_month_ber.dat_calendar_ppy 
   INNER JOIN p_lew_core_ac.v_wawi_org_all_store_reloc_act_2 AS oasr  
   ON ejr_txj.client_id = oasr.client_id  
   AND ejr_txj.loc_sid = oasr.st_loc_sid  
   INNER JOIN p_lew_core_ac.v_wawi_org_store_act_2 AS  os 
   ON ejr_txj.client_id = os.client_id  
   AND ejr_txj.loc_sid = os.st_loc_sid  
  
 WHERE  
   (  
     (cal_month_ber.dat_calendar_amd BETWEEN os.dat_calc_start_ppy AND Add_Months(os.dat_calc_end_py, 12))  
     OR (cal_month_ber.dat_calendar_amd >= os.dat_calc_start_ppy AND oasr.move_fg = 1)  
     OR (cal_month_ber.dat_calendar_amd >= os.dat_calc_start_ppy AND os.dat_calc_end_py IS NULL)  
   )  
   AND os.test_store_fg = 0 
   AND CURRENT_DATE >= os.dat_opening 
;
