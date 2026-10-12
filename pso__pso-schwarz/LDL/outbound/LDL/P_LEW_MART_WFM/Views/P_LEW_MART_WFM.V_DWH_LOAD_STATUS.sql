/* The original SQL contained the warehouses, to which no stores belong or warehouses never open (in 2100).
Those records have always store_agg=0 AND store_mcc=0.
The new SQL just takes the warehouses which has stores. */
/* #DescStart#
#$Revision: 8056 $, $LastChangedBy: mdavis $
#SubjectAreas#:
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_dwh_load_status (country_lidl_cd, dat_formdate, ttl_store_agg, ttl_store_mcc
, wh_id) AS -- count of stores according to MCC-list

/* Below condition was removed to make it simple.
It included unnecessary warehouses.
Instead of the original conditions, add the QUALIFY clause */
/* AND
               (
                     (
                           Wh.client_id IN (3,8,9,10,12,13,15,18,19,20,22,25,26,31,32,33)
                          AND
                           Wh.opening_dt IS NOT NULL
                          AND
                           Wh.src_wh_id > 0
                          AND
                           CURRENT_DATE BETWEEN Wh.dat_rec_start AND Wh.dat_rec_end
                     )
                    OR
                     (
                           Wh.client_id IN (1,2,4,5,6,11,12,14,16,17,18,21,23,24,27,28,29)
                          AND
                           Wh.opening_dt IS NOT NULL
                          AND
                           Wh.sales_wh_fg = 1
                          AND
                           CURRENT_DATE BETWEEN Wh.dat_rec_start AND Wh.dat_rec_end
                     )
               ) */
-- Count of stores according to EJR_aggregate
 -- For the better performance, reduce the data first.

-- original condition was on gross val
 SELECT COALESCE(Msl_Agg.country_lidl_cd, Ejr_Agg.country_lidl_cd) AS
 country_lidl_cd,
 COALESCE(Msl_Agg.dat_formdate, Ejr_Agg.dat_formdate) AS dat_formdate,
 COALESCE(Ejr_Agg.store_agg, 0) AS ttl_store_agg,
 COALESCE(Msl_Agg.store_mcc, 0) AS ttl_store_mcc,
 COALESCE(Msl_Agg.wh_id, Ejr_Agg.wh_id) AS wh_id
FROM (SELECT CNTRY.src_country_lidl_cd AS country_lidl_cd,
   WH.client_id,
   WH.src_wh_id AS wh_id,
   CAL.cal_dt AS dat_formdate,
   COUNT(DISTINCT MSL.loc_sid_store) AS store_mcc
  FROM ldl_p_lew_core_ac.v_cal_calendarday AS CAL
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON TRUE
   LEFT JOIN ldl_p_lew_bil_ac.v_sys_md_storelist AS MSL ON CAL.cal_dt = MSL.dat_open AND WH.client_id = MSL.client_id
    AND WH.loc_sid_wh = MSL.loc_sid_wh
   INNER JOIN ldl_p_lew_core_ac.v_country AS CNTRY ON WH.client_id = CNTRY.country_sid
  WHERE CAL.cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
  GROUP BY country_lidl_cd,
   WH.client_id,
   wh_id,
   dat_formdate -- Keep only the warehouse which has stores

  QUALIFY (SUM(store_mcc) OVER (PARTITION BY WH.client_id, wh_id RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) > 0) AS Msl_Agg
 FULL JOIN (SELECT CNTRY0.src_country_lidl_cd AS country_lidl_cd,
   Ejr.client_id,
   Ejr.dat_formdate,
   ST2WH.src_wh_id AS wh_id,
   COUNT(DISTINCT Ejr.st_loc_sid) AS store_agg
  FROM (SELECT client_id,
     loc_sid_store AS st_loc_sid,
     dwh_cal_dt AS dat_formdate
    FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day AS SDIE
    WHERE dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
     AND sales_net_val <> 0
    GROUP BY client_id,
     st_loc_sid,
     dat_formdate) AS Ejr
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS ST2WH ON Ejr.client_id = ST2WH.client_id AND Ejr.st_loc_sid
      = ST2WH.loc_sid_store
   INNER JOIN ldl_p_lew_core_ac.v_country AS CNTRY0 ON Ejr.client_id = CNTRY0.country_sid
  GROUP BY country_lidl_cd,
   Ejr.client_id,
   Ejr.dat_formdate,
   wh_id) AS Ejr_Agg ON Msl_Agg.client_id = Ejr_Agg.client_id AND Msl_Agg.wh_id = Ejr_Agg.wh_id AND Msl_Agg.dat_formdate
    = Ejr_Agg.dat_formdate;