/* #-----------------------------------------------------------------------------
# Description:
# This view provides an Restantenquote data with the granularity of store/day/item_sid
#
#-----------------------------------------------------------------------------
# History:
#  1.0     18.01.2023      Michael Morris             Initial Version.
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_shelf_capacity_item_store_day (client_id
OPTIONS(description='MIS Client ID'), wh_id OPTIONS(description='Gesellschaft ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), orig_store_nr OPTIONS(description='Fachliche Store ID'),
dat_formdate OPTIONS(description='Bezugsdatum'), cy_week
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), curr_tot_id
OPTIONS(description='Interner Währungs-Code'), item_sid OPTIONS(description='S-Key für Item Id'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlice Schlüssel)'), case_size
OPTIONS(description='Case Size (Kolli)'), itemgroup_int_id OPTIONS(description='Warengruppe ID'), subitemgroup_id
OPTIONS(description='Unterwarengruppe ID'), item_familygroup_id OPTIONS(description='Artikelfamilie ID'),
bestand_filiale_kolli OPTIONS(description='Bestand in Kolli (Bestand in Stk. / Case Size)'), regalfuellmenge_kolli
OPTIONS(description='Regalfüllmenge in Kolli'), restbestand_kolli
OPTIONS(description='Regalfüllmenge in Kolli - Bestand in Kolli'), restantenquote_fil_pct
OPTIONS(description='(restbestand_stk / regalfuellmenge_stk) 100 - Solange restbestand_stk positive ist.'),
regelfuellmenge_0_fg OPTIONS(description='0 - regalfuellmenge_kolli > 0, 1 - regalfuellmenge_kolli = 0'), skipped_fg
OPTIONS(description='0 - Nicht skipped, 1 - Skipped.  Skipped = Fehlende Bestandsdatensatz'), dwh_updated
OPTIONS(description='Technische Zeitstempel'))
OPTIONS(DESCRIPTION = `RESTANTENQUOTEN - SCHLÜSSEL: CLIENT_ID/STORE_ID/DAT_FORMDATE/ITEM_SID`) AS SELECT DISTINCT ASM.client_id
 ,
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
 D.item_sid,
 D.orig_item_nr,
 D.case_size,
 D.itemgroup_int_id,
 D.subitemgroup_id,
 D.item_familygroup_id,
 D.bestand_filiale_kolli,
 D.regalfuellmenge_kolli,
 D.restbestand_kolli,
 D.restantenquote_fil_pct,
 D.regelfuellmenge_0_fg,
 D.skipped_fg,
 D.dwh_updated
FROM ldl_p_lew_mart_lead_ac.v_org_store_merge AS ASM
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge AS OSM ON ASM.client_id = OSM.client_id AND ASM.store_id = OSM.move_to_store_id
   
 INNER JOIN ldl_p_lew_mart_lead.t_shelf_capacity_item_store_day AS D ON ASM.client_id = D.client_id AND OSM.store_id = D
   .loc_sid_store;