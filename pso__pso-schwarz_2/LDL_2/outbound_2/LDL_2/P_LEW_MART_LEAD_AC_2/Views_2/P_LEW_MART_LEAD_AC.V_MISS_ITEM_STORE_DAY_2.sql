/* #-----------------------------------------------------------------------------
# Description:
# This view provides a non-aggregated list of missing items.
#
#----------------------------------------------------------------------------
# History:
#  1.0     29.09.2022      Michael Morris             Initial Version
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_miss_item_store_day_2 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location_2, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), dat_formdate
OPTIONS(description='Bezugsdatum'), cy_month OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM"'),
busyear OPTIONS(description='Geschäftsjahr'), item_id OPTIONS(description='S-Key der Artikel_2'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
miss_item_fg OPTIONS(description='Konstant: Immer 1'))
OPTIONS(DESCRIPTION = `STORE/DAY LIST OF MISSING ITEMS - ARTIKEL_2 LEVEL`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_miss_item_store_day_2;