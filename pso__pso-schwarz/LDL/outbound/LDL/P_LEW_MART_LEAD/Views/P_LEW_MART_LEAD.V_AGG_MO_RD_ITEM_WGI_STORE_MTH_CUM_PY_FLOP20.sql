/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_DAY_FLOP20
#----------------------------------------------------------------------------
# History:
#  1.0  20-09-2023     Stefan Sockel         Initial version of Redesign
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_mo_rd_item_wgi_store_mth_cum_py_flop20 (client_id
OPTIONS(description='MIS Client ID'), move_to_store_id OPTIONS(description='S-Key der Location, hier der Filiale'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), dat_valid_from
OPTIONS(description='Startdatum der Validität für Artikel'), cy_week_partial_week_id OPTIONS(description='Bezugsdatum'),
currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), val_rtl_net_sfo_store_mth_cum_py
OPTIONS(description='Tagessumme der Abschriften in Landeswährung'), val_rtl_net_sfo_qty_mth_cum_py
OPTIONS(description='Tagessumme der Abschriften in Stk/kg'), sales_net_val_mth_cum_py
OPTIONS(description='Umsatz Tagesebene'), val_rtl_net_sfo_pct_mth_cum_py
OPTIONS(description='Tagessumme der Abschriften in %'), rank_itm_total
OPTIONS(description='Artikelrang basierend auf Abschriftenwert ohne WG'), dwh_updated
OPTIONS(description='Technischer Zeitstempel'))
OPTIONS(DESCRIPTION = `AGGREGIERTE ABSCHRIFTEN - SCHLÜSSEL: CLIENT_ID/ORIG_STORE_NR/DAT_FORMDATE`) AS SELECT DISTINCT *
FROM ldl_p_lew_mart_lead.t_agg_mo_rd_item_wgi_store_mth_cum_py_flop20 AS AGG;