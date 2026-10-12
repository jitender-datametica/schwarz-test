/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/calendar_1 week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_wgi_wh_week_1 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), wh_id OPTIONS(description='Gesellschaft ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), cy_week OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'),
busyear OPTIONS(description='Geschäftsjahr'), day_cnt OPTIONS(description='Anzahl der Tage in dem den Store auf hat'),
store_day_cnt OPTIONS(description='Anzahl der Filialetage'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche_1'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_1'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO GESELLSCHAFT/WGI/WOCHE_1`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_wh_week_1;