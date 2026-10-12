CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_WGI_WH_WEEK COMMENT = 'Anzahl der Fehlartikel pro Gesellschaft/WGI/Woche'
(
  client_id                     COMMENT 'MIS Client ID'
, loc_sid_wh                    COMMENT 'S-Key der Gesellschaft'
, wh_id                         COMMENT 'Gesellschaft ID'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, item_grp_int_sid              COMMENT 'S-Key für Internationale Warengruppe'
, itemgroup_int_id              COMMENT 'Warengruppe ID'
, cy_week                       COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM"'
, busyear                       COMMENT 'Geschäftsjahr'
, day_cnt                       COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt                 COMMENT 'Anzahl der Filialetage'
, miss_item_cnt                 COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche'
, skipped_cnt                   COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_avg_day         COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/calendar week.
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
       , CAST(currency_iso_cd AS VARCHAR(3)) AS currency_iso_cd
       , curr_tot_id
       , item_grp_int_sid
       , itemgroup_int_id
       , cy_week
       , busyear
       , day_cnt
       , store_day_cnt
       , miss_item_cnt
       , skipped_cnt
       , CASE WHEN store_day_cnt > 0 THEN (miss_item_cnt / store_day_cnt) ELSE 0 END AS miss_item_cnt_avg_day

  FROM (
        SELECT DISTINCT client_id
                , loc_sid_wh
                , wh_id
                , aspect_id
                , currency_iso_cd
                , curr_tot_id
                , item_grp_int_sid
                , itemgroup_int_id
                , cy_week
                , busyear
                , SUM(skipped_cnt)                                           OVER (PARTITION BY client_id, loc_sid_wh, wh_id, aspect_id, item_grp_int_sid, cy_week, curr_tot_id) AS skipped_cnt
                , SUM(CASE WHEN miss_item_cnt IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, loc_sid_wh, wh_id, aspect_id, item_grp_int_sid, cy_week, curr_tot_id) AS day_cnt
                , SUM(store_cnt)                                             OVER (PARTITION BY client_id, loc_sid_wh, wh_id, aspect_id, item_grp_int_sid, cy_week, curr_tot_id) AS store_day_cnt
                , SUM(miss_item_cnt)                                         OVER (PARTITION BY client_id, loc_sid_wh, wh_id, aspect_id, item_grp_int_sid, cy_week, curr_tot_id) AS miss_item_cnt

          FROM P_LEW_MART_LEAD.v_agg_miss_wgi_wh_day
        ) AS ww
;