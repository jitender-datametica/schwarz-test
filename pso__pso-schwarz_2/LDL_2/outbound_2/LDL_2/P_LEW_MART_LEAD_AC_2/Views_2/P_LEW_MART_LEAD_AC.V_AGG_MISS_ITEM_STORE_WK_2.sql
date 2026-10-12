/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     17.08.2022      Michael Morris             Initial Version
#  1.1     12.07.2023      Marvin Rekovsky            Added columns for same date previous year logic
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_item_store_wk_2 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location_2, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
cy_week_partial_week_id OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
day_cnt OPTIONS(description='Anzahl der öffenen Tage der Woche_2'), miss_item_cnt_d1
OPTIONS(description='Anzahl der Fehlartikel Tag_2 1 (Montag)'), miss_item_cnt_d2
OPTIONS(description='Anzahl der Fehlartikel Tag_2 2 (Dienstag)'), miss_item_cnt_d3
OPTIONS(description='Anzahl der Fehlartikel Tag_2 3 (Mittwoch)'), miss_item_cnt_d4
OPTIONS(description='Anzahl der Fehlartikel Tag_2 4 (Donnerstag)'), miss_item_cnt_d5
OPTIONS(description='Anzahl der Fehlartikel Tag_2 5 (Freitag)'), miss_item_cnt_d6
OPTIONS(description='Anzahl der Fehlartikel Tag_2 6 (Samstag)'), miss_item_cnt_d7
OPTIONS(description='Anzahl der Fehlartikel Tag_2 7 (Sonntag)'), miss_item_cnt
OPTIONS(description='Gesamt Anzahl der Fehlartikeln der Woche_2'), miss_item_cnt_avg_day
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_2)'),
day_cnt_vj OPTIONS(description='Anzahl der öffenen Tage der Woche_2 aus dem Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Gesamt Anzahl der Fehlartikeln der Woche_2 aus dem Vorjahr'), miss_item_cnt_avg_day_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_2 aus dem Vorjahr)'),
miss_item_cnt_avg_day_diff
OPTIONS(description='Differenz zwischen den Durschnittswert (aktuell) und dem Duchschnittswert (Vorjahr)'), day_cnt_mtd
OPTIONS(description='Anzahl der öffenen Tagen aufgelaufen des Monats'), miss_item_cnt_mtd
OPTIONS(description='Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats'), day_cnt_mtd_vj
OPTIONS(description='Anzahl der öffenen Tagen aufgelaufen des Monats aus dem Vorjahr'), miss_item_cnt_mtd_vj
OPTIONS(description='Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats aus dem Vorjahr'), day_cnt_mtd_vj_dat
OPTIONS(description='Anzahl der öffenen Tagen aufgelaufen des Monats aus dem Vorjahr (gleiches Datum)'),
miss_item_cnt_mtd_vj_dat
OPTIONS(description='Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats aus dem Vorjahr (gleiches Datum)'),
miss_item_cnt_avg_day_mtd
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats)'),
miss_item_cnt_avg_day_mtd_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats aus dem Vorjahr)'),
miss_item_cnt_avg_day_mtd_vj_dat
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats aus dem Vorjahr (gleiches Datum))'),
miss_item_cnt_avg_day_mtd_diff
OPTIONS(description='Differenz zwischen den Durschnittswert (aufgelaufen des Monats) und dem Duchschnittswert (aufgelaufen des Monats aus dem Vorjahr)'),
miss_item_cnt_avg_day_mtd_diff_dat
OPTIONS(description='Differenz zwischen den Durschnittswert (aufgelaufen des Monats) und dem Duchschnittswert (aufgelaufen des Monats aus dem Vorjahr (gleiches Datum))'),
day_cnt_ytd OPTIONS(description='Anzahl der öffenen aufgelaufen Tagen des aktuellen Geschäftsjahrs'), miss_item_cnt_ytd
OPTIONS(description='Gesamt Anzahl der aufgelaufenden Fehlartikeln des aktuellen Geschäftsjahres'), day_cnt_ytd_vj
OPTIONS(description='Anzahl der öffenen aufgelaufen Tagen des Vorgeschäftsjahres'), miss_item_cnt_ytd_vj
OPTIONS(description='Gesamt Anzahl der aufgelaufenden Fehlartikeln des Vorgeschäftsjahres'), day_cnt_ytd_vj_dat
OPTIONS(description='Anzahl der öffenen aufgelaufen Tagen des Vorgeschäftsjahres (gleiches Datum)'),
miss_item_cnt_ytd_vj_dat
OPTIONS(description='Gesamt Anzahl der aufgelaufenden Fehlartikeln des Vorgeschäftsjahres (gleiches Datum)'),
miss_item_cnt_avg_day_ytd
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des aktuellen Geschäftsjahres)'),
miss_item_cnt_avg_day_ytd_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Vorgeschäftsjahres)'),
miss_item_cnt_avg_day_ytd_vj_dat
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Vorgeschäftsjahres) (gleiches Datum)'),
miss_item_cnt_avg_day_ytd_diff
OPTIONS(description='Differenz zwischen den Durschnittswert (aufgelaufen aktuelles Geschäftsjahr) und dem Duchschnittswert (aufgelaufen Vorgeschäftsjahr)'),
miss_item_cnt_avg_day_ytd_diff_dat
OPTIONS(description='Differenz zwischen den Durschnittswert (aufgelaufen aktuelles Geschäftsjahr) und dem Duchschnittswert (aufgelaufen Vorgeschäftsjahr) (gleiches Datum)'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/PARTIAL WEEK`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_miss_item_store_wk_2;