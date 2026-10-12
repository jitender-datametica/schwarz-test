CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_ITEM_WH_WEEK COMMENT = 'Anzahl der Fehlartikel pro Gesellschaft/Woche'
(
  client_id                     COMMENT 'MIS Client ID'
, loc_sid_wh                    COMMENT 'S-Key der Gesellschaft'
, wh_id                         COMMENT 'Gesellschaft ID'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, cy_week                       COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM"'
, busyear                       COMMENT 'Geschäftsjahr'
, day_cnt                       COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt                 COMMENT 'Anzahl der Filialetage'
, miss_item_cnt                 COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche'
, skipped_cnt                   COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_avg_day         COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag'
, cy_week_vj                    COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM"'
, busyear_vj                    COMMENT 'Geschäftsjahr'
, day_cnt_vj                    COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt_vj              COMMENT 'Anzahl der Filialetage aus dem Vorjahr'
, miss_item_cnt_vj              COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche - aus dem Vorjahr'
, skipped_cnt_vj                COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_avg_day_vj      COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag'
, miss_item_cnt_diff            COMMENT 'Anzahl der Fehlartikel (in der Woche) aus aktuellem Jahr minus Anzahl der Fehlartikel (in der Woche) aus dem Vorjahr'
, miss_item_avg_day_diff        COMMENT 'Aktuelle Durchschnittswert (Filale/Tag) minus Durchschnittswert (Filale/Tag) aus dem Vorjahr'
, miss_item_avg_day_diff_delta  COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/calendar week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#-----------------------------------------------------------------------------
*/
SELECT   client_id
       , loc_sid_wh
       , wh_id
       , aspect_id
       , currency_iso_cd
       , curr_tot_id
       , cy_week
       , busyear
       , day_cnt
       , store_day_cnt
       , miss_item_cnt
       , skipped_cnt
       , CASE WHEN store_day_cnt > 0 THEN (miss_item_cnt / store_day_cnt) ELSE 0 END                                      AS miss_item_cnt_avg_day
       , cy_week_vj
       , busyear_vj
       , day_cnt_vj
       , store_day_cnt_vj
       , miss_item_cnt_vj
       , skipped_cnt_vj
       , CASE WHEN store_day_cnt_vj > 0 THEN (miss_item_cnt_vj / store_day_cnt_vj) ELSE 0 END                             AS miss_item_cnt_avg_day_vj
       , (miss_item_cnt - miss_item_cnt_vj)                                                                               AS miss_item_cnt_diff
       , (miss_item_cnt_avg_day - miss_item_cnt_avg_day_vj)                                                               AS miss_item_avg_day_diff
       , CASE WHEN miss_item_cnt_avg_day_vj > 0 THEN (miss_item_avg_day_diff / miss_item_cnt_avg_day_vj * 100) ELSE 0 END AS miss_item_avg_day_diff_delta
  FROM (
        SELECT DISTINCT client_id
                , loc_sid_wh
                , wh_id
                , aspect_id
                , currency_iso_cd
                , curr_tot_id
                , cy_week
                , busyear
                , SUM(CASE WHEN miss_item_cnt IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week) AS day_cnt
                , SUM(store_cnt)              OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week) AS store_day_cnt
                , SUM(skipped_cnt)            OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week) AS skipped_cnt
                , SUM(miss_item_cnt)          OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week) AS miss_item_cnt
                , cy_week_vj
                , busyear_vj
                , SUM(CASE WHEN miss_item_cnt_vj IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week) AS day_cnt_vj
                , SUM(store_cnt_vj)           OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week) AS store_day_cnt_vj
                , SUM(skipped_cnt_vj)         OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week) AS skipped_cnt_vj
                , SUM(miss_item_cnt_vj)       OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week) AS miss_item_cnt_vj
          FROM P_LEW_MART_LEAD.v_agg_miss_item_wh_day

        ) AS ww
;