CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_SIG_STORE_WEEK_2 COMMENT = 'Counts the missing items per store/week/article family'
(
  client_id                     COMMENT 'MIS Client ID'
, loc_sid_wh                    COMMENT 'S-Key der Gesellschaft'
, move_to_store_id              COMMENT 'S-Key der Location_2, hier der Filiale'
, wh_id                         COMMENT 'Gesellschaft ID'
, orig_store_nr                 COMMENT 'Store ID'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, item_grp_int_sid              COMMENT 'S-Key für Internationale Warengruppe'
, sub_item_grp_sid              COMMENT 'S-Key für Unterwarengruppe'
, item_fam_grp_sid              COMMENT 'S-Key der Artikelfamiliengruppe'
, itemgroup_int_id              COMMENT 'Warengruppe ID'
, subitemgroup_id               COMMENT 'Unterwarengruppe ID'
, item_familygroup_id           COMMENT 'Artikelfamilie ID'
, cy_week                       COMMENT 'Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'
, busyear                       COMMENT 'Geschäftsjahr'
, day_cnt                       COMMENT 'Anzahl der Tage in dem den Store auf hat'
, miss_item_cnt                 COMMENT 'Anzahl der Fehlartikeln für die ganze Woche_2'
, miss_item_cnt_avg_day         COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_2'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/calendar_2 week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
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
       , item_grp_int_sid         
       , sub_item_grp_sid         
       , item_fam_grp_sid         
       , itemgroup_int_id         
       , subitemgroup_id           
       , item_familygroup_id            
       , cy_week                  
       , busyear                  
       , day_cnt                  
       , miss_item_cnt        
       , miss_item_cnt_avg_day
  FROM P_LEW_MART_LEAD.v_agg_miss_sig_store_week_2
;