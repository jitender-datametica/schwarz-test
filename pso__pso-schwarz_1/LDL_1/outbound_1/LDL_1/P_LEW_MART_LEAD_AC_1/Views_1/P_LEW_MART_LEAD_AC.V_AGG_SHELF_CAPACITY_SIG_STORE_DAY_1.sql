/* #-----------------------------------------------------------------------------
# Description:
# This view provides an Aggregated Restantenquote data with the granularity of store/day/sig
#
#-----------------------------------------------------------------------------
# History:
#  1.0     18.01.2023      Michael Morris             Initial Version.
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_shelf_capacity_sig_store_day_1 (client_id
OPTIONS(description='MIS Client ID'), wh_id OPTIONS(description='Gesellschaft ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), move_to_store_id
OPTIONS(description='S-Key der Location_1, hier der Filiale'), orig_store_nr OPTIONS(description='Fachliche Store ID'),
dat_formdate OPTIONS(description='Bezugsdatum'), cy_week
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), curr_tot_id
OPTIONS(description='Interner Währungs-Code'), subitemgroup_id OPTIONS(description='Unterwarengruppe ID'),
restantenquote_fil_pct
OPTIONS(description='Durchschnitt aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day_1 restantenquote_fil'),
regelfuellmenge_0_cnt
OPTIONS(description='Summe aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day_1 regelfuellmenge_0_fg'), skipped_cnt
OPTIONS(description='Summe aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day_1 skipped_fg'), dwh_updated
OPTIONS(description='Technische Zeitstempel'))
OPTIONS(DESCRIPTION = `AGGREGATED RESTANTENQUOTEN - SCHLÜSSEL: CLIENT_ID/STORE_ID/DAT_FORMDATE/SIG`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_shelf_capacity_sig_store_day_1;