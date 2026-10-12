/* #-----------------------------------------------------------------------------
# Description:
# This view provides an-aggregated list of missing items with the granularity of store/article family group/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Version
#  1.1     19.09.2022      Michael Morris             Vorjahes Logik hinzugefügt
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#  1.3     01.12.2022      Michael Morris             Optimized Structures
#  1.4     09.12.2022      Michael Morris             Vorjahr CALC und DAT hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_sig_store_day_1 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location_1, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'),
sub_item_grp_sid OPTIONS(description='S-Key für Unterwarengruppe'), item_fam_grp_sid
OPTIONS(description='S-Key der Artikelfamiliengruppe'), itemgroup_int_id OPTIONS(description='Warengruppe ID'),
subitemgroup_id OPTIONS(description='Unterwarengruppe ID'), item_familygroup_id OPTIONS(description='Artikelfamilie ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
dat_formdate OPTIONS(description='Bezugsdatum'), day_of_week OPTIONS(description='Tag_1 der Woche_1'), cy_month
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM"'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_week
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikel'), skipped_fg
OPTIONS(description='0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value aus P_LEW_MART_LEAD.T_VT_REF_PARAMETER mit p_id = 1'),
cal_dt_vj_cal OPTIONS(description='Datum des Vorjahres (gleiche Wochentag)'), cy_week_vj_cal
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM" - von Vorjahr'), cy_month_vj_cal
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'), busyear_vj_cal
OPTIONS(description='Geschäftsjahr - von Vorjahr'), miss_item_cnt_vj_cal
OPTIONS(description='Anzahl der Fehlartikel vom Vorjahr'), skipped_fg_vj_cal
OPTIONS(description='0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt_vj > p_value aus P_LEW_MART_LEAD.T_VT_REF_PARAMETER mit p_id = 1'),
miss_item_cnt_diff_cal
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_cnt_diff_delta_cal
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'),
cal_dt_vj_dat OPTIONS(description='Datum des Vorjahres'), cy_week_vj_dat
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM" - von Vorjahr'), cy_month_vj_dat
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'), busyear_vj_dat
OPTIONS(description='Geschäftsjahr - von Vorjahr'), miss_item_cnt_vj_dat
OPTIONS(description='Anzahl der Fehlartikel vom Vorjahr'), skipped_fg_vj_dat
OPTIONS(description='0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt_vj > p_value aus P_LEW_MART_LEAD.T_VT_REF_PARAMETER mit p_id = 1'),
miss_item_cnt_diff_dat
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_cnt_diff_delta_dat
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'))
OPTIONS(DESCRIPTION = `BASE VIEW FOR ALL ITEM_1/STORE VIEWS: COUNTS THE MISSING ITEMS PER STORE/DAY/ARTICLE FAMILY`) AS
SELECT client_id,
 loc_sid_wh,
 move_to_store_id,
 wh_id,
 orig_store_nr,
 item_grp_int_sid,
 sub_item_grp_sid,
 item_fam_grp_sid,
 itemgroup_int_id,
 subitemgroup_id,
 item_familygroup_id,
 aspect_id,
 currency_iso_cd,
 curr_tot_id,
 dat_formdate,
 day_of_week,
 cy_month,
 cy_week_partial_week_id,
 cy_week,
 busyear,
 miss_item_cnt,
 skipped_fg,
 cal_dt_vj_cal,
 cy_week_vj_cal,
 cy_month_vj_cal,
 busyear_vj_cal,
 miss_item_cnt_vj_cal,
 skipped_fg_vj_cal,
 miss_item_cnt_diff_cal,
 miss_item_cnt_diff_delta_cal,
 cal_dt_vj_dat,
 cy_week_vj_dat,
 cy_month_vj_dat,
 busyear_vj_dat,
 miss_item_cnt_vj_dat,
 skipped_fg_vj_dat,
 miss_item_cnt_diff_dat,
 miss_item_cnt_diff_delta_dat
FROM (SELECT client_id,
   loc_sid_wh,
   move_to_store_id,
   wh_id,
   orig_store_nr,
   item_grp_int_sid,
   sub_item_grp_sid,
   item_fam_grp_sid,
   itemgroup_int_id,
   subitemgroup_id,
   item_familygroup_id,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   dat_formdate,
   day_of_week,
   cy_month,
   cy_week_partial_week_id,
   cy_week,
   busyear,
   miss_item_cnt_cy AS miss_item_cnt,
   skipped_fg,
   cal_dt_vj_cal,
   cy_week_vj_cal,
   cy_month_vj_cal,
   busyear_vj_cal,
   miss_item_cnt_vj_cal,
   skipped_fg_vj_cal,
   miss_item_cnt_diff_cal,
   miss_item_cnt_diff_delta_cal,
   cal_dt_vj_dat,
   cy_week_vj_dat,
   cy_month_vj_dat,
   busyear_vj_dat,
   miss_item_cnt_vj_dat,
   skipped_fg_vj_dat,
   miss_item_cnt_diff_dat,
   miss_item_cnt_diff_delta_dat,
   miss_item_cnt_cy
  FROM (SELECT DISTINCT A.client_id,
     A.loc_sid_wh,
     A.store_id AS move_to_store_id,
     A.wh_id,
     A.orig_store_nr,
     D.item_grp_int_sid,
     D.sub_item_grp_sid,
     D.item_fam_grp_sid,
     D.itemgroup_int_id,
     D.subitemgroup_id,
     D.item_familygroup_id,
     A.aspect_id,
     D.currency_iso_cd,
     D.curr_tot_id,
     C.cal_dt AS dat_formdate,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt
       THEN D.day_of_week
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_of_week,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt
       THEN D.cy_month
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cy_month,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt
       THEN D.cy_partial_week_id
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cy_week_partial_week_id,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt
       THEN D.cy_week
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cy_week,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt
       THEN D.busyear
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS busyear,
     SUM(CASE
       WHEN D.dat_formdate = C.cal_dt
       THEN D.miss_item_cnt
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_cy,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt
       THEN D.skipped_fg
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_fg,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
       THEN D.dat_formdate
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cal_dt_vj_cal,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
       THEN D.cy_week
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cy_week_vj_cal,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
       THEN D.cy_month
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cy_month_vj_cal,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
       THEN D.busyear
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS busyear_vj_cal,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
       THEN D.skipped_fg
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_fg_vj_cal,
     SUM(CASE
       WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
       THEN D.miss_item_cnt
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_vj_cal,
       (SUM(CASE
         WHEN D.dat_formdate = C.cal_dt
         THEN D.miss_item_cnt
         ELSE NULL
         END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
          , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - (SUM(CASE
         WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
         THEN D.miss_item_cnt
         ELSE NULL
         END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
          , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS miss_item_cnt_diff_cal,
      CASE
      WHEN (SUM(CASE
          WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
          THEN D.miss_item_cnt
          ELSE NULL
          END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
           , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
      THEN ((SUM(CASE
             WHEN D.dat_formdate = C.cal_dt
             THEN D.miss_item_cnt
             ELSE NULL
             END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
              , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
            UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - (SUM(CASE
             WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
             THEN D.miss_item_cnt
             ELSE NULL
             END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
              , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
            UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) / (SUM(CASE
           WHEN D.dat_formdate = C.cal_dt_swday_prev_1y
           THEN D.miss_item_cnt
           ELSE NULL
           END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
            , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * 100
      ELSE 0
      END AS miss_item_cnt_diff_delta_cal,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_prev_1y
       THEN D.dat_formdate
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cal_dt_vj_dat,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_prev_1y
       THEN D.cy_week
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cy_week_vj_dat,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_prev_1y
       THEN D.cy_month
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cy_month_vj_dat,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_prev_1y
       THEN D.busyear
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS busyear_vj_dat,
     MAX(CASE
       WHEN D.dat_formdate = C.cal_dt_prev_1y
       THEN D.skipped_fg
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_fg_vj_dat,
     SUM(CASE
       WHEN D.dat_formdate = C.cal_dt_prev_1y
       THEN D.miss_item_cnt
       ELSE NULL
       END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
        , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_vj_dat,
       (SUM(CASE
         WHEN D.dat_formdate = C.cal_dt
         THEN D.miss_item_cnt
         ELSE NULL
         END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
          , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - (SUM(CASE
         WHEN D.dat_formdate = C.cal_dt_prev_1y
         THEN D.miss_item_cnt
         ELSE NULL
         END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
          , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS miss_item_cnt_diff_dat,
      CASE
      WHEN (SUM(CASE
          WHEN D.dat_formdate = C.cal_dt_prev_1y
          THEN D.miss_item_cnt
          ELSE NULL
          END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
           , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
      THEN ((SUM(CASE
             WHEN D.dat_formdate = C.cal_dt
             THEN D.miss_item_cnt
             ELSE NULL
             END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
              , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
            UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - (SUM(CASE
             WHEN D.dat_formdate = C.cal_dt_prev_1y
             THEN D.miss_item_cnt
             ELSE NULL
             END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
              , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
            UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) / (SUM(CASE
           WHEN D.dat_formdate = C.cal_dt_prev_1y
           THEN D.miss_item_cnt
           ELSE NULL
           END) OVER (PARTITION BY CAST(D.client_id AS STRING), CAST(A.move_to_store_id AS STRING), CAST(A.aspect_id AS STRING)
            , CAST(D.curr_tot_id AS STRING), C.cal_dt, CAST(D.item_familygroup_id AS STRING) RANGE BETWEEN
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * 100
      ELSE 0
      END AS miss_item_cnt_diff_delta_dat
    FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS C
     INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_1 AS A ON TRUE
     INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_1 AS A1 ON A.client_id = A1.client_id AND A.store_id = A1.move_to_store_id
         AND A.aspect_id = A1.aspect_id
     INNER JOIN ldl_p_lew_mart_lead.t_agg_miss_sig_store_day_1 AS D ON A.client_id = D.client_id AND A1.store_id = D.loc_sid_store
         AND D.dat_formdate IN (C.cal_dt, C.cal_dt_swday_prev_1y, C.cal_dt_prev_1y)) AS o) AS t1_1
WHERE miss_item_cnt_cy IS NOT NULL
 OR miss_item_cnt_vj_cal IS NOT NULL
 OR miss_item_cnt_vj_dat IS NOT NULL;