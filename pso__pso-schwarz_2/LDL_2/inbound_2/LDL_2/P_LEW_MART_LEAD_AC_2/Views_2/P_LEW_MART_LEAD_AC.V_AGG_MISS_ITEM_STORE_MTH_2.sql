CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_ITEM_STORE_MTH_2 COMMENT = 'Counts the missing items per store/month'
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
# This view provides an aggregated list of missing items with the granularity of store/month.
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
       , cy_month
       , busyear
       , miss_item_cnt
       , skipped_cnt
       , miss_item_cnt_avg_day
       , day_cnt_vj
       , cy_month_vj
       , busyear_vj
       , miss_item_cnt_vj
       , skipped_cnt_vj
       , miss_item_cnt_avg_day_vj
       , miss_item_cnt_diff
       , miss_item_avg_day_diff
       , miss_item_avg_day_diff_delta
  FROM P_LEW_MART_LEAD.v_agg_miss_item_store_mth_2
;