/* #-----------------------------------------------------------------------------
# Description:
# This view provides an-aggregated list of missing items with the granularity of store/product group/day.
#
#----------------------------------------------------------------------------
# History:
#  1.0     12.05.2022      Michael Morris             Initial Versiuon
#  1.1     19.09.2022      Michael Morris             Vorjahes Logik hinzugefügt
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#  1.3     09.12.2022      Michael Morris             Vorjahr CALC und DAT hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_miss_wgi_store_day_2 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location_2, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'),
itemgroup_int_id OPTIONS(description='Warengruppe ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
dat_formdate OPTIONS(description='Bezugsdatum'), day_of_week OPTIONS(description='Tag_2 der Woche_2'), cy_month
OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM"'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_week
OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikel'), skipped_fg
OPTIONS(description='0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value aus P_LEW_MART_LEAD.T_REF_PARAMETER_VT_2 mit p_id = 1'),
cal_dt_vj_cal OPTIONS(description='Datum des Vorjahres (gleiche Wochentag)'), cy_week_vj_cal
OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM" - von Vorjahr'), cy_month_vj_cal
OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'), busyear_vj_cal
OPTIONS(description='Geschäftsjahr - von Vorjahr'), miss_item_cnt_vj_cal
OPTIONS(description='Anzahl der Fehlartikel vom Vorjahr'), skipped_fg_vj_cal
OPTIONS(description='0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt_vj > p_value aus P_LEW_MART_LEAD.T_VT_REF_PARAMETER mit p_id = 1'),
miss_item_cnt_diff_cal
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_cnt_diff_delta_cal
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'),
cal_dt_vj_dat OPTIONS(description='Datum des Vorjahres'), cy_week_vj_dat
OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM" - von Vorjahr'), cy_month_vj_dat
OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'), busyear_vj_dat
OPTIONS(description='Geschäftsjahr - von Vorjahr'), miss_item_cnt_vj_dat
OPTIONS(description='Anzahl der Fehlartikel vom Vorjahr'), skipped_fg_vj_dat
OPTIONS(description='0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt_vj > p_value aus P_LEW_MART_LEAD.T_VT_REF_PARAMETER mit p_id = 1'),
miss_item_cnt_diff_dat
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_cnt_diff_delta_dat
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'))
OPTIONS(DESCRIPTION = `BASE VIEW FOR ALL WGI VIEWS: COUNTS THE MISSING ITEMS PER STORE/WGI/DAY`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_store_day_2;