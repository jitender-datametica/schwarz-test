CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MISS_ITEM_STORE_WK_2 COMMENT = 'Counts the missing items per store/partial week'
(
  client_id                           COMMENT 'MIS Client ID'
, loc_sid_wh                          COMMENT 'S-Key der Gesellschaft'
, move_to_store_id                    COMMENT 'S-Key der Location_2, hier der Filiale'
, wh_id                               COMMENT 'Gesellschaft ID'
, orig_store_nr                       COMMENT 'Store ID'
, aspect_id                           COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                     COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                         COMMENT 'Interner Währungs-Code'
, cy_week_partial_week_id             COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                            COMMENT 'Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'
, busyear                             COMMENT 'Geschäftsjahr'
, skipped_cnt                         COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, day_cnt                             COMMENT 'Anzahl der öffenen Tage der Woche_2'
, miss_item_cnt_d1                    COMMENT 'Anzahl der Fehlartikel Tag_2 1 (Montag)'
, miss_item_cnt_d2                    COMMENT 'Anzahl der Fehlartikel Tag_2 2 (Dienstag)'
, miss_item_cnt_d3                    COMMENT 'Anzahl der Fehlartikel Tag_2 3 (Mittwoch)'
, miss_item_cnt_d4                    COMMENT 'Anzahl der Fehlartikel Tag_2 4 (Donnerstag)'
, miss_item_cnt_d5                    COMMENT 'Anzahl der Fehlartikel Tag_2 5 (Freitag)'
, miss_item_cnt_d6                    COMMENT 'Anzahl der Fehlartikel Tag_2 6 (Samstag)'
, miss_item_cnt_d7                    COMMENT 'Anzahl der Fehlartikel Tag_2 7 (Sonntag)'
, miss_item_cnt                       COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche_2'
, miss_item_cnt_avg_day               COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_2)'
, day_cnt_vj                          COMMENT 'Anzahl der öffenen Tage der Woche_2 aus dem Vorjahr'
, miss_item_cnt_vj                    COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche_2 aus dem Vorjahr'
, miss_item_cnt_avg_day_vj            COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_2 aus dem Vorjahr)'
, miss_item_cnt_avg_day_diff          COMMENT 'Differenz zwischen den Durschnittswert (aktuell) und dem Duchschnittswert (Vorjahr)'
, day_cnt_mtd                         COMMENT 'Anzahl der öffenen Tagen aufgelaufen des Monats'
, miss_item_cnt_mtd                   COMMENT 'Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats'
, day_cnt_mtd_vj                      COMMENT 'Anzahl der öffenen Tagen aufgelaufen des Monats aus dem Vorjahr'
, miss_item_cnt_mtd_vj                COMMENT 'Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats aus dem Vorjahr'
, day_cnt_mtd_vj_dat                  COMMENT 'Anzahl der öffenen Tagen aufgelaufen des Monats aus dem Vorjahr (gleiches Datum)'    
, miss_item_cnt_mtd_vj_dat            COMMENT 'Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats aus dem Vorjahr (gleiches Datum)'
, miss_item_cnt_avg_day_mtd           COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats)'
, miss_item_cnt_avg_day_mtd_vj        COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats aus dem Vorjahr)'
, miss_item_cnt_avg_day_mtd_vj_dat    COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats aus dem Vorjahr (gleiches Datum))'
, miss_item_cnt_avg_day_mtd_diff      COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen des Monats) und dem Duchschnittswert (aufgelaufen des Monats aus dem Vorjahr)'
, miss_item_cnt_avg_day_mtd_diff_dat  COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen des Monats) und dem Duchschnittswert (aufgelaufen des Monats aus dem Vorjahr (gleiches Datum))'
, day_cnt_ytd                         COMMENT 'Anzahl der öffenen aufgelaufen Tagen des aktuellen Geschäftsjahrs'
, miss_item_cnt_ytd                   COMMENT 'Gesamt Anzahl der aufgelaufenden Fehlartikeln des aktuellen Geschäftsjahres'
, day_cnt_ytd_vj                      COMMENT 'Anzahl der öffenen aufgelaufen Tagen des Vorgeschäftsjahres'
, miss_item_cnt_ytd_vj                COMMENT 'Gesamt Anzahl der aufgelaufenden Fehlartikeln des Vorgeschäftsjahres'
, day_cnt_ytd_vj_dat                  COMMENT 'Anzahl der öffenen aufgelaufen Tagen des Vorgeschäftsjahres (gleiches Datum)'
, miss_item_cnt_ytd_vj_dat            COMMENT 'Gesamt Anzahl der aufgelaufenden Fehlartikeln des Vorgeschäftsjahres (gleiches Datum)'
, miss_item_cnt_avg_day_ytd           COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des aktuellen Geschäftsjahres)'
, miss_item_cnt_avg_day_ytd_vj        COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Vorgeschäftsjahres)'
, miss_item_cnt_avg_day_ytd_vj_dat    COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Vorgeschäftsjahres) (gleiches Datum)'
, miss_item_cnt_avg_day_ytd_diff      COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen aktuelles Geschäftsjahr) und dem Duchschnittswert (aufgelaufen Vorgeschäftsjahr)'
, miss_item_cnt_avg_day_ytd_diff_dat  COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen aktuelles Geschäftsjahr) und dem Duchschnittswert (aufgelaufen Vorgeschäftsjahr) (gleiches Datum)'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     17.08.2022      Michael Morris             Initial Version
#  1.1     12.07.2023      Marvin Rekovsky            Added columns for same date previous year logic
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
       , cy_week_partial_week_id
       , cy_month
       , busyear
       , skipped_cnt
       , day_cnt
       , miss_item_cnt_d1
       , miss_item_cnt_d2
       , miss_item_cnt_d3
       , miss_item_cnt_d4
       , miss_item_cnt_d5
       , miss_item_cnt_d6
       , miss_item_cnt_d7
       , miss_item_cnt
       , miss_item_cnt_avg_day
       , day_cnt_vj
       , miss_item_cnt_vj
       , miss_item_cnt_avg_day_vj
       , miss_item_cnt_avg_day_diff
       , day_cnt_mtd
       , miss_item_cnt_mtd
       , day_cnt_mtd_vj
       , miss_item_cnt_mtd_vj
	     , day_cnt_mtd_vj_dat                  
       , miss_item_cnt_mtd_vj_dat 
       , miss_item_cnt_avg_day_mtd
       , miss_item_cnt_avg_day_mtd_vj
	     , miss_item_cnt_avg_day_mtd_vj_dat
       , miss_item_cnt_avg_day_mtd_diff
	     , miss_item_cnt_avg_day_mtd_diff_dat
       , day_cnt_ytd
       , miss_item_cnt_ytd
       , day_cnt_ytd_vj
       , miss_item_cnt_ytd_vj
       , day_cnt_ytd_vj_dat
       , miss_item_cnt_ytd_vj_dat
       , miss_item_cnt_avg_day_ytd
       , miss_item_cnt_avg_day_ytd_vj
       , miss_item_cnt_avg_day_ytd_vj_dat
       , miss_item_cnt_avg_day_ytd_diff
       , miss_item_cnt_avg_day_ytd_diff_dat
  FROM P_LEW_MART_LEAD.v_agg_miss_item_store_wk_2
;