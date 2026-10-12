/* #----------------------------------------------------------------------------
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
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_item_store_partial_week_1 (client_id
OPTIONS(description='MIS Client ID'), loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location_1, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
day_cnt OPTIONS(description='Anzahl der öffenen Tage des Monats'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), miss_item_cnt_avg_day
OPTIONS(description='Durchschnittliche Fehlartikeltageswert'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
day_cnt_vj OPTIONS(description='Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), miss_item_cnt_vj_dat
OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats (gleiches Datum)'), skipped_cnt_vj_dat
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde (gleiches Datum).'),
day_cnt_vj_dat OPTIONS(description='Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr (gleiches Datum)'),
miss_item_cnt_avg_day_vj OPTIONS(description='Durchschnittliche Fehlartikeltageswert/Tag_1 aus dem Vorjahr'),
miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'),
miss_item_cnt_avg_day_vj_dat
OPTIONS(description='Durchschnittliche Fehlartikeltageswert/Tag_1 aus dem Vorjahr (gleiches Datum)'),
miss_item_cnt_diff_dat
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr (gleiches Datum)'),
miss_item_avg_day_diff_dat
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr (gleiches Datum)'),
miss_item_avg_day_diff_delta_dat
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent (gleiches Datum)'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/MONTH`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_miss_item_store_partial_week_1;