CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_ITEM_WH_PARTIAL_WEEK_2 COMMENT = 'Anzahl der Fehlartikel pro Gesellschaft/Teilwoche'
(
  client_id                      COMMENT 'MIS Client ID'
, loc_sid_wh                     COMMENT 'S-Key der Gesellschaft'
, wh_id                          COMMENT 'Gesellschaft ID'
, aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, cy_weeK_partial_week_id        COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                       COMMENT 'Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'
, busyear                        COMMENT 'Geschäftsjahr'
, skipped_cnt                    COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, day_cnt                        COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt                  COMMENT 'Anzahl der Filialetage'
, miss_item_cnt                  COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die Teilwoche'
, miss_item_cnt_avg_day          COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_2'
, skipped_cnt_vj                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, day_cnt_vj                     COMMENT 'Anzahl der öffenen Tage der Woche_2 aus dem Vorjahr'
, store_day_cnt_vj               COMMENT 'Anzahl der Filialetage aus dem Vorjahr'
, miss_item_cnt_vj               COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, miss_item_cnt_avg_day_vj       COMMENT 'Durchschnittliche Fehlartikeltageswert/Tag_2 aus dem Vorjahr'
, miss_item_cnt_diff             COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff         COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'
, miss_item_avg_day_diff_delta   COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/partial week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     17.08.2022      Michael Morris             Comparison with previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------
*/
SELECT   client_id
       , loc_sid_wh
       , wh_id
       , aspect_id
       , currency_iso_cd
       , curr_tot_id
       , cy_week_partial_week_id
       , cy_month
       , busyear
       , skipped_cnt
       , day_cnt
       , store_day_cnt
       , miss_item_cnt
       , CASE WHEN store_day_cnt > 0 THEN (miss_item_cnt / store_day_cnt) ELSE 0 END AS miss_item_cnt_avg_day
       , skipped_cnt_vj
       , day_cnt_vj
       , store_day_cnt_vj
       , miss_item_cnt_vj
       , CASE WHEN store_day_cnt_vj > 0 THEN (miss_item_cnt_vj / store_day_cnt_vj) ELSE 0 END                              AS miss_item_cnt_avg_day_vj
       , (miss_item_cnt         - miss_item_cnt_vj)                                                                        AS miss_item_cnt_diff
       , (miss_item_cnt_avg_day - miss_item_cnt_avg_day_vj)                                                                AS miss_item_avg_day_diff
       , CASE WHEN miss_item_cnt_avg_day_vj > 0 THEN (miss_item_avg_day_diff / miss_item_cnt_avg_day_vj * 100 ) ELSE 0 END AS miss_item_avg_day_diff_delta

  FROM (
        SELECT DISTINCT client_id
                , loc_sid_wh
                , wh_id
                , aspect_id
                , currency_iso_cd
                , curr_tot_id
                , cy_week_partial_week_id
                , cy_month
                , busyear
                , SUM(skipped_cnt)            OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week_partial_week_id) AS skipped_cnt
                , MAX(day_cnt)                OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week_partial_week_id) AS day_cnt
                , SUM(day_cnt)                OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week_partial_week_id) AS store_day_cnt
                , SUM(miss_item_cnt)          OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week_partial_week_id) AS miss_item_cnt

                , SUM(skipped_cnt_vj)         OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week_partial_week_id) AS skipped_cnt_vj
                , MAX(day_cnt_vj)             OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week_partial_week_id) AS day_cnt_vj
                , SUM(day_cnt_vj)             OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week_partial_week_id) AS store_day_cnt_vj
                , SUM(miss_item_cnt_vj)       OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_week_partial_week_id) AS miss_item_cnt_vj

          FROM P_LEW_MART_LEAD.v_agg_miss_item_store_partial_week_2
        ) AS ww
;