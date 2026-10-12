/* #DescStart#
#$Revision: 8058 $, $LastChangedBy: mdavis $
#SubjectAreas#:
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_dwh_missing_stores_2 (country_lidl_cd, dat_formdate, orig_store_nr) AS
-- list the stores and dates, when store had sales_2 in last 6 days

-- list the stores and dates, stores opened in last 6 days
 SELECT CNTRY.src_country_lidl_cd AS country_lidl_cd,
 Ms.dat_formdate,
 Ms.orig_store_nr
FROM (SELECT Msl.client_id,
   Msl.dat_formdate,
   Msl.wh_id,
   Msl.orig_store_nr
  FROM (SELECT EJR.client_id,
     EJR.dwh_cal_dt AS dat_formdate,
     ST2WH.src_wh_id AS wh_id,
     ST2WH.src_orig_store_nr AS orig_store_nr,
     EJR.loc_sid_store
    FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day_2 AS EJR
     INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS ST2WH ON EJR.client_id = ST2WH.client_id AND EJR.loc_sid_store
        = ST2WH.loc_sid_store
     INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON EJR.dwh_cal_dt = CAL.cal_dt
    WHERE CAL.cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
     AND EJR.sales_net_val <> 0
    GROUP BY EJR.client_id,
     dat_formdate,
     wh_id,
     orig_store_nr,
     EJR.loc_sid_store) AS Agg
   RIGHT JOIN (SELECT MSL.client_id,
     MSL.dat_open AS dat_formdate,
     ST2WH0.src_wh_id AS wh_id,
     ST2WH0.src_orig_store_nr AS orig_store_nr,
     MSL.loc_sid_store
    FROM ldl_p_lew_bil_ac.v_sys_md_storelist_2 AS MSL
     INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS ST2WH0 ON MSL.client_id = ST2WH0.client_id AND MSL.loc_sid_store
         = ST2WH0.loc_sid_store AND MSL.loc_sid_wh = ST2WH0.loc_sid_wh
     INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL0 ON MSL.dat_open = CAL0.cal_dt
    WHERE MSL.dat_open BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY MSL.client_id,
     dat_formdate,
     wh_id,
     orig_store_nr,
     MSL.loc_sid_store) AS Msl ON Agg.client_id = Msl.client_id AND Agg.loc_sid_store = Msl.loc_sid_store AND Agg.dat_formdate
     -- store was opened, but there was no sales_2
 = Msl.dat_formdate
  WHERE Agg.client_id IS NULL) AS Ms
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CNTRY ON Ms.client_id = CNTRY.country_sid;