CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_WGI_INT_DAY_1 COMMENT = 'Base view for all item_1/WGI views: Counts the missing items per country_1/WGI/day'
(
  client_id                     COMMENT 'MIS Client ID'
, item_grp_int_sid              COMMENT 'S-Key für Internationale Warengruppe'
, itemgroup_int_id              COMMENT 'Warengruppe ID'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, dat_formdate                  COMMENT 'Bezugsdatum'
, day_of_week                   COMMENT 'Tag_1 der Woche_1'
, cy_month                      COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, cy_week_partial_week_id       COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_week                       COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear                       COMMENT 'Geschäftsjahr'
, store_cnt                     COMMENT 'Anzahl der Filiale'
, skipped_cnt                   COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt                 COMMENT 'Anzahl der Fehlartikel über allen Filialen der Gesellschaft'
, miss_item_cnt_avg_day         COMMENT 'Durchschnittliche Fehlartikeltageswert pro Filiale'
, cal_dt_swday_prev_1y          COMMENT 'Datum des Vorjahres (gleiche Wochentag)'
, cy_week_vj                    COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM" - von Vorjahr'
, cy_month_vj                   COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'
, busyear_vj                    COMMENT 'Geschäftsjahr - von Vorjahr'
, store_cnt_vj                  COMMENT 'Anzahl der Filiale aus dem Vorjahr'
, skipped_cnt_vj                COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_vj              COMMENT 'Anzahl der Fehlartikel vom Vorjahr'
, miss_item_cnt_avg_day_vj      COMMENT 'Durchschnittliche Fehlartikeltageswert pro Filiale - aus dem Vorjahr'
, miss_item_cnt_diff            COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff        COMMENT 'Aktuelle Durchschnittswert (Filale/Tag_1) minus Durchschnittswert (Filale/Tag_1) aus dem Vorjahr'
, miss_item_avg_day_diff_delta  COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country_1/product group/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     23.08.2022      Michael Morris             Comparison to previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------
*/
SELECT   client_id                   
       , item_grp_int_sid            
       , itemgroup_int_id            
       , aspect_id                   
       , currency_iso_cd
       , curr_tot_id
       , dat_formdate                
       , day_of_week                 
       , cy_month                    
       , cy_week_partial_week_id     
       , cy_week                     
       , busyear                     
       , store_cnt                   
       , skipped_cnt                 
       , miss_item_cnt               
       , miss_item_cnt_avg_day       
       , cal_dt_swday_prev_1y        
       , cy_week_vj                  
       , cy_month_vj                 
       , busyear_vj                  
       , store_cnt_vj                
       , skipped_cnt_vj              
       , miss_item_cnt_vj            
       , miss_item_cnt_avg_day_vj    
       , miss_item_cnt_diff          
       , miss_item_avg_day_diff      
       , miss_item_avg_day_diff_delta
  FROM P_LEW_MART_LEAD.v_agg_miss_wgi_int_day_1
;