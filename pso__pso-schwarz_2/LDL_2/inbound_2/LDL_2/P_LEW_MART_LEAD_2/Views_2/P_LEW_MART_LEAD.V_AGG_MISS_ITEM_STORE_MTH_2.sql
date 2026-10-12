CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_ITEM_STORE_MTH_2 COMMENT = 'Counts the missing items per store/month'
(
  client_id                    COMMENT 'MIS Client ID'
, loc_sid_wh                   COMMENT 'S-Key der Gesellschaft'
, move_to_store_id             COMMENT 'S-Key der Location_2, hier der Filiale'
, wh_id                        COMMENT 'Gesellschaft ID'
, orig_store_nr                COMMENT 'Store ID'
, aspect_id                    COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd              COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                  COMMENT 'Interner Währungs-Code'
, day_cnt                      COMMENT 'Anzahl der öffenen Tage des Monats'
, cy_month                     COMMENT 'Monat_2 des Geschäftsjahres im Format "JJJJMM"'
, busyear                      COMMENT 'Geschäftsjahr'
, miss_item_cnt                COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, skipped_cnt                  COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_avg_day        COMMENT 'Durchschnittliche Fehlartikeltageswert'
, day_cnt_vj                   COMMENT 'Anzahl der öffenen Tage des Monats'
, cy_month_vj                  COMMENT 'Monat_2 des Geschäftsjahres im Format "JJJJMM"'
, busyear_vj                   COMMENT 'Geschäftsjahr'
, miss_item_cnt_vj             COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, skipped_cnt_vj               COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_avg_day_vj     COMMENT 'Durchschnittliche Fehlartikeltageswert'
, miss_item_cnt_diff           COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff       COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'
, miss_item_avg_day_diff_delta COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/month
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#  1.2     01.12.2022      Michael Morris             Optimized Structures
#
#-----------------------------------------------------------------------------
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
       , cy_month
       , busyear
       , miss_item_cnt
       , skipped_cnt
       , CASE WHEN day_cnt > 0 THEN (miss_item_cnt / day_cnt) ELSE 0 END          AS miss_item_cnt_avg_day
       , day_cnt_vj
       , cy_month_vj
       , busyear_vj
       , miss_item_cnt_vj
       , skipped_cnt_vj
       , CASE WHEN day_cnt_vj > 0 THEN (miss_item_cnt_vj / day_cnt_vj) ELSE 0 END AS miss_item_cnt_avg_day_vj
       , (miss_item_cnt - miss_item_cnt_vj)                                       AS miss_item_cnt_diff
       , (miss_item_cnt_avg_day - miss_item_cnt_avg_day_vj)                       AS miss_item_avg_day_diff
       , CASE WHEN miss_item_cnt_avg_day_vj > 0 THEN (miss_item_avg_day_diff / miss_item_cnt_avg_day_vj * 100 ) ELSE 0 END AS miss_item_avg_day_diff_delta
  FROM (
        SELECT DISTINCT   asm.client_id
                        , asm.loc_sid_wh
                        , asm.store_id          AS move_to_store_id
                        , asm.wh_id
                        , asm.orig_store_nr
                        , asm.aspect_id
                        , d1.currency_iso_cd
                        , d1.curr_tot_id
                        , cm.cy_month
                        , cm.busyear
                        , SUM(d1.day_cnt)       OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, d1.currency_iso_cd)         AS day_cnt
                        , SUM(d1.miss_item_cnt) OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, d1.currency_iso_cd)         AS miss_item_cnt
                        , SUM(d1.skipped_cnt)   OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, d1.currency_iso_cd)         AS skipped_cnt
                        , cm.cy_month_prev_1y                                                                                                           AS cy_month_vj
                        , cm.busyear -1                                                                                                                 AS busyear_vj
                        , SUM(d2.day_cnt)       OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, d1.currency_iso_cd)         AS day_cnt_vj
                        , SUM(d2.miss_item_cnt) OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, d1.currency_iso_cd)         AS miss_item_cnt_vj
                        , SUM(d2.skipped_cnt)   OVER (PARTITION BY asm.client_id, asm.store_id, cm.cy_month, asm.aspect_id, d1.currency_iso_cd)         AS skipped_cnt_vj

          FROM P_LEW_CORE_AC.v_cal_month_2                        AS cm

         INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_2        AS asm
            ON 1                        = 1

         INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_2        AS asm1
            ON asm.client_id            = asm1.client_id
           AND asm.store_id             = asm1.move_to_store_id
           AND asm.aspect_id            = asm1.aspect_id

         INNER JOIN (
                     SELECT DISTINCT   d.client_id
                                     , d.loc_sid_store
                                     , d.cy_month
                                     , d.busyear
                                     , d.currency_iso_cd
                                     , d.curr_tot_id
                                     , COUNT(DISTINCT(CASE WHEN d.miss_item_cnt IS NOT NULL AND d.skipped_fg = 0 THEN d.dat_formdate ELSE NULL END))
                                                                                                         OVER (PARTITION BY d.client_id, d.loc_sid_store, d.cy_month, d.currency_iso_cd) AS day_cnt
                                     , SUM(d.skipped_fg)                                                 OVER (PARTITION BY d.client_id, d.loc_sid_store, d.cy_month, d.currency_iso_cd) AS skipped_cnt
                                     , SUM(CASE WHEN d.skipped_fg = 0 THEN d.miss_item_cnt ELSE 0 END)   OVER (PARTITION BY d.client_id, d.loc_sid_store, d.cy_month, d.currency_iso_cd) AS miss_item_cnt
                       FROM P_LEW_MART_LEAD.t_agg_miss_itm_store_day_2  AS d
                   )                                           AS d1
            ON asm.client_id            = d1.client_id
           AND asm1.store_id            = d1.loc_sid_store
           AND cm.cy_month              = d1.cy_month

          INNER JOIN (
                     SELECT DISTINCT   d.client_id
                                     , d.loc_sid_store
                                     , d.cy_month
                                     , d.busyear
                                     , d.currency_iso_cd
                                     , d.curr_tot_id
                                     , COUNT(DISTINCT(CASE WHEN d.miss_item_cnt IS NOT NULL AND d.skipped_fg = 0 THEN d.dat_formdate ELSE NULL END))
                                                                                                         OVER (PARTITION BY d.client_id, d.loc_sid_store, d.cy_month, d.currency_iso_cd) AS day_cnt
                                     , SUM(d.skipped_fg)                                                 OVER (PARTITION BY d.client_id, d.loc_sid_store, d.cy_month, d.currency_iso_cd) AS skipped_cnt
                                     , SUM(CASE WHEN d.skipped_fg = 0 THEN d.miss_item_cnt ELSE 0 END)   OVER (PARTITION BY d.client_id, d.loc_sid_store, d.cy_month, d.currency_iso_cd) AS miss_item_cnt
                       FROM P_LEW_MART_LEAD.t_agg_miss_itm_store_day_2  AS d

                    )                                          AS d2
            ON asm.client_id            = d2.client_id
           AND asm1.store_id            = d2.loc_sid_store
           AND cm.cy_month_prev_1y      = d2.cy_month
           AND d1.currency_iso_cd       = d2.currency_iso_cd
        ) AS md
QUALIFY ( day_cnt + skipped_cnt > 0 )
;