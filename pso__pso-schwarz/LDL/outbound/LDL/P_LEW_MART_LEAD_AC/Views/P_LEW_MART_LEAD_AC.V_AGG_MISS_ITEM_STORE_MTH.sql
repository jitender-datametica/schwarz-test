/* #-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/month.
#
#----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_item_store_mth (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), day_cnt
OPTIONS(description='Anzahl der öffenen Tage des Monats'), cy_month
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Durchschnittliche Fehlartikeltageswert'), day_cnt_vj
OPTIONS(description='Anzahl der öffenen Tage des Monats'), cy_month_vj
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'), busyear_vj OPTIONS(description='Geschäftsjahr'),
miss_item_cnt_vj OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_avg_day_vj OPTIONS(description='Durchschnittliche Fehlartikeltageswert'), miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/MONTH`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_miss_item_store_mth;