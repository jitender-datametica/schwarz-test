CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_WGI_WH_MTH_1 COMMENT = 'Anzahl der Fehlartikel pro Gesellschaft/Warengruppe/Monat_1'
(
  client_id                     COMMENT 'MIS Client ID'
, loc_sid_wh                    COMMENT 'S-Key der Gesellschaft'
, wh_id                         COMMENT 'Gesellschaft ID'
, item_grp_int_sid              COMMENT 'S-Key für Internationale Warengruppe'
, itemgroup_int_id              COMMENT 'Warengruppe ID'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, cy_month                      COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, busyear                       COMMENT 'Geschäftsjahr'
, day_cnt                       COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt                 COMMENT 'Anzahl der Filialetage'
, skipped_cnt                   COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt                 COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_1'
, miss_item_cnt_avg_day         COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_1'
, cy_month_vj                   COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM" - Vorjahr'
, busyear_vj                    COMMENT 'Geschäftsjahr - Vorjahr'
, day_cnt_vj                    COMMENT 'Anzahl der Tage in dem den Store auf hat'
, store_day_cnt_vj              COMMENT 'Anzahl der Filialetage aus dem Vorjahr'
, skipped_cnt_vj                COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_vj              COMMENT 'Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_1 - aus dem Vorjahr'
, miss_item_cnt_avg_day_vj      COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_1 - aus dem Vorjahr'
, miss_item_cnt_diff            COMMENT 'Anzahl der Fehlartikel (im Monat_1) aus aktuellem Jahr minus Anzahl der Fehlartikel (im Monat_1) aus dem Vorjahr'
, miss_item_avg_day_diff        COMMENT 'Aktuelle Durchschnittswert (Filale/Tag_1) minus Durchschnittswert (Filale/Tag_1) aus dem Vorjahr'
, miss_item_avg_day_diff_delta  COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/product group/month.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     22.08.2022      Michael Morris             Comparison to previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#-----------------------------------------------------------------------------
*/
SELECT   client_id
       , loc_sid_wh
       , wh_id
       , item_grp_int_sid
       , itemgroup_int_id
       , aspect_id
       , CAST(currency_iso_cd AS VARCHAR(3)) AS currency_iso_cd
       , curr_tot_id
       , cy_month
       , busyear
       , day_cnt
       , store_day_cnt
       , skipped_cnt
       , miss_item_cnt
       , CASE WHEN store_day_cnt > 0 THEN (miss_item_cnt / store_day_cnt) ELSE 0 END           AS miss_item_cnt_avg_day
       , cy_month_vj
       , busyear_vj
       , day_cnt_vj
       , store_day_cnt_vj
       , skipped_cnt_vj
       , miss_item_cnt_vj
       , CASE WHEN store_day_cnt_vj > 0 THEN (miss_item_cnt_vj / store_day_cnt_vj) ELSE 0 END AS miss_item_cnt_avg_day_vj
       , (miss_item_cnt - miss_item_cnt_vj)                                                   AS miss_item_cnt_diff
       , (miss_item_cnt_avg_day - miss_item_cnt_avg_day_vj)                                   AS miss_item_avg_day_diff
       , CASE WHEN miss_item_cnt_avg_day_vj > 0 THEN (miss_item_avg_day_diff / miss_item_cnt_avg_day_vj * 100) ELSE 0 END AS miss_item_avg_day_diff_delta
  FROM (
        SELECT DISTINCT client_id
                , loc_sid_wh
                , wh_id
                , item_grp_int_sid
                , itemgroup_int_id
                , aspect_id
                , currency_iso_cd
                , curr_tot_id
                , cy_month
                , busyear
                , MAX(day_cnt)                OVER (PARTITION BY client_id, loc_sid_wh, item_grp_int_sid, aspect_id, cy_month, curr_tot_id) AS day_cnt
                , SUM(day_cnt)                OVER (PARTITION BY client_id, loc_sid_wh, item_grp_int_sid, aspect_id, cy_month, curr_tot_id) AS store_day_cnt
                , SUM(miss_item_cnt)          OVER (PARTITION BY client_id, loc_sid_wh, item_grp_int_sid, aspect_id, cy_month, curr_tot_id) AS miss_item_cnt
                , SUM(skipped_cnt)            OVER (PARTITION BY client_id, loc_sid_wh, item_grp_int_sid, aspect_id, cy_month, curr_tot_id) AS skipped_cnt
                , cy_month_vj
                , busyear_vj
                , MAX(day_cnt_vj)             OVER (PARTITION BY client_id, loc_sid_wh, item_grp_int_sid, aspect_id, cy_month, curr_tot_id) AS day_cnt_vj
                , SUM(day_cnt_vj)             OVER (PARTITION BY client_id, loc_sid_wh, item_grp_int_sid, aspect_id, cy_month, curr_tot_id) AS store_day_cnt_vj
                , SUM(miss_item_cnt_vj)       OVER (PARTITION BY client_id, loc_sid_wh, item_grp_int_sid, aspect_id, cy_month, curr_tot_id) AS miss_item_cnt_vj
                , SUM(skipped_cnt_vj)         OVER (PARTITION BY client_id, loc_sid_wh, item_grp_int_sid, aspect_id, cy_month, curr_tot_id) AS skipped_cnt_vj

          FROM P_LEW_MART_LEAD.v_agg_miss_wgi_store_mth_1
        ) AS ww
;