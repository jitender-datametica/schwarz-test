CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_ITEM_INT_PARTIAL_WEEK COMMENT = 'Anzahl der Fehlartikel pro Land/Teilwoche'
(
  client_id                      COMMENT 'MIS Client ID'
, aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                    COMMENT 'Interner Währungs-Code'
, cy_week_partial_week_id        COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                       COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM"'
, busyear                        COMMENT 'Geschäftsjahr'
, skipped_cnt                    COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, day_cnt                        COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt                  COMMENT 'Anzahl der Filialetage'
, miss_item_cnt                  COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die Teilwoche'
, miss_item_cnt_avg_day          COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag'
, skipped_cnt_vj                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, day_cnt_vj                     COMMENT 'Anzahl der öffenen Tage der Woche aus dem Vorjahr'
, store_day_cnt_vj               COMMENT 'Anzahl der Filialetage aus dem Vorjahr'
, miss_item_cnt_vj               COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, miss_item_cnt_avg_day_vj       COMMENT 'Durchschnittliche Fehlartikeltageswert/Tag aus dem Vorjahr'
, miss_item_cnt_diff             COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff         COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'
, miss_item_avg_day_diff_delta   COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     17.08.2022      Michael Morris             Comparison with previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------
*/
SELECT   client_id
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
       , miss_item_cnt_avg_day
       , skipped_cnt_vj              
       , day_cnt_vj                  
       , store_day_cnt_vj            
       , miss_item_cnt_vj            
       , miss_item_cnt_avg_day_vj    
       , miss_item_cnt_diff          
       , miss_item_avg_day_diff      
       , miss_item_avg_day_diff_delta
  FROM P_LEW_MART_LEAD.v_agg_miss_item_int_partial_week
;