CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_ITEM_WH_MTH_2 COMMENT = 'Anzahl der Fehlartikel pro Gesellschaft/Monat_2'
(
  client_id                     COMMENT 'MIS Client ID'
, loc_sid_wh                    COMMENT 'S-Key der Gesellschaft'
, wh_id                         COMMENT 'Gesellschaft ID'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, cy_month                      COMMENT 'Monat_2 des Geschäftsjahres im Format "JJJJMM"'
, busyear                       COMMENT 'Geschäftsjahr'
, day_cnt                       COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt                 COMMENT 'Anzahl der Filialetage'
, miss_item_cnt                 COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_2'
, skipped_cnt                   COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_avg_day         COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_2'
, cy_month_vj                   COMMENT 'Monat_2 des Geschäftsjahres im Format "JJJJMM" - Vorjahr'
, busyear_vj                    COMMENT 'Geschäftsjahr - Vorjahr'
, day_cnt_vj                    COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt_vj              COMMENT 'Anzahl der Filialetage aus dem Vorjahr'
, miss_item_cnt_vj              COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_2 - aus dem Vorjahr'
, skipped_cnt_vj                COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_avg_day_vj      COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_2 - aus dem Vorjahr'
, miss_item_cnt_diff            COMMENT 'Anzahl der Fehlartikel (im Monat_2) aus aktuellem Jahr minus Anzahl der Fehlartikel (im Monat_2) aus dem Vorjahr'
, miss_item_avg_day_diff        COMMENT 'Aktuelle Durchschnittswert (Filale/Tag_2) minus Durchschnittswert (Filale/Tag_2) aus dem Vorjahr'
, miss_item_avg_day_diff_delta  COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/month.
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
       , cy_month
       , busyear
       , day_cnt
       , store_day_cnt
       , miss_item_cnt
       , skipped_cnt
       , CASE WHEN store_day_cnt > 0 THEN (miss_item_cnt / store_day_cnt) ELSE 0 END          AS miss_item_cnt_avg_day
       , cy_month_vj
       , busyear_vj
       , day_cnt_vj
       , store_day_cnt_vj
       , miss_item_cnt_vj
       , skipped_cnt_vj
       , CASE WHEN store_day_cnt_vj > 0 THEN (miss_item_cnt_vj / store_day_cnt_vj) ELSE 0 END AS miss_item_cnt_avg_day_vj
       , (miss_item_cnt - miss_item_cnt_vj)                                                   AS miss_item_cnt_diff
       , (miss_item_cnt_avg_day - miss_item_cnt_avg_day_vj)                                   AS miss_item_avg_day_diff
       , CASE WHEN miss_item_cnt_avg_day_vj > 0 THEN (miss_item_avg_day_diff / miss_item_cnt_avg_day_vj * 100) ELSE 0 END AS miss_item_avg_day_diff_delta
  FROM (
        SELECT DISTINCT client_id
                , loc_sid_wh
                , wh_id
                , aspect_id
                , currency_iso_cd
                , curr_tot_id
                , cy_month
                , busyear
                , MAX(day_cnt)                OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_month) AS day_cnt
                , SUM(day_cnt)                OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_month) AS store_day_cnt
                , SUM(miss_item_cnt)          OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_month) AS miss_item_cnt
                , SUM(skipped_cnt)            OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_month) AS skipped_cnt
                , cy_month_vj
                , busyear_vj
                , MAX(day_cnt_vj)             OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_month) AS day_cnt_vj
                , SUM(day_cnt_vj)             OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_month) AS store_day_cnt_vj
                , SUM(miss_item_cnt_vj)       OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_month) AS miss_item_cnt_vj
                , SUM(skipped_cnt_vj)         OVER (PARTITION BY client_id, wh_id, aspect_id, curr_tot_id, cy_month) AS skipped_cnt_vj

          FROM P_LEW_MART_LEAD.v_agg_miss_item_store_mth_2
        ) AS ww
;