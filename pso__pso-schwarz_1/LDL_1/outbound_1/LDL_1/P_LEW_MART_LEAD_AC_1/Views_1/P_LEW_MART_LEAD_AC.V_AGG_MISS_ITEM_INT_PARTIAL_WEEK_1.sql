/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country_1/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     17.08.2022      Michael Morris             Comparison with previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_item_int_partial_week_1 (client_id
OPTIONS(description='MIS Client ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
cy_week_partial_week_id OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
day_cnt OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt
OPTIONS(description='Anzahl der Filialetage'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für die Teilwoche'), miss_item_cnt_avg_day
OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_1'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
day_cnt_vj OPTIONS(description='Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'), store_day_cnt_vj
OPTIONS(description='Anzahl der Filialetage aus dem Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), miss_item_cnt_avg_day_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert/Tag_1 aus dem Vorjahr'), miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO LAND_1/TEILWOCHE`) AS SELECT client_id,
 aspect_id,
 currency_iso_cd,
 curr_tot_id,
 cy_week_partial_week_id,
 cy_month,
 busyear,
 skipped_cnt,
 day_cnt,
 store_day_cnt,
 miss_item_cnt,
 miss_item_cnt_avg_day,
 skipped_cnt_vj,
 day_cnt_vj,
 store_day_cnt_vj,
 miss_item_cnt_vj,
 miss_item_cnt_avg_day_vj,
 miss_item_cnt_diff,
 miss_item_avg_day_diff,
 miss_item_avg_day_diff_delta
FROM ldl_p_lew_mart_lead.v_agg_miss_item_int_partial_week_1;