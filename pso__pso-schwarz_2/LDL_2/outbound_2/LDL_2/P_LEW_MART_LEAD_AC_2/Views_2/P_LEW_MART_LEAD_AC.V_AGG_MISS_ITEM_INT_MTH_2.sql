/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country_2/month.
#
#----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_item_int_mth_2 (client_id OPTIONS(description='MIS Client ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), cy_month
OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'), day_cnt
OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt
OPTIONS(description='Anzahl der Filialetage'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für den ganzen Monat_2'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_2'), cy_month_vj
OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'), busyear_vj OPTIONS(description='Geschäftsjahr'),
day_cnt_vj OPTIONS(description='Anzahl der Tage in dem den Store auf hat - aus dem Vorjahr'), store_day_cnt_vj
OPTIONS(description='Anzahl der Filialetage aus dem Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für den ganzen Monat_2'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_avg_day_vj OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_2'), miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel (im Monat_2) aus aktuellem Jahr minus Anzahl der Fehlartikel (im Monat_2) aus dem Vorjahr'),
miss_item_avg_day_diff
OPTIONS(description='Aktuelle Durchschnittswert (Filale/Tag_2) minus Durchschnittswert (Filale/Tag_2) aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO LAND_2/MONAT_2`) AS SELECT client_id,
 aspect_id,
 currency_iso_cd,
 curr_tot_id,
 cy_month,
 busyear,
 day_cnt,
 store_day_cnt,
 miss_item_cnt,
 skipped_cnt,
 miss_item_cnt_avg_day,
 cy_month_vj,
 busyear_vj,
 day_cnt_vj,
 store_day_cnt_vj,
 miss_item_cnt_vj,
 skipped_cnt_vj,
 miss_item_cnt_avg_day_vj,
 miss_item_cnt_diff,
 miss_item_avg_day_diff,
 miss_item_avg_day_diff_delta
FROM ldl_p_lew_mart_lead.v_agg_miss_item_int_mth_2;