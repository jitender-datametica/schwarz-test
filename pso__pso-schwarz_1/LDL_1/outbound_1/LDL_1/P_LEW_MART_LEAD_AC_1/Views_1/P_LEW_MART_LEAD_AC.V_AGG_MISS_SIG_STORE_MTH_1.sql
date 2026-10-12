/* #-----------------------------------------------------------------------------
# Description:
# This view provides an-aggregated list of missing items with the granularity of store/article family group/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     19.09.2022      Michael Morris             Vorjahes Logik hinzugefügt.
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_sig_store_mth_1 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location_1, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'), sub_item_grp_sid
OPTIONS(description='S-Key für Unterwarengruppe'), item_fam_grp_sid
OPTIONS(description='S-Key der Artikelfamiliengruppe'), itemgroup_int_id OPTIONS(description='Warengruppe ID'),
subitemgroup_id OPTIONS(description='Unterwarengruppe ID'), item_familygroup_id OPTIONS(description='Artikelfamilie ID'),
cy_month OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM"'), busyear
OPTIONS(description='Geschäftsjahr'), day_cnt OPTIONS(description='Anzahl der öffenen Tage des Monats'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikel'), miss_item_cnt_avg_day
OPTIONS(description='Durchschnittliche Fehlartikeltageswert'), cy_month_vj
OPTIONS(description='Monat_1 des Vorgeschäftsjahres im Format "JJJJMM"'), busyear_vj
OPTIONS(description='Geschäftsjahr des Vorjahres'), day_cnt_vj
OPTIONS(description='Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_vj OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), miss_item_cnt_avg_day_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert/Tag_1 aus dem Vorjahr'), miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/ARTICLE FAMILY/ MONTH`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_miss_sig_store_mth_1;