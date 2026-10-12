CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_ITEM_WH_WK_1 COMMENT = 'Counts the missing items per warehouse/partial week'
(
  client_id                       COMMENT 'MIS Client ID'
, loc_sid_wh                      COMMENT 'S-Key der Gesellschaft'
, wh_id                           COMMENT 'Gesellschaft ID'
, aspect_id                       COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                 COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                     COMMENT 'Interner Währungs-Code'
, cy_week_partial_week_id         COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                        COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear                         COMMENT 'Geschäftsjahr'
, skipped_cnt                     COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, day_cnt                         COMMENT 'Anzahl der öffenen Tage der Woche_1'
, store_day_cnt                   COMMENT 'Anzahl der öffenen Filialen-Tage der Woche_1'
, miss_item_cnt_d1                COMMENT 'Anzahl der Fehlartikel Tag_1 1 (Montag)'
, miss_item_cnt_d2                COMMENT 'Anzahl der Fehlartikel Tag_1 2 (Dienstag)'
, miss_item_cnt_d3                COMMENT 'Anzahl der Fehlartikel Tag_1 3 (Mittwoch)'
, miss_item_cnt_d4                COMMENT 'Anzahl der Fehlartikel Tag_1 4 (Donnerstag)'
, miss_item_cnt_d5                COMMENT 'Anzahl der Fehlartikel Tag_1 5 (Freitag)'
, miss_item_cnt_d6                COMMENT 'Anzahl der Fehlartikel Tag_1 6 (Samstag)'
, miss_item_cnt_d7                COMMENT 'Anzahl der Fehlartikel Tag_1 7 (Sonntag)'
, miss_item_cnt                   COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche_1'
, miss_item_cnt_avg_day           COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_1)'
, store_day_cnt_vj                COMMENT 'Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'
, skipped_cnt_vj                  COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_vj                COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche_1 aus dem Vorjahr'
, miss_item_cnt_avg_day_vj        COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_1 aus dem Vorjahr)'
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
# This view provides an aggregated list of missing items with the granularity of store/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     17.08.2022      Michael Morris             Initial Versiuon
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
       , cy_week_partial_week_id       
       , cy_month                      
       , busyear                       
       , skipped_cnt                   
       , day_cnt                       
       , store_day_cnt                 
       , miss_item_cnt_d1              
       , miss_item_cnt_d2              
       , miss_item_cnt_d3              
       , miss_item_cnt_d4              
       , miss_item_cnt_d5              
       , miss_item_cnt_d6              
       , miss_item_cnt_d7              
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
  FROM P_LEW_MART_LEAD.v_agg_miss_item_wh_wk_1
;