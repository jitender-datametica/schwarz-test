
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PTM_EJR_DAY_JOIN_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart#  
   #$Revision: 8128 $, $LastChangedBy: hwieber $  
   #SubjectAreas#: Arbeitszeiterfassung 
   #DescEnd#  
   */ 
   SELECT 
      ejr.client_id                               AS client_id, 
   ejr.store_id                                AS store_id, 
   ejr.dat_calendar                            AS dat_calendar, 
   ejr.currency_iso_cd                         AS currency_iso_cd,  
   working_time_brutto_std                     AS working_time_brutto_std,  
   break_std                                   AS break_std,  
   time_working_netto_std                      AS time_working_netto_std, 
   CAST(val_retail_asis AS DECIMAL (19,5))     AS val_retail_asis,  
   CAST(val_retail_net_asis AS DECIMAL (19,5)) AS val_retail_net_asis 
   FROM 
   (  
     SELECT 
        ptm.client_id,  
   ptm.store_id,  
   ptm.dat_working, 
   SUM (working_time_brutto_std) AS working_time_brutto_std,  
   SUM (break_std              ) AS break_std,  
   SUM (time_working_netto_std ) AS time_working_netto_std  
     FROM p_lew_mart_msi.v_ptm_working_time_store_1 AS ptm  
   INNER JOIN 
   (  
     SELECT 
        calday.cal_dt,  
   calday.cy_week 
       FROM p_lew_core_ac.v_cal_calendarday_1 AS calday 
  
   JOIN p_lew_core_ac.v_cal_busyear_1 AS byr  
   ON calday.busyear = byr.busyear  
  
   WHERE cy_by_seq BETWEEN -3 AND 0 
 ) a13  
   ON ptm.dat_working = a13.cal_dt  
  
   GROUP BY 
      ptm.client_id 
     ,ptm.store_id  
     ,ptm.dat_working 
 ) AS ptm 
   RIGHT OUTER JOIN 
   (  
     SELECT 
        oss.client_id,  
   oss.st_loc_sid  AS store_id, 
   cal.cal_dt      AS dat_calendar, 
   cry.currency_iso_cd, 
   agg.val_retail_asis, 
   agg.val_retail_net_asis  
     FROM p_lew_core_ac.v_wawi_org_store_skey_act_1 AS oss  
   CROSS JOIN 
   (  
     SELECT 
        cal.cal_dt, 
   cal.cy_week  
       FROM p_lew_core_ac.v_cal_calendarday_1 AS cal  
   INNER JOIN p_lew_core_ac.v_cal_busyear_1 AS byr  
   ON cal.busyear = byr.busyear 
  
   WHERE cy_by_seq BETWEEN -3 AND 0 
 ) AS cal 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry  
   ON oss.client_id = cry.client_id 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start 
   AND cry.dat_rec_end  
   LEFT OUTER JOIN  
   (  
     SELECT 
        agg.client_id,  
   agg.dwh_cal_dt,  
   agg.loc_sid, 
   sales_gross_val / rate_currency_exchange               AS val_retail_asis, 
   sales_net_val / rate_currency_exchange                 AS val_retail_net_asis, 
   cry.currency_iso_cd  
       FROM p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_1 AS agg  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1  AS cry 
   ON agg.client_id = cry.client_id 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start 
   AND cry.dat_rec_end  
) AS agg  
   ON oss.client_id = agg.client_id 
   AND oss.st_loc_sid = agg.loc_sid 
   AND cal.cal_dt = agg.dwh_cal_dt  
   AND agg.currency_iso_cd = cry.currency_iso_cd  
) AS ejr  
   ON ptm.client_id = ejr.client_id 
   AND ptm.store_id = ejr.store_id  
   AND ptm.dat_working = ejr.dat_calendar 
;
