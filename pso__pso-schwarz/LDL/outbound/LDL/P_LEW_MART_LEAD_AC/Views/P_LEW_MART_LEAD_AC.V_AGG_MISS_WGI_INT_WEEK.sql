/* #-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_wgi_int_week (client_id OPTIONS(description='MIS Client ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), cy_week OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'),
busyear OPTIONS(description='Geschäftsjahr'), day_cnt OPTIONS(description='Anzahl der Tage in dem den Store auf hat'),
store_day_cnt OPTIONS(description='Anzahl der Filialetage'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikel über allen Filialen der Gesellschaft'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Durchschnittliche Fehlartikeltageswert pro Filiale'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO LAND/WGI/WOCHE`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_int_week;