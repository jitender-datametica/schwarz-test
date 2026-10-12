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


/* #-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item/partial week
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.03.2023      Marvin Rekovsky           Initial Version
#  1.1	   27.06.2023	   Stefan Sockel			 Update cumulated values
#----------------------------------------------------------------------------- */
-- , item_sid
 -- , item_sid                    COMMENT 'S-Key für Item Id'

-- , cy_month                    COMMENT 'Monat des Geschäftsjahres im Format "JJJJMM"'
 -- , cy_month

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_mo_item_wgi_store_pwk_flop20 (client_id
OPTIONS(description='MIS Client ID'), wh_id OPTIONS(description='Gesellschaft ID'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), orig_store_nr OPTIONS(description='Fachliche Store ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), cy_week
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJWW"'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), busyear OPTIONS(description='Geschäftsjahr'),
currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), sales_net_val_pw OPTIONS(description='Umsatz Teilwochenebene'),
sales_net_val_pw_py OPTIONS(description='Umsatz Teilwochenebene VJ'), val_rtl_net_sfo_store_pw
OPTIONS(description='Teilwochensumme der Abschriften in Landeswährung'), val_rtl_net_sfo_store_wk_py
OPTIONS(description='Teilwochensumme der Abschriften in Landeswährung VJ'), val_rtl_net_sfo_qty_pw
OPTIONS(description='Teilwochensumme der Abschriften in Stk/kg'), val_rtl_net_sfo_qty_mth_cum
OPTIONS(description='Teilwochensumme Monat aufgelaufen der Abschriften in Stk/kg'), val_rtl_net_sfo_pct_pw
OPTIONS(description='Teilwochensumme der Abschriften in %'), sales_net_val_mth_cum
OPTIONS(description='Umsatz Teilwochenebene Monat aufgel. (für Berechnung Umsatz Monat aufgel.)'), sales_net_val_by_cum
OPTIONS(description='Umsatz Teilwochenebene GJ aufgel. (für Berechnung Umsatz GJ aufgel.)'), sales_net_val_mth_cum_py
OPTIONS(description='Umsatz Teilwochenebene Monat VJ aufgel. (für Berechnung Umsatz Monat VJ aufgel.)'),
sales_net_val_by_cum_py
OPTIONS(description='Umsatz Teilwochenebene GJ VJ aufgel. (für Berechnung Umsatz GJ VJ aufgel.)'),
val_rtl_net_sfo_store_mth_cum
OPTIONS(description='Abschriften Teilwochenebene Monat aufgel. (für Berechnung Abschriften Monat aufgel.)'),
val_rtl_net_sfo_store_by_cum
OPTIONS(description='Abschriften Teilwochenebene GJ aufgel. (für Berechnung Abschriften GJ aufgel.)'),
val_rtl_net_sfo_store_mth_cum_py
OPTIONS(description='Abschriften Teilwochenebene Monat VJ aufgel. (für Berechnung Abschriften Monat VJ aufgel.)'),
val_rtl_net_sfo_store_by_cum_py
OPTIONS(description='Abschriften Teilwochenebene GJ VJ aufgel. (für Berechnung Abschriften GJ VJ aufgel.)'), rank_item
OPTIONS(description='Artikelrang basierend auf Abschriftenwert'), dat_valid_from
OPTIONS(description='Startdatum der Validität für Artikel'), dat_valid_to
OPTIONS(description='Enddatum der Validität für Artikel'), dwh_updated OPTIONS(description='Technischer Zeitstempel'))
OPTIONS(DESCRIPTION = `AGGREGIERTE ABSCHRIFTEN - SCHLÜSSEL: CLIENT_ID/STORE_ID/CY_WEEK_PARTIAL_WEEK_ID`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_mo_item_wgi_store_pwk_flop20;