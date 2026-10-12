CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_ITEM_STORE_WEEK_1 COMMENT = 'Counts the missing items per store/week'
(
  client_id                      COMMENT 'MIS Client ID'
, loc_sid_wh                     COMMENT 'S-Key der Gesellschaft'
, move_to_store_id               COMMENT 'S-Key der Location_1, hier der Filiale'
, wh_id                          COMMENT 'Gesellschaft ID'
, orig_store_nr                  COMMENT 'Store ID'
, aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                    COMMENT 'Interner Währungs-Code'
, day_cnt                        COMMENT 'Anzahl der Tage in dem den Store auf hat'
, cy_week                        COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear                        COMMENT 'Geschäftsjahr'
, miss_item_cnt                  COMMENT 'Anzahl der Fehlartikeln für die ganze Woche_1'
, skipped_cnt                    COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_avg_day          COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_1'
, day_cnt_vj                     COMMENT 'Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'
, cy_week_vj                     COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM" - Vorjahr'
, busyear_vj                     COMMENT 'Geschäftsjahr - Vorjahr'
, miss_item_cnt_vj               COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, skipped_cnt_vj                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_avg_day_vj       COMMENT 'Durchschnittliche Fehlartikeltageswert/Tag_1 aus dem Vorjahr'
, miss_item_cnt_diff             COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff         COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'
, miss_item_avg_day_diff_delta   COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'

)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/calendar_1 week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------
*/
SELECT   client_id
       , loc_sid_wh
       , move_to_store_id
       , wh_id
       , orig_store_nr
       , aspect_id
       , currency_iso_cd
       , curr_tot_id
       , day_cnt
       , cy_week
       , busyear
       , miss_item_cnt
       , skipped_cnt
       , CASE WHEN day_cnt > 0 THEN (miss_item_cnt / day_cnt) ELSE 0 END AS miss_item_cnt_avg_day
       , day_cnt_vj
       , cy_week_vj
       , busyear_vj
       , miss_item_cnt_vj
       , skipped_cnt_vj
       , CASE WHEN day_cnt_vj > 0 THEN (miss_item_cnt_vj / day_cnt_vj) ELSE 0 END AS miss_item_cnt_avg_day_vj
       , (miss_item_cnt - miss_item_cnt_vj)  AS miss_item_cnt_diff
       , (miss_item_cnt_avg_day - miss_item_cnt_avg_day_vj) AS miss_item_avg_day_diff
       , CASE WHEN miss_item_cnt_avg_day_vj > 0 THEN (miss_item_avg_day_diff / miss_item_cnt_avg_day_vj * 100 ) ELSE 0 END AS miss_item_avg_day_diff_delta

  FROM (
         SELECT DISTINCT client_id
                 , loc_sid_wh
                 , move_to_store_id
                 , wh_id
                 , orig_store_nr
                 , aspect_id
                 , currency_iso_cd
                 , curr_tot_id
                 , SUM(skipped_fg)                                 OVER (PARTITION BY client_id, loc_sid_wh, move_to_store_id, wh_id, orig_store_nr, aspect_id, cy_week, busyear)    AS skipped_cnt
                 , SUM(CASE WHEN skipped_fg = 0 AND miss_item_cnt IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, loc_sid_wh, move_to_store_id, wh_id, orig_store_nr, aspect_id, cy_week, busyear) AS day_cnt
                 , cy_week
                 , busyear
                 , SUM(CASE WHEN skipped_fg = 0 THEN miss_item_cnt ELSE 0 END) OVER (PARTITION BY client_id, loc_sid_wh, move_to_store_id, wh_id, orig_store_nr, aspect_id, cy_week, busyear) AS miss_item_cnt
                 , SUM(CASE WHEN skipped_fg_vj_dat = 0 AND miss_item_cnt_vj_dat IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, loc_sid_wh, move_to_store_id, wh_id, orig_store_nr, aspect_id, cy_week_vj_dat, busyear_vj_dat) AS day_cnt_vj
                 , SUM(skipped_fg_vj_dat) OVER (PARTITION BY client_id, loc_sid_wh, move_to_store_id, wh_id, orig_store_nr, aspect_id, cy_week_vj_dat, busyear_vj_dat)  AS skipped_cnt_vj
                 , cy_week_vj_dat AS cy_week_vj
                 , busyear_vj_dat AS busyear_vj
                 , SUM(CASE WHEN skipped_fg_vj_dat = 0 THEN miss_item_cnt_vj_dat ELSE 0 END) OVER (PARTITION BY client_id, loc_sid_wh, move_to_store_id, wh_id, orig_store_nr, aspect_id, cy_week_vj_dat, busyear_vj_dat) AS miss_item_cnt_vj

           FROM P_LEW_MART_LEAD.v_agg_miss_item_store_day_1
        )           AS w
;