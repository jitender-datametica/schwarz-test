/* This is the first view, which contains the Monday-Sunday data in separate columns.
      The second view will pivot the data as weekday 1 to 7 */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_store_open_hours_base_2 AS /* 19.03.18 added */ /* Exclude test_2 stores */
/* Exclude stores which represent a warehouse 
   AND (st2wh.client_id, st2wh.orig_store_nr) NOT IN (SELECT
   client_id, src_wh_id
   FROM LDL.p_lew_core_ac.v_location_2
           WHERE CURRENT_DATE >= opening_dt
           AND wh_store_mark = 'B'
           ) */
/* Exclude stores which represent a warehouse NEW */ SELECT t1.country_lidl_cd,
 t1.client_id,
 t1.orig_store_nr,
 t1.loc_sid_store,
 t1.open_time_mo_nrm,
 t1.open_time_tu_nrm,
 t1.open_time_we_nrm,
 t1.open_time_th_nrm,
 t1.open_time_fr_nrm,
 t1.open_time_sa_nrm,
 t1.open_time_su_nrm,
 t1.open_time_mo,
 t1.open_time_tu,
 t1.open_time_we,
 t1.open_time_th,
 t1.open_time_fr,
 t1.open_time_sa,
 t1.open_time_su
FROM (SELECT CNTRY.src_country_lidl_cd AS country_lidl_cd,
   ST2WH.client_id,
   ST2WH.orig_store_nr,
   ST2WH.loc_sid_store,
    SUBSTR(REPLACE(CAST(LOC_ST_HST.mon_opening_tm AS STRING), ':', ''), 1, 4) || SUBSTR(REPLACE(CAST(LOC_ST_HST.mon_closing_tm AS STRING)
      , ':', ''), 1, 4) AS open_time_mo_nrm,
    SUBSTR(REPLACE(CAST(LOC_ST_HST.tue_opening_tm AS STRING), ':', ''), 1, 4) || SUBSTR(REPLACE(CAST(LOC_ST_HST.tue_closing_tm AS STRING)
      , ':', ''), 1, 4) AS open_time_tu_nrm,
    SUBSTR(REPLACE(CAST(LOC_ST_HST.wed_opening_tm AS STRING), ':', ''), 1, 4) || SUBSTR(REPLACE(CAST(LOC_ST_HST.wed_closing_tm AS STRING)
      , ':', ''), 1, 4) AS open_time_we_nrm,
    SUBSTR(REPLACE(CAST(LOC_ST_HST.thu_opening_tm AS STRING), ':', ''), 1, 4) || SUBSTR(REPLACE(CAST(LOC_ST_HST.thu_closing_tm AS STRING)
      , ':', ''), 1, 4) AS open_time_th_nrm,
    SUBSTR(REPLACE(CAST(LOC_ST_HST.fri_opening_tm AS STRING), ':', ''), 1, 4) || SUBSTR(REPLACE(CAST(LOC_ST_HST.fri_closing_tm AS STRING)
      , ':', ''), 1, 4) AS open_time_fr_nrm,
    SUBSTR(REPLACE(CAST(LOC_ST_HST.sat_opening_tm AS STRING), ':', ''), 1, 4) || SUBSTR(REPLACE(CAST(LOC_ST_HST.sat_closing_tm AS STRING)
      , ':', ''), 1, 4) AS open_time_sa_nrm,
    SUBSTR(REPLACE(CAST(LOC_ST_HST.sun_opening_tm AS STRING), ':', ''), 1, 4) || SUBSTR(REPLACE(CAST(LOC_ST_HST.sun_closing_tm AS STRING)
      , ':', ''), 1, 4) AS open_time_su_nrm,
     SUBSTR(CAST(LOC_ST_HST.mon_opening_tm AS STRING), 1, 5) || '-' || SUBSTR(CAST(LOC_ST_HST.mon_closing_tm AS STRING)
     , 1, 5) AS open_time_mo,
     SUBSTR(CAST(LOC_ST_HST.tue_opening_tm AS STRING), 1, 5) || '-' || SUBSTR(CAST(LOC_ST_HST.tue_closing_tm AS STRING)
     , 1, 5) AS open_time_tu,
     SUBSTR(CAST(LOC_ST_HST.wed_opening_tm AS STRING), 1, 5) || '-' || SUBSTR(CAST(LOC_ST_HST.wed_closing_tm AS STRING)
     , 1, 5) AS open_time_we,
     SUBSTR(CAST(LOC_ST_HST.thu_opening_tm AS STRING), 1, 5) || '-' || SUBSTR(CAST(LOC_ST_HST.thu_closing_tm AS STRING)
     , 1, 5) AS open_time_th,
     SUBSTR(CAST(LOC_ST_HST.fri_opening_tm AS STRING), 1, 5) || '-' || SUBSTR(CAST(LOC_ST_HST.fri_closing_tm AS STRING)
     , 1, 5) AS open_time_fr,
     SUBSTR(CAST(LOC_ST_HST.sat_opening_tm AS STRING), 1, 5) || '-' || SUBSTR(CAST(LOC_ST_HST.sat_closing_tm AS STRING)
     , 1, 5) AS open_time_sa,
     SUBSTR(CAST(LOC_ST_HST.sun_opening_tm AS STRING), 1, 5) || '-' || SUBSTR(CAST(LOC_ST_HST.sun_closing_tm AS STRING)
     , 1, 5) AS open_time_su,
    CASE
    WHEN LOC_WH.src_wh_id = ST2WH.orig_wh_nr
    THEN 1
    ELSE 0
    END AS is_current_wh
  FROM ldl_p_lew_bil_ac.v_store_to_warehouse_2 AS ST2WH
   INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CNTRY ON ST2WH.client_id = CNTRY.country_sid
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC_ST ON ST2WH.client_id = LOC_ST.client_id AND ST2WH.loc_sid_store =
      LOC_ST.loc_sid AND LOC_ST.wh_store_mark = 'A'
   INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS LOC_ST_HST ON LOC_ST.loc_sid = LOC_ST_HST.loc_sid AND LOC_ST_HST.deleted_fg
       = 0 AND CURRENT_DATE BETWEEN LOC_ST_HST.dwh_valid_from AND LOC_ST_HST.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC_WH ON ST2WH.client_id = LOC_WH.client_id AND ST2WH.loc_sid_wh = LOC_WH
      .loc_sid AND LOC_WH.wh_store_mark = 'B' /* Only select opend stores resp. stores which open in the next 14 days */
     
  WHERE ST2WH.dwh_actual_fg = 1
   AND DATE_ADD(CURRENT_DATE, INTERVAL 14 DAY) > LOC_ST.opening_dt
   AND (LOC_ST_HST.test_store_fg IS NULL OR LOC_ST_HST.test_store_fg <> 1)
   AND ST2WH.orig_store_nr <> ST2WH.orig_wh_nr
   AND (LOC_ST.closing_dt IS NULL OR DATE(LOC_ST.closing_dt) > CURRENT_DATE)
  QUALIFY 1 = (ROW_NUMBER() OVER (PARTITION BY country_lidl_cd, CAST(ST2WH.orig_store_nr AS STRING) ORDER BY
        is_current_wh IS NULL DESC, is_current_wh DESC))) AS t1_2;