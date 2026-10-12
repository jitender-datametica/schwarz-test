/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.t_agg_mo_item_wgi_store_day_flop20
#----------------------------------------------------------------------------
# History:
#  1.0  22-05-2023     Marvin Rekovsky       Initial Version of script
#  1.1  28-06-2023     Stefan Sockel         Added cumulative calculations
#----------------------------------------------------------------------------
*/


-- , item_sid                     COMMENT 'S-Key für Item Id'

/* #-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item/day
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.03.2023      Marvin Rekovsky           Initial Version
#  1.1	   27.06.2023	   Stefan Sockel			 Update cumulated values
#----------------------------------------------------------------------------- */
-- , cy_week_partial_week_id      COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
 -- , cy_week_partial_week_id

-- , item_sid
 CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_mo_item_wgi_store_day_flop20 (client_id
OPTIONS(description='MIS Client ID'), wh_id OPTIONS(description='Gesellschaft ID'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), orig_store_nr OPTIONS(description='Fachliche Store ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), dat_formdate
OPTIONS(description='Bezugsdatum'), cy_week OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJWW"'), cy_month
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), sales_net_val_day OPTIONS(description='Umsatz Tagesebene'), sales_net_val_day_py
OPTIONS(description='Umsatz Tagesebene VJ'), val_rtl_net_sfo_store_day
OPTIONS(description='Tagessumme der Abschriften in Landeswährung'), val_rtl_net_sfo_store_day_py
OPTIONS(description='Tagessumme der Abschriften in Landeswährung VJ'), val_rtl_net_sfo_qty_day
OPTIONS(description='Tagessumme der Abschriften in Stk/kg'), val_rtl_net_sfo_pct_day
OPTIONS(description='Tagessumme der Abschriften in %'), rank_item
OPTIONS(description='Artikelrang basierend auf Abschriftenwert'), dat_valid_from
OPTIONS(description='Startdatum der Validität für Artikel'), dat_valid_to
OPTIONS(description='Enddatum der Validität für Artikel'), dwh_updated OPTIONS(description='Technischer Zeitstempel'))
OPTIONS(DESCRIPTION = `AGGREGIERTE ABSCHRIFTEN - SCHLÜSSEL: CLIENT_ID/STORE_ID/DAT_FORMDATE`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_mo_item_wgi_store_day_flop20;