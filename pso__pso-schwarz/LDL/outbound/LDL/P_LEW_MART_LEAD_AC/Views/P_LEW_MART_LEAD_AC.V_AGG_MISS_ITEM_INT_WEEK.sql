/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country/calendar week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_item_int_week (client_id OPTIONS(description='MIS Client ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), cy_week
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'), day_cnt
OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt
OPTIONS(description='Anzahl der Filialetage'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag'), cy_week_vj
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), busyear_vj OPTIONS(description='Geschäftsjahr'),
day_cnt_vj OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt_vj
OPTIONS(description='Anzahl der Filiale aus dem Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche - aus dem Vorjahr'),
skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_avg_day_vj OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag - aus dem Vorjahr'),
miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel (in der Woche) aus aktuellem Jahr minus Anzahl der Fehlartikel (in der Woche) aus dem Vorjahr'),
miss_item_avg_day_diff
OPTIONS(description='Aktuelle Durchschnittswert (Filale/Tag) minus Durchschnittswert (Filale/Tag) aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO LAND/WOCHE`) AS SELECT client_id,
 aspect_id,
 currency_iso_cd,
 curr_tot_id,
 cy_week,
 busyear,
 day_cnt,
 store_day_cnt,
 miss_item_cnt,
 skipped_cnt,
 miss_item_cnt_avg_day,
 cy_week_vj,
 busyear_vj,
 day_cnt_vj,
 store_day_cnt_vj,
 miss_item_cnt_vj,
 skipped_cnt_vj,
 miss_item_cnt_avg_day_vj,
 miss_item_cnt_diff,
 miss_item_avg_day_diff,
 miss_item_avg_day_diff_delta
FROM ldl_p_lew_mart_lead.v_agg_miss_item_int_week;