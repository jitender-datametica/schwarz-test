CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_STORE_OPEN_HOURS_BASE_1
AS
   /* This is the first view, which contains the Monday-Sunday data in separate columns.
      The second view will pivot the data as weekday 1 to 7 */
   SELECT
   ptm_latest_all_whs.country_lidl_cd
   , ptm_latest_all_whs.client_id
   , ptm_latest_all_whs.orig_store_nr
   , ptm_latest_all_whs.loc_sid_store
   , CAST(ptm_latest_all_whs.open_time_mo_nrm AS VARCHAR(100)) AS open_time_mo_nrm
   , CAST(ptm_latest_all_whs.open_time_tu_nrm AS VARCHAR(100)) AS open_time_tu_nrm
   , CAST(ptm_latest_all_whs.open_time_we_nrm AS VARCHAR(100)) AS open_time_we_nrm
   , CAST(ptm_latest_all_whs.open_time_th_nrm AS VARCHAR(100)) AS open_time_th_nrm
   , CAST(ptm_latest_all_whs.open_time_fr_nrm AS VARCHAR(100)) AS open_time_fr_nrm
   , CAST(ptm_latest_all_whs.open_time_sa_nrm AS VARCHAR(100)) AS open_time_sa_nrm
   , CAST(ptm_latest_all_whs.open_time_su_nrm AS VARCHAR(100)) AS open_time_su_nrm
   , ptm_latest_all_whs.open_time_mo
   , ptm_latest_all_whs.open_time_tu
   , ptm_latest_all_whs.open_time_we
   , ptm_latest_all_whs.open_time_th
   , ptm_latest_all_whs.open_time_fr
   , ptm_latest_all_whs.open_time_sa
   , ptm_latest_all_whs.open_time_su
   FROM (SELECT
   cntry.src_country_lidl_cd      AS country_lidl_cd
   , st2wh.client_id                AS client_id
   , st2wh.orig_store_nr            AS orig_store_nr
   , st2wh.loc_sid_store            AS loc_sid_store
   , Substr(REPLACE(TO_CHAR(loc_st_hst.mon_opening_tm),':',''),1,4) || Substr(REPLACE(TO_CHAR(loc_st_hst.mon_closing_tm),':',''),1,4) AS open_time_mo_nrm
   , Substr(TO_CHAR(loc_st_hst.mon_opening_tm),1,5) || '-' || Substr(TO_CHAR(loc_st_hst.mon_closing_tm),1,5) AS open_time_mo
   , Substr(REPLACE(TO_CHAR(loc_st_hst.tue_opening_tm),':',''),1,4) || Substr(REPLACE(TO_CHAR(loc_st_hst.tue_closing_tm),':',''),1,4) AS open_time_tu_nrm
   , Substr(TO_CHAR(loc_st_hst.tue_opening_tm),1,5) || '-' || Substr(TO_CHAR(loc_st_hst.tue_closing_tm),1,5) AS open_time_tu
   , Substr(REPLACE(TO_CHAR(loc_st_hst.wed_opening_tm),':',''),1,4) || Substr(REPLACE(TO_CHAR(loc_st_hst.wed_closing_tm),':',''),1,4) AS open_time_we_nrm
   , Substr(TO_CHAR(loc_st_hst.wed_opening_tm),1,5) || '-' || Substr(TO_CHAR(loc_st_hst.wed_closing_tm),1,5) AS open_time_we
   , Substr(REPLACE(TO_CHAR(loc_st_hst.thu_opening_tm),':',''),1,4) || Substr(REPLACE(TO_CHAR(loc_st_hst.thu_closing_tm),':',''),1,4) AS open_time_th_nrm
   , Substr(TO_CHAR(loc_st_hst.thu_opening_tm),1,5) || '-' || Substr(TO_CHAR(loc_st_hst.thu_closing_tm),1,5) AS open_time_th
   , Substr(REPLACE(TO_CHAR(loc_st_hst.fri_opening_tm),':',''),1,4) || Substr(REPLACE(TO_CHAR(loc_st_hst.fri_closing_tm),':',''),1,4) AS open_time_fr_nrm
   , Substr(TO_CHAR(loc_st_hst.fri_opening_tm),1,5) || '-' || Substr(TO_CHAR(loc_st_hst.fri_closing_tm),1,5) AS open_time_fr
   , Substr(REPLACE(TO_CHAR(loc_st_hst.sat_opening_tm),':',''),1,4) || Substr(REPLACE(TO_CHAR(loc_st_hst.sat_closing_tm),':',''),1,4) AS open_time_sa_nrm
   , Substr(TO_CHAR(loc_st_hst.sat_opening_tm),1,5) || '-' || Substr(TO_CHAR(loc_st_hst.sat_closing_tm),1,5) AS open_time_sa
   , Substr(REPLACE(TO_CHAR(loc_st_hst.sun_opening_tm),':',''),1,4) || Substr(REPLACE(TO_CHAR(loc_st_hst.sun_closing_tm),':',''),1,4) AS open_time_su_nrm
   , Substr(TO_CHAR(loc_st_hst.sun_opening_tm),1,5) || '-' || Substr(TO_CHAR(loc_st_hst.sun_closing_tm),1,5) AS open_time_su
   , CASE WHEN loc_wh.src_wh_id = st2wh.orig_wh_nr THEN 1 ELSE 0 END AS is_current_wh
   FROM p_lew_bil_ac.v_store_to_warehouse_1 st2wh
   INNER JOIN p_lew_core_ac.v_country_1 cntry
   ON st2wh.client_id = cntry.country_sid
   INNER JOIN p_lew_core_ac.v_location_1 loc_st
   ON st2wh.client_id = loc_st.client_id
   AND st2wh.loc_sid_store = loc_st.loc_sid
   AND loc_st.wh_store_mark = 'A'
   INNER JOIN p_lew_core_ac.v_location_hist_1 loc_st_hst
   ON loc_st.loc_sid = loc_st_hst.loc_sid
   AND loc_st_hst.deleted_fg = 0
   AND CURRENT_DATE BETWEEN loc_st_hst.dwh_valid_from AND loc_st_hst.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_location_1 loc_wh
   ON st2wh.client_id = loc_wh.client_id
   AND st2wh.loc_sid_wh = loc_wh.loc_sid
   AND loc_wh.wh_store_mark = 'B'

  /* Only select opend stores resp. stores which open in the next 14 days */
  WHERE st2wh.dwh_actual_fg = 1
   AND CURRENT_DATE + 14 > loc_st.opening_dt
   AND (loc_st_hst.test_store_fg IS NULL       /* 19.03.18 added */
    OR  loc_st_hst.test_store_fg <> 1    )     /* Exclude test_1 stores */

   /*  Exclude stores which represent a warehouse 
   AND (st2wh.client_id, st2wh.orig_store_nr) NOT IN (SELECT
   client_id, src_wh_id
   FROM p_lew_core_ac.v_location_1
           WHERE CURRENT_DATE >= opening_dt
           AND wh_store_mark = 'B'
           )*/
   /*  Exclude stores which represent a warehouse NEW */
   AND st2wh.orig_store_nr <> st2wh.orig_wh_nr
   
   AND (loc_st.closing_dt IS NULL OR CAST(loc_st.closing_dt AS DATE) > CURRENT_DATE)
   
   ) ptm_latest_all_whs
   QUALIFY 1 = ROW_NUMBER() OVER(PARTITION BY ptm_latest_all_whs.country_lidl_cd, ptm_latest_all_whs.orig_store_nr
   ORDER BY ptm_latest_all_whs.is_current_wh DESC)
;