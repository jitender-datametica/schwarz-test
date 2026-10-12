/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/calendar_2 week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_sig_store_week_2 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location_2, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'), sub_item_grp_sid
OPTIONS(description='S-Key für Unterwarengruppe'), item_fam_grp_sid
OPTIONS(description='S-Key der Artikelfamiliengruppe'), itemgroup_int_id OPTIONS(description='Warengruppe ID'),
subitemgroup_id OPTIONS(description='Unterwarengruppe ID'), item_familygroup_id OPTIONS(description='Artikelfamilie ID'),
cy_week OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
day_cnt OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikeln für die ganze Woche_2'), miss_item_cnt_avg_day
OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_2'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/WEEK/ARTICLE FAMILY`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_miss_sig_store_week_2;