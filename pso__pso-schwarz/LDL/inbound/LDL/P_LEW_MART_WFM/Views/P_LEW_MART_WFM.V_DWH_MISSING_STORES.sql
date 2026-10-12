CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_DWH_MISSING_STORES
/*
#DescStart#
#$Revision: 8058 $, $LastChangedBy: mdavis $
#SubjectAreas#:
#DescEnd#
*/
(
     country_lidl_cd
,          dat_formdate
,          orig_store_nr
)
AS
   (
        SELECT      Cntry.src_country_lidl_cd    AS country_lidl_cd,
   Ms.dat_formdate              AS dat_formdate,
   Ms.orig_store_nr             AS orig_store_nr

FROM         (
          SELECT      Msl.client_id        AS client_id,
   Msl.dat_formdate     AS dat_formdate,
   Msl.wh_id            AS wh_id,
   Msl.orig_store_nr    AS orig_store_nr
FROM         (--  list the stores and dates, when store had sales in last 6 days
          SELECT      Ejr.client_id              AS client_id,
   Ejr.dwh_cal_dt           AS dat_formdate,
   St2Wh.src_wh_id            AS wh_id,
   St2Wh.src_orig_store_nr    AS orig_store_nr,
   Ejr.loc_sid_store             AS loc_sid_store

FROM p_lew_bil_ac.v_agg_pos_store_item_day        AS Ejr
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown        AS St2Wh
   ON
   Ejr.client_id        =    St2Wh.client_id
  AND
   Ejr.loc_sid_store    =    St2Wh.loc_sid_store

   JOIN p_lew_core_ac.v_cal_calendarday                    AS Cal
   ON
   Ejr.dwh_cal_dt = Cal.cal_dt

WHERE        Cal.cal_dt BETWEEN Current_Date - 6 AND Current_Date  - 1
  AND
   Ejr.sales_net_val <> 0
  AND
   Ejr.sales_net_val IS NOT NULL
GROUP BY    1,2,3,4,5
)        AS Agg
   RIGHT OUTER JOIN
   (--  list the stores and dates, stores opened in last 6 days
        SELECT      Msl.client_id              AS client_id,
   Msl.dat_open               AS dat_formdate,
   St2Wh.src_wh_id            AS wh_id,
   St2Wh.src_orig_store_nr    AS orig_store_nr,
   Msl.loc_sid_store          AS loc_sid_store

FROM p_lew_bil_ac.v_sys_md_storelist                    AS Msl
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown        AS St2Wh
   ON
   Msl.client_id        =    St2Wh.client_id
  AND
   Msl.loc_sid_store    =    St2Wh.loc_sid_store
  AND
   Msl.loc_sid_wh       =    St2Wh.loc_sid_wh
   INNER JOIN p_lew_core_ac.v_cal_calendarday                    AS Cal
   ON
   Msl.dat_open = Cal.cal_dt

WHERE       Msl.dat_open BETWEEN Current_Date - 6 AND Current_Date  - 1
GROUP BY    1,2,3,4,5
)        AS Msl
   ON
   Msl.client_id        =    Agg.client_id
  AND
   Msl.loc_sid_store    =    Agg.loc_sid_store
  AND
   Msl.dat_formdate     =    Agg.dat_formdate

--                                       store was opened, but there was no sales
WHERE       Agg.client_id IS NULL
)                              AS Ms
   INNER JOIN p_lew_core_ac.v_country        AS Cntry
   ON
   Ms.client_id = Cntry.country_sid
)
;