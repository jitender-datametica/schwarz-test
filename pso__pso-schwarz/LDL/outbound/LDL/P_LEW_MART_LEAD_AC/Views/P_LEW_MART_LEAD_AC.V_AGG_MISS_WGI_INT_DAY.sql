/* #-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country/product group/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     23.08.2022      Michael Morris             Comparison to previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_wgi_int_day (client_id OPTIONS(description='MIS Client ID'),
item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
dat_formdate OPTIONS(description='Bezugsdatum'), day_of_week OPTIONS(description='Tag der Woche'), cy_month
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_week
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
store_cnt OPTIONS(description='Anzahl der Filiale'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikel über allen Filialen der Gesellschaft'), miss_item_cnt_avg_day
OPTIONS(description='Durchschnittliche Fehlartikeltageswert pro Filiale'), cal_dt_swday_prev_1y
OPTIONS(description='Datum des Vorjahres (gleiche Wochentag)'), cy_week_vj
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM" - von Vorjahr'), cy_month_vj
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'), busyear_vj
OPTIONS(description='Geschäftsjahr - von Vorjahr'), store_cnt_vj
OPTIONS(description='Anzahl der Filiale aus dem Vorjahr'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_vj OPTIONS(description='Anzahl der Fehlartikel vom Vorjahr'), miss_item_cnt_avg_day_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert pro Filiale - aus dem Vorjahr'), miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff
OPTIONS(description='Aktuelle Durchschnittswert (Filale/Tag) minus Durchschnittswert (Filale/Tag) aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'))
OPTIONS(DESCRIPTION = `BASE VIEW FOR ALL ITEM/WGI VIEWS: COUNTS THE MISSING ITEMS PER COUNTRY/WGI/DAY`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_int_day;