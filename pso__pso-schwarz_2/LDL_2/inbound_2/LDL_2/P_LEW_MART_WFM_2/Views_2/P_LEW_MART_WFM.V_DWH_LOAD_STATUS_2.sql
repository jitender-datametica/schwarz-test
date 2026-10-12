CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_DWH_LOAD_STATUS_2
/*
#DescStart#
#$Revision: 8056 $, $LastChangedBy: mdavis $
#SubjectAreas#:
#DescEnd#
*/
/*
The original SQL contained the warehouses, to which no stores belong or warehouses never open (in 2100).
Those records have always store_agg=0 AND store_mcc=0.
The new SQL just takes the warehouses which has stores.
*/
(
     country_lidl_cd
,          dat_formdate
,          ttl_store_agg
,          ttl_store_mcc
,          wh_id
)
AS
   (
        SELECT      Coalesce(Msl_Agg.country_lidl_cd, Ejr_Agg.country_lidl_cd)    AS country_lidl_cd,
   Coalesce(Msl_Agg.dat_formdate, Ejr_Agg.dat_formdate)          AS dat_formdate,
   Coalesce(Ejr_Agg.store_agg, 0)                                AS ttl_store_agg,
   Coalesce(Msl_Agg.store_mcc, 0)                                AS ttl_store_mcc,
   Coalesce(Msl_Agg.wh_id, Ejr_Agg.wh_id)                        AS wh_id
FROM
     (--  count of stores according to MCC-list
          SELECT        Cntry.src_country_lidl_cd            AS country_lidl_cd,
   Wh.client_id                         AS client_id,
   Wh.src_wh_id                         AS wh_id,
   Cal.cal_dt                           AS dat_formdate,
   Count(DISTINCT Msl.loc_sid_store)    AS store_mcc

FROM p_lew_core_ac.v_cal_calendarday_2        AS Cal
   INNER JOIN p_lew_bil_ac.v_warehouse_2               AS Wh
   ON
   1 = 1
   LEFT OUTER JOIN p_lew_bil_ac.v_sys_md_storelist_2        AS Msl
   ON
   Cal.cal_dt       =    Msl.dat_open
  AND
   Wh.client_id     =    Msl.client_id
  AND
   Wh.loc_sid_wh    =    Msl.loc_sid_wh
   INNER JOIN p_lew_core_ac.v_country_2                AS Cntry
   ON
   Wh.client_id = Cntry.country_sid

WHERE          Cal.cal_dt BETWEEN Current_Date - 6 AND Current_Date - 1

/*
Below condition was removed to make it simple.
It included unnecessary warehouses.
Instead of the original conditions, add the QUALIFY clause
*/
/*
              AND
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
               )
*/
GROUP BY      1,2,3,4

--  Keep only the warehouse which has stores
QUALIFY       Sum(store_mcc) Over (PARTITION BY wh.client_id, wh.src_wh_id) > 0

)        AS Msl_Agg
   FULL OUTER JOIN
   (--  Count of stores according to EJR_aggregate
        SELECT      Cntry.src_country_lidl_cd         AS country_lidl_cd,
   Ejr.client_id                     AS client_id,
   Ejr.dat_formdate                  AS dat_formdate,
   St2Wh.src_wh_id                   AS wh_id,
   Count(DISTINCT Ejr.st_loc_sid)    AS store_agg
FROM         (--  For the better performance, reduce the data first.
          SELECT      Sdie.client_id        AS client_id,
   Sdie.loc_sid_store    AS st_loc_sid,
   Sdie.dwh_cal_dt       AS dat_formdate
FROM p_lew_bil_ac.v_agg_pos_store_item_day_2        AS Sdie
   WHERE        Sdie.dwh_cal_dt BETWEEN Current_Date -6 AND Current_Date -1
--              original condition was on gross val
               AND
                Sdie.sales_net_val <> 0
               AND
                Sdie.sales_net_val IS NOT NULL
   GROUP BY    1,2,3
)                                                  AS Ejr
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_2        AS St2Wh
   ON
   Ejr.client_id     =    St2Wh.client_id
  AND
   Ejr.st_loc_sid    =    St2Wh.loc_sid_store
   INNER JOIN p_lew_core_ac.v_country_2                            AS Cntry
   ON
   Ejr.client_id = Cntry.country_sid

GROUP BY    1,2,3,4
)        AS Ejr_Agg
   ON
   Msl_Agg.client_id       =    Ejr_Agg.client_id
  AND
   Msl_Agg.wh_id           =    Ejr_Agg.wh_id
  AND
   Msl_Agg.dat_formdate    =    Ejr_Agg.dat_formdate
)
;