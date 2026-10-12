CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_ITEM_STORE_PARTIAL_WEEK_2 COMMENT = 'Counts the missing items per store/month'
(
  client_id                        COMMENT 'MIS Client ID'
, loc_sid_wh                       COMMENT 'S-Key der Gesellschaft'
, move_to_store_id                 COMMENT 'S-Key der Location_2, hier der Filiale'
, wh_id                            COMMENT 'Gesellschaft ID'
, orig_store_nr                    COMMENT 'Store ID'
, aspect_id                        COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                  COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                      COMMENT 'Interner Währungs-Code'
, skipped_cnt                      COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, day_cnt                          COMMENT 'Anzahl der öffenen Tage des Monats'
, cy_week_partial_week_id          COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                         COMMENT 'Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'
, busyear                          COMMENT 'Geschäftsjahr'
, miss_item_cnt                    COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, miss_item_cnt_avg_day            COMMENT 'Durchschnittliche Fehlartikeltageswert'
, skipped_cnt_vj                   COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, day_cnt_vj                       COMMENT 'Anzahl der öffenen Tage der Woche_2 aus dem Vorjahr'
, miss_item_cnt_vj                 COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, miss_item_cnt_vj_dat             COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats (gleiches Datum)'     
, skipped_cnt_vj_dat               COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde (gleiches Datum).' 
, day_cnt_vj_dat                   COMMENT 'Anzahl der öffenen Tage der Woche_2 aus dem Vorjahr (gleiches Datum)'
, miss_item_cnt_avg_day_vj         COMMENT 'Durchschnittliche Fehlartikeltageswert/Tag_2 aus dem Vorjahr'
, miss_item_cnt_diff               COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff           COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'
, miss_item_avg_day_diff_delta     COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'
, miss_item_cnt_avg_day_vj_dat     COMMENT 'Durchschnittliche Fehlartikeltageswert/Tag_2 aus dem Vorjahr (gleiches Datum)'
, miss_item_cnt_diff_dat           COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr (gleiches Datum)'
, miss_item_avg_day_diff_dat       COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr (gleiches Datum)'
, miss_item_avg_day_diff_delta_dat COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent (gleiches Datum)'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/partial week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Version
#  1.1     17.08.2022      Michael Morris             Comparison with previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#  1.3     12.07.2023      Marvin Rekovsky            Added columns for same date previous year logic
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
       , skipped_cnt
       , day_cnt
       , cy_week_partial_week_id
       , cy_month
       , busyear
       , miss_item_cnt
       , miss_item_cnt_avg_day
       , skipped_cnt_vj              
       , day_cnt_vj                  
       , miss_item_cnt_vj 
       , miss_item_cnt_vj_dat              
       , skipped_cnt_vj_dat                 
       , day_cnt_vj_dat 	   
       , miss_item_cnt_avg_day_vj    
       , miss_item_cnt_diff          
       , miss_item_avg_day_diff      
       , miss_item_avg_day_diff_delta
	     , miss_item_cnt_avg_day_vj_dat
       , miss_item_cnt_diff_dat
       , miss_item_avg_day_diff_dat
       , miss_item_avg_day_diff_delta_dat
  FROM P_LEW_MART_LEAD.v_agg_miss_item_store_partial_week_2
;
