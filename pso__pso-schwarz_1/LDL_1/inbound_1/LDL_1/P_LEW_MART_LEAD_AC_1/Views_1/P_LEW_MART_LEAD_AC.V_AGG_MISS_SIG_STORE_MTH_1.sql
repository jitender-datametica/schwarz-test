CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_SIG_STORE_MTH_1 COMMENT = 'Counts the missing items per store/article family/ month'
(
  client_id                      COMMENT 'MIS Client ID'
, loc_sid_wh                     COMMENT 'S-Key der Gesellschaft'
, move_to_store_id               COMMENT 'S-Key der Location_1, hier der Filiale'
, wh_id                          COMMENT 'Gesellschaft ID'
, orig_store_nr                  COMMENT 'Store ID'
, aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd               COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                   COMMENT 'Interner Währungs-Code'
, item_grp_int_sid               COMMENT 'S-Key für Internationale Warengruppe'
, sub_item_grp_sid               COMMENT 'S-Key für Unterwarengruppe'
, item_fam_grp_sid               COMMENT 'S-Key der Artikelfamiliengruppe'
, itemgroup_int_id               COMMENT 'Warengruppe ID'
, subitemgroup_id                COMMENT 'Unterwarengruppe ID'
, item_familygroup_id            COMMENT 'Artikelfamilie ID'
, cy_month                       COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, busyear                        COMMENT 'Geschäftsjahr'
, day_cnt                        COMMENT 'Anzahl der öffenen Tage des Monats'
, skipped_cnt                    COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt                  COMMENT 'Anzahl der Fehlartikel'
, miss_item_cnt_avg_day          COMMENT 'Durchschnittliche Fehlartikeltageswert'
, cy_month_vj                    COMMENT 'Monat_1 des Vorgeschäftsjahres im Format "JJJJMM"'
, busyear_vj                     COMMENT 'Geschäftsjahr des Vorjahres'
, day_cnt_vj                     COMMENT 'Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'
, skipped_cnt_vj                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_vj               COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, miss_item_cnt_avg_day_vj       COMMENT 'Durchschnittliche Fehlartikeltageswert/Tag_1 aus dem Vorjahr'
, miss_item_cnt_diff             COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff         COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'
, miss_item_avg_day_diff_delta   COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides an-aggregated list of missing items with the granularity of store/article family group/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     19.09.2022      Michael Morris             Vorjahes Logik hinzugefügt.
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
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
       , cy_month
       , busyear
       , day_cnt
       , skipped_cnt
       , miss_item_cnt
       , miss_item_cnt_avg_day
       , cy_month_vj
       , busyear_vj
       , day_cnt_vj
       , skipped_cnt_vj
       , miss_item_cnt_vj
       , miss_item_cnt_avg_day_vj
       , miss_item_cnt_diff
       , miss_item_avg_day_diff
       , miss_item_avg_day_diff_delta
  FROM P_LEW_MART_LEAD.v_agg_miss_sig_store_mth_1
;