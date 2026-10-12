
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SFO_EJR_DAY_JOIN_WH 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT 
      ejr.client_id,  
   ejr.wh_id, 
   ejr.dat_calendar,  
   ejr.currency_iso_cd, 
   sfo.abswh, 
   sfo.BNL, 
   ejr.val_retail_asis, 
   ejr.val_retail_net_asis  
   FROM 
   (  
     SELECT 
        sfo.client_id,  
   wh.src_wh_id AS wh_id, 
   sfo.dat_formdate,  
   sfo.currency_iso_cd, 
   SUM(CASE WHEN sfotype_id IN (181,182,191,192) THEN val_rtl_rcptline_sfo_asis ELSE NULL END ) AS abswh, 
   SUM  
       (  
         CASE WHEN sfotype_id IN (131, 141) AND CAST(src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 199  
             THEN qty_total_sfo_asis * (price_str_sfo_asis - price_wh_sfo_asis) 
             ELSE NULL  
         END  
       ) AS BNL 
     FROM 
     (  
       SELECT 
          agg.client_id,  
   agg.st_loc_sid,  
   agg.item_sid,  
   agg.dat_formdate,  
   agg.sfotype_id,  
   agg.val_rtl_rl_sfo / cry.rate_currency_exchange AS val_rtl_rcptline_sfo_asis,  
   agg.qty_total_sfo AS qty_total_sfo_asis, 
   cry.currency_iso_cd, 
   (ABS(CAST(agg.val_total_str_sfo AS NUMBER(38,5)) / CASE WHEN agg.qty_total_sfo = 0 THEN NULL ELSE agg.qty_total_sfo END)) / cry.rate_currency_exchange AS price_str_sfo_asis,  
   (ABS(CAST(agg.val_total_wh_sfo  AS NUMBER(38,5)) / CASE WHEN agg.qty_total_sfo = 0 THEN NULL ELSE agg.qty_total_sfo END)) / cry.rate_currency_exchange AS price_wh_sfo_asis  
   FROM p_lew_core_ac.v_wawi_agg_store_day_item_sfo AS agg  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry  
   ON agg.client_id = cry.client_id 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
  
 WHERE agg.sfotype_id IN (181,182,191,192,131,141)  
) sfo 
   INNER JOIN p_lew_core_ac.v_wawi_org_store_skey_act AS os 
   ON sfo.client_id = os.client_id  
   AND sfo.st_loc_sid = os.st_loc_sid -- MSI Layer Store_id entspricht loc_sid  
  
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh  
   ON os.client_id = wh.client_id 
   AND os.wh_loc_sid = wh.loc_sid_wh  
   AND wh.dwh_actual_fg = 1 
   INNER JOIN p_lew_bil_ac.v_item AS itm  
   ON sfo.client_id = itm.client_id 
   AND sfo.item_sid = itm.item_sid  
   AND itm.dwh_actual_fg = 1  
   INNER JOIN p_lew_core_ac.v_subitemgroup AS sub 
   ON itm.client_id = sub.client_id 
   AND itm.sub_item_grp_sid_asis = sub.sub_item_grp_sid 
   INNER JOIN 
   (  
     SELECT 
        calday.dat_calendar,  
   calday.cy_week 
       FROM p_lew_mart_msi.v_cal_calendarday AS calday  
   INNER JOIN p_lew_mart_msi.v_cal_busyear AS byr 
   ON calday.byr = byr.byr  
  
   WHERE cy_by_sequence BETWEEN -3 AND 0  
 ) a13  
   ON sfo.dat_formdate = a13.dat_calendar 
  
   GROUP BY 
      sfo.client_id 
     ,wh_id 
     ,sfo.dat_formdate  
     ,sfo.currency_iso_cd 
 ) sfo  
   RIGHT JOIN 
   (  
     SELECT 
        a12.client_id,  
   os.wh_id,  
   a13.dat_calendar,  
   cry.currency_iso_cd, 
   SUM(ums.sales_gross_val / rate_currency_exchange) AS val_retail_asis,  
   SUM(ums.sales_net_val / rate_currency_exchange) AS val_retail_net_asis 
   FROM p_lew_mart_msi.v_org_store AS a12 
   INNER JOIN p_lew_mart_msi.v_org_store_skey AS os 
   ON a12.client_id = os.client_id  
   AND a12.store_id = os.store_id 
   LEFT OUTER JOIN p_lew_mart_msi.v_cal_calendarday AS cal  
   ON dat_calc_end_py = cal.dat_calendar  
   INNER JOIN p_lew_mart_msi.v_org_all_store_reloc AS a14 
   ON a12.client_id = a14.client_id 
   AND a12.store_id = a14.store_id  
   CROSS JOIN 
   (  
     SELECT 
        calday.dat_calendar,  
   calday.cy_week 
       FROM p_lew_mart_msi.v_cal_calendarday AS calday  
   INNER JOIN p_lew_mart_msi.v_cal_busyear AS byr 
   ON calday.byr = byr.byr  
  
   WHERE byr.cy_by_sequence BETWEEN -3 AND 0  
     AND calday.cy_day_sequence <=-0  
 ) a13  
  
 JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate  AS cry 
   ON a12.client_id = cry.client_id 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
   LEFT JOIN p_lew_bil_ac.v_agg_pos_txj_wawi_store_day AS ums 
   ON ums.client_id = a12.client_id 
   AND ums.loc_sid = a12.store_id 
   AND ums.dwh_cal_dt = a13.dat_calendar  
  
 GROUP BY 
    a12.client_id 
   ,os.wh_id  
   ,a13.dat_calendar  
   ,cry.currency_iso_cd 
) ejr 
   ON sfo.client_id = ejr.client_id 
   AND sfo.wh_id = ejr.wh_id  
   AND sfo.dat_formdate = ejr.dat_calendar  
   AND sfo.currency_iso_cd = ejr.currency_iso_cd  
;
