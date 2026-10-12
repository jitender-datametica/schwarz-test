CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_WGI_STORE_DAY COMMENT = 'Base view for all WGI views: Counts the missing items per Store/Day/Warengruppe'
(
  client_id                    COMMENT 'MIS Client ID'
, loc_sid_wh                   COMMENT 'S-Key der Gesellschaft'
, move_to_store_id             COMMENT 'S-Key der Location, hier der Filiale'
, wh_id                        COMMENT 'Gesellschaft ID'
, orig_store_nr                COMMENT 'Store ID'
, item_grp_int_sid             COMMENT 'S-Key für Internationale Warengruppe'
, itemgroup_int_id             COMMENT 'Warengruppe ID'
, aspect_id                    COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd              COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                  COMMENT 'Interner Währungs-Code'
, dat_formdate                 COMMENT 'Bezugsdatum'
, day_of_week                  COMMENT 'Tag der Woche'
, cy_month                     COMMENT 'Monat des Geschäftsjahres im Format "JJJJMM"'
, cy_week_partial_week_id      COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_week                      COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM"'
, busyear                      COMMENT 'Geschäftsjahr'
, miss_item_cnt                COMMENT 'Anzahl der Fehlartikel'
, skipped_fg                   COMMENT '0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value aus P_LEW_MART_LEAD.T_REF_PARAMETER_VT mit p_id = 1'
, cal_dt_vj_cal                COMMENT 'Datum des Vorjahres (gleiche Wochentag)'
, cy_week_vj_cal               COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM" - von Vorjahr'
, cy_month_vj_cal              COMMENT 'Monat des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'
, busyear_vj_cal               COMMENT 'Geschäftsjahr - von Vorjahr'
, miss_item_cnt_vj_cal         COMMENT 'Anzahl der Fehlartikel vom Vorjahr'
, skipped_fg_vj_cal            COMMENT '0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt_vj > p_value aus P_LEW_MART_LEAD.T_REF_PARAMETER_VT mit p_id = 1 aus dem Vorjahr'
, miss_item_cnt_diff_cal       COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_cnt_diff_delta_cal COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
, cal_dt_vj_dat                COMMENT 'Datum des Vorjahres'
, cy_week_vj_dat               COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM" - von Vorjahr'
, cy_month_vj_dat              COMMENT 'Monat des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'
, busyear_vj_dat               COMMENT 'Geschäftsjahr - von Vorjahr'
, miss_item_cnt_vj_dat         COMMENT 'Anzahl der Fehlartikel vom Vorjahr'
, skipped_fg_vj_dat            COMMENT '0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt_vj > p_value aus P_LEW_MART_LEAD.T_REF_PARAMETER_VT mit p_id = 1 aus dem Vorjahr'
, miss_item_cnt_diff_dat       COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_cnt_diff_delta_dat COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an-aggregated list of missing items with the granularity of store/product group/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     19.09.2022      Michael Morris             Vorjahes Logik hinzugefügt
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#  1.3     01.12.2022      Michael Morris             Optimized Structures
#  1.4     09.12.2022      Michael Morris             Vorjahr CALC und DAT hinzugefügt
#
#----------------------------------------------------------------------------
*/
SELECT   o.client_id
       , o.loc_sid_wh
       , o.move_to_store_id
       , o.wh_id
       , o.orig_store_nr
       , o.item_grp_int_sid
       , o.itemgroup_int_id
       , o.aspect_id
       , o.currency_iso_cd
       , o.curr_tot_id
       , o.dat_formdate
       , o.day_of_week
       , o.cy_month
       , o.cy_week_partial_week_id
       , o.cy_week
       , o.busyear
       , o.miss_item_cnt_cy             AS miss_item_cnt
       , o.skipped_fg
       , o.cal_dt_vj_cal
       , o.cy_week_vj_cal
       , o.cy_month_vj_cal
       , o.busyear_vj_cal
       , o.miss_item_cnt_vj_cal
       , o.skipped_fg_vj_cal
       , o.miss_item_cnt_diff_cal
       , o.miss_item_cnt_diff_delta_cal
       , o.cal_dt_vj_dat
       , o.cy_week_vj_dat
       , o.cy_month_vj_dat
       , o.busyear_vj_dat
       , o.miss_item_cnt_vj_dat
       , o.skipped_fg_vj_dat
       , o.miss_item_cnt_diff_dat
       , o.miss_item_cnt_diff_delta_dat
  FROM (
        SELECT DISTINCT a.client_id
               , a.loc_sid_wh
               , a.store_id            AS move_to_store_id
               , a.wh_id
               , a.orig_store_nr
               , d.item_grp_int_sid
               , d.itemgroup_int_id
               , a.aspect_id
               , d.currency_iso_cd
               , d.curr_tot_id
               , c.cal_dt              AS dat_formdate
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt               THEN d.day_of_week        ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS day_of_week
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt               THEN d.cy_month           ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS cy_month
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt               THEN d.cy_partial_week_id ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS cy_week_partial_week_id
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt               THEN d.cy_week            ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS cy_week
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt               THEN d.busyear            ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS busyear

               , SUM(CASE WHEN d.dat_formdate = c.cal_dt               THEN d.miss_item_cnt      ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS miss_item_cnt_cy
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt               THEN d.skipped_fg         ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS skipped_fg

               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_swday_prev_1y THEN d.dat_formdate       ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS cal_dt_vj_cal
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_swday_prev_1y THEN d.cy_week            ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS cy_week_vj_cal
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_swday_prev_1y THEN d.cy_month           ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS cy_month_vj_cal
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_swday_prev_1y THEN d.busyear            ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS busyear_vj_cal


               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_swday_prev_1y THEN d.skipped_fg         ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS skipped_fg_vj_cal
               , SUM(CASE WHEN d.dat_formdate = c.cal_dt_swday_prev_1y THEN d.miss_item_cnt      ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS miss_item_cnt_vj_cal

               , (miss_item_cnt_cy - miss_item_cnt_vj_cal)                                                                                    AS miss_item_cnt_diff_cal
               , CASE WHEN miss_item_cnt_vj_cal > 0                    THEN (miss_item_cnt_diff_cal / miss_item_cnt_vj_cal * 100 ) ELSE 0 END AS miss_item_cnt_diff_delta_cal

               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_prev_1y       THEN d.dat_formdate  ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS cal_dt_vj_dat
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_prev_1y       THEN d.cy_week       ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS cy_week_vj_dat
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_prev_1y       THEN d.cy_month      ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS cy_month_vj_dat
               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_prev_1y       THEN d.busyear       ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS busyear_vj_dat

               , MAX(CASE WHEN d.dat_formdate = c.cal_dt_prev_1y       THEN d.skipped_fg    ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS skipped_fg_vj_dat
               , SUM(CASE WHEN d.dat_formdate = c.cal_dt_prev_1y       THEN d.miss_item_cnt ELSE NULL END) OVER (PARTITION BY d.client_id, a.move_to_store_id, a.aspect_id, d.curr_tot_id, c.cal_dt, d.itemgroup_int_id) AS miss_item_cnt_vj_dat

               , (miss_item_cnt_cy - miss_item_cnt_vj_dat)                                                                                    AS miss_item_cnt_diff_dat
               , CASE WHEN miss_item_cnt_vj_dat > 0                    THEN (miss_item_cnt_diff_dat / miss_item_cnt_vj_dat * 100 ) ELSE 0 END AS miss_item_cnt_diff_delta_dat

           FROM P_LEW_CORE_AC.v_cal_calendarday           AS c

          INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge AS a
             ON 1               = 1

          INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge AS a1
             ON a.client_id     = a1.client_id
            AND a.store_id      = a1.move_to_store_id
            AND a.aspect_id     = a1.aspect_id

          INNER JOIN P_LEW_MART_LEAD.t_agg_miss_wgi_store_day  AS d
             ON a.client_id     = d.client_id
            AND a1.store_id     = d.loc_sid_store
            AND d.dat_formdate  IN (c.cal_dt, c.cal_dt_swday_prev_1y, c.cal_dt_prev_1y)
        )  AS o
QUALIFY (miss_item_cnt_cy IS NOT NULL OR miss_item_cnt_vj_cal IS NOT NULL OR miss_item_cnt_vj_dat IS NOT NULL)
;