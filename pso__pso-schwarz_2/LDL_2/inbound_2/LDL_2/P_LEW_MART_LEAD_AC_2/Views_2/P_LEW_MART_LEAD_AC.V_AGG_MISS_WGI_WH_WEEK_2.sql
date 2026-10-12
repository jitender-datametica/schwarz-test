CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_WGI_WH_WEEK_2 COMMENT = 'Anzahl der Fehlartikel pro Gesellschaft/WGI/Woche_2'
(
  client_id                     COMMENT 'MIS Client ID'
, loc_sid_wh                    COMMENT 'S-Key der Gesellschaft'
, wh_id                         COMMENT 'Gesellschaft ID'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, item_grp_int_sid              COMMENT 'S-Key für Internationale Warengruppe'
, itemgroup_int_id              COMMENT 'Warengruppe ID'
, cy_week                       COMMENT 'Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'
, busyear                       COMMENT 'Geschäftsjahr'
, day_cnt                       COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt                 COMMENT 'Anzahl der Filialetage'
, miss_item_cnt                 COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_2'
, skipped_cnt                   COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_avg_day         COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_2'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/calendar_2 week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
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
       , item_grp_int_sid
       , itemgroup_int_id
       , cy_week
       , busyear
       , day_cnt
       , store_day_cnt
       , miss_item_cnt
       , skipped_cnt
       , miss_item_cnt_avg_day
  FROM P_LEW_MART_LEAD.v_agg_miss_wgi_wh_week_2
;