-- , item_sid                      COMMENT 'S-Key für Item Id'

-- , sales_net_val_mth_py          COMMENT 'Umsatz Monatseben VJ'

/* #-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item/month
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13-03-2023      Marvin Rekovsky           Initial Version
#  1.1     09-08-2023      Stefan Sockel             rank_item added
#----------------------------------------------------------------------------- */
-- , val_rtl_net_sfo_pct_mth       COMMENT 'Monatssumme der Abschriften in %'

-- , val_rtl_net_sfo_store_mth_py  COMMENT 'Monatssumme der Abschriften in Landeswährung VJ'

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_mo_item_wgi_store_mth_flop20 (client_id
OPTIONS(description='MIS Client ID'), wh_id OPTIONS(description='Gesellschaft ID'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), orig_store_nr OPTIONS(description='Fachliche Store ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), cy_month
OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), sales_net_val_mth OPTIONS(description='Umsatz Monatsebene'),
val_rtl_net_sfo_store_mth OPTIONS(description='Monatssumme der Abschriften in Landeswährung'), val_rtl_net_sfo_qty_mth
OPTIONS(description='Monatssumme der Abschriften in Stk/kg'), rank_item
OPTIONS(description='Artikelrang basierend auf Abschriftenwert'), dat_valid_from
OPTIONS(description='Startdatum der Validität für Artikel'), dat_valid_to
OPTIONS(description='Enddatum der Validität für Artikel'), dwh_updated OPTIONS(description='Technischer Zeitstempel'))
OPTIONS(DESCRIPTION = `AGGREGIERTE ABSCHRIFTEN - SCHLÜSSEL: CLIENT_ID/STORE_ID/CY_MONTH`) AS SELECT client_id,
 wh_id,
 move_to_store_id,
 orig_store_nr,
 aspect_id,
 cy_month,
 busyear,
 currency_iso_cd -- , item_sid
,
 orig_item_nr,
 itemgroup_int_id,
 sales_net_val_mth -- , sales_net_val_mth_py
,
 val_rtl_net_sfo_store_mth -- , val_rtl_net_sfo_store_mth_py
,
 val_rtl_net_sfo_qty_mth -- , val_rtl_net_sfo_pct_mth
,
 rank_item,
 dat_valid_from,
 dat_valid_to,
 dwh_updated
FROM ldl_p_lew_mart_lead.v_agg_mo_item_wgi_store_mth_flop20;