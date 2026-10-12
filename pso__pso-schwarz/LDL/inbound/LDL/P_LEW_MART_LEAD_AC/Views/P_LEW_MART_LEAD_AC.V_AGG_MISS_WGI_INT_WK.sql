CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_WGI_INT_WK COMMENT = 'Counts the missing items per Land/warengruppe/partial week'
(
  client_id                       COMMENT 'MIS Client ID'
, item_grp_int_sid                COMMENT 'S-Key für Internationale Warengruppe'
, itemgroup_int_id                COMMENT 'Warengruppe ID'
, aspect_id                       COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, cy_week_partial_week_id         COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                        COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM"'
, busyear                         COMMENT 'Geschäftsjahr'
, miss_item_cnt_d1                COMMENT 'Anzahl der Fehlartikel Tag 1 (Montag)'
, miss_item_cnt_d2                COMMENT 'Anzahl der Fehlartikel Tag 2 (Dienstag)'
, miss_item_cnt_d3                COMMENT 'Anzahl der Fehlartikel Tag 3 (Mittwoch)'
, miss_item_cnt_d4                COMMENT 'Anzahl der Fehlartikel Tag 4 (Donnerstag)'
, miss_item_cnt_d5                COMMENT 'Anzahl der Fehlartikel Tag 5 (Freitag)'
, miss_item_cnt_d6                COMMENT 'Anzahl der Fehlartikel Tag 6 (Samstag)'
, miss_item_cnt_d7                COMMENT 'Anzahl der Fehlartikel Tag 7 (Sonntag)'
, store_day_cnt                   COMMENT 'Anzahl der öffenen Tage der Woche'
, skipped_cnt                     COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt                   COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche'
, miss_item_cnt_avg_day           COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche)'
, store_day_cnt_vj                COMMENT 'Anzahl der öffenen Tage der Woche aus dem Vorjahr'
, skipped_cnt_vj                  COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_vj                COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche aus dem Vorjahr'
, miss_item_cnt_avg_day_vj        COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche aus dem Vorjahr)'
, miss_item_cnt_avg_day_diff      COMMENT 'Differenz zwischen den Durschnittswert (aktuell) und dem Duchschnittswert (Vorjahr)'
, store_day_cnt_mtd               COMMENT 'Anzahl der öffenen Tagen aufgelaufen des Monats'
, skipped_cnt_mtd                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_mtd               COMMENT 'Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats'
, store_day_cnt_mtd_vj            COMMENT 'Anzahl der öffenen Tagen aufgelaufen des Monats aus dem Vorjahr'
, skipped_cnt_mtd_vj              COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_mtd_vj            COMMENT 'Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats aus dem Vorjahr'
, miss_item_cnt_avg_day_mtd       COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats)'
, miss_item_cnt_avg_day_mtd_vj    COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats aus dem Vorjahr)'
, miss_item_cnt_avg_day_mtd_diff  COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen des Monats) und dem Duchschnittswert (aufgelaufen des Monats aus dem Vorjahr)'
, store_day_cnt_ytd               COMMENT 'Anzahl der öffenen aufgelaufen Tagen des aktuellen Geschäftsjahrs'
, skipped_cnt_ytd                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_ytd               COMMENT 'Gesamt Anzahl der aufgelaufenden Fehlartikeln des aktuellen Geschäftsjahres'
, store_day_cnt_ytd_vj            COMMENT 'Anzahl der öffenen aufgelaufen Tagen des Vorgeschäftsjahres'
, skipped_cnt_ytd_vj              COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_ytd_vj            COMMENT 'Gesamt Anzahl der aufgelaufenden Fehlartikeln des Vorgeschäftsjahres'
, miss_item_cnt_avg_day_ytd       COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des aktuellen Geschäftsjahres)'
, miss_item_cnt_avg_day_ytd_vj    COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Vorgeschäftsjahres)'
, miss_item_cnt_avg_day_ytd_diff  COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen aktuelles Geschäftsjahr) und dem Duchschnittswert (aufgelaufen Vorgeschäftsjahr)'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country/product group/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     23.08.2022      Michael Morris             Initial Versiuon
#
#-----------------------------------------------------------------------------
*/
SELECT   client_id                     
       , item_grp_int_sid              
       , itemgroup_int_id              
       , aspect_id                     
       , cy_week_partial_week_id       
       , cy_month                      
       , busyear                       
       , miss_item_cnt_d1              
       , miss_item_cnt_d2              
       , miss_item_cnt_d3              
       , miss_item_cnt_d4              
       , miss_item_cnt_d5              
       , miss_item_cnt_d6              
       , miss_item_cnt_d7              
       , store_day_cnt             
       , skipped_cnt               
       , miss_item_cnt             
       , miss_item_cnt_avg_day     
       , store_day_cnt_vj          
       , skipped_cnt_vj            
       , miss_item_cnt_vj          
       , miss_item_cnt_avg_day_vj  
       , miss_item_cnt_avg_day_diff
       , store_day_cnt_mtd             
       , skipped_cnt_mtd               
       , miss_item_cnt_mtd             
       , store_day_cnt_mtd_vj          
       , skipped_cnt_mtd_vj            
       , miss_item_cnt_mtd_vj          
       , miss_item_cnt_avg_day_mtd     
       , miss_item_cnt_avg_day_mtd_vj  
       , miss_item_cnt_avg_day_mtd_diff
       , store_day_cnt_ytd             
       , skipped_cnt_ytd               
       , miss_item_cnt_ytd             
       , store_day_cnt_ytd_vj          
       , skipped_cnt_ytd_vj            
       , miss_item_cnt_ytd_vj          
       , miss_item_cnt_avg_day_ytd     
       , miss_item_cnt_avg_day_ytd_vj  
       , miss_item_cnt_avg_day_ytd_diff
  FROM P_LEW_MART_LEAD.v_agg_miss_wgi_int_wk
;