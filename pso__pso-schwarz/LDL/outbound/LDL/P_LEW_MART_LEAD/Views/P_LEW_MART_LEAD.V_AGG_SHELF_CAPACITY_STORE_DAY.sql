/* #-----------------------------------------------------------------------------
# Description:
# This view provides an Aggregated Restantenquote data with the granularity of store/day
#
#-----------------------------------------------------------------------------
# History:
#  1.0     18.01.2023      Michael Morris             Initial Version.
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_shelf_capacity_store_day (client_id
OPTIONS(description='MIS Client ID'), wh_id OPTIONS(description='Gesellschaft ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), orig_store_nr OPTIONS(description='Fachliche Store ID'),
dat_formdate OPTIONS(description='Bezugsdatum'), cy_week
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), curr_tot_id
OPTIONS(description='Interner Währungs-Code'), restantenquote_fil_pct
OPTIONS(description='Durchschnitt aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day restantenquote_fil'),
regelfuellmenge_0_cnt
OPTIONS(description='Summe aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day regelfuellmenge_0_fg'), skipped_cnt
OPTIONS(description='Summe aus P_LEW_MART_LEAD.t_shelf_capacity_item_store_day skipped_fg'), dwh_updated
OPTIONS(description='Technische Zeitstempel'))
OPTIONS(DESCRIPTION = `AGGREGATED RESTANTENQUOTEN - SCHLÜSSEL: CLIENT_ID/STORE_ID/DAT_FORMDATE`) AS SELECT DISTINCT ASM
 .client_id,
 ASM.wh_id,
 ASM.aspect_id,
 ASM.move_to_store_id,
 ASM.orig_store_nr,
 D.dat_formdate,
 D.cy_week,
 D.cy_week_partial_week_id,
 D.cy_month,
 D.busyear,
 D.currency_iso_cd,
 D.curr_tot_id,
 D.restantenquote_fil_pct,
 D.regelfuellmenge_0_cnt,
 D.skipped_cnt,
 D.dwh_updated
FROM ldl_p_lew_mart_lead_ac.v_org_store_merge AS ASM
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge AS OSM ON ASM.client_id = OSM.client_id AND ASM.store_id = OSM.move_to_store_id
   
 INNER JOIN ldl_p_lew_mart_lead.t_agg_shelf_capacity_store_day AS D ON ASM.client_id = D.client_id AND OSM.store_id = D
   .loc_sid_store;