CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_ITEM_WH_WEEK_1 COMMENT = 'Anzahl der Fehlartikel pro Gesellschaft/Woche_1'
(
  client_id                     COMMENT 'MIS Client ID'
, loc_sid_wh                    COMMENT 'S-Key der Gesellschaft'
, wh_id                         COMMENT 'Gesellschaft ID'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, cy_week                       COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear                       COMMENT 'Geschäftsjahr'
, day_cnt                       COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt                 COMMENT 'Anzahl der Filialetage'
, miss_item_cnt                 COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_1'
, skipped_cnt                   COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_avg_day         COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_1'
, cy_week_vj                    COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear_vj                    COMMENT 'Geschäftsjahr'
, day_cnt_vj                    COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt_vj              COMMENT 'Anzahl der Filialetage aus dem Vorjahr'
, miss_item_cnt_vj              COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_1 - aus dem Vorjahr'
, skipped_cnt_vj                COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_avg_day_vj      COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_1'
, miss_item_cnt_diff            COMMENT 'Anzahl der Fehlartikel (in der Woche_1) aus aktuellem Jahr minus Anzahl der Fehlartikel (in der Woche_1) aus dem Vorjahr'
, miss_item_avg_day_diff        COMMENT 'Aktuelle Durchschnittswert (Filale/Tag_1) minus Durchschnittswert (Filale/Tag_1) aus dem Vorjahr'
, miss_item_avg_day_diff_delta  COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/calendar_1 week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------
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
       , miss_item_cnt_avg_day
       , cy_week_vj
       , busyear_vj
       , day_cnt_vj
       , store_day_cnt_vj
       , miss_item_cnt_vj
       , skipped_cnt_vj
       , miss_item_cnt_avg_day_vj
       , miss_item_cnt_diff
       , miss_item_avg_day_diff
       , miss_item_avg_day_diff_delta
  FROM P_LEW_MART_LEAD.v_agg_miss_item_wh_week_1
;