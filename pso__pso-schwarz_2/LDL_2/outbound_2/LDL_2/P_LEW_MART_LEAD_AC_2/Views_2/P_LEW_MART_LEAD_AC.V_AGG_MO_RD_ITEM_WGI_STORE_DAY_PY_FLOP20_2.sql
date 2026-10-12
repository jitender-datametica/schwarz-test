/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_DAY_FLOP20_2
#----------------------------------------------------------------------------
# History:
#  1.0  20-09-2023    Stefan Sockel         Initial version of Redesign
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_mo_rd_item_wgi_store_day_py_flop20_2 (client_id
OPTIONS(description='MIS Client ID'), move_to_store_id OPTIONS(description='S-Key der Location_2, hier der Filiale'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), dat_valid_from
OPTIONS(description='Startdatum der Validität für Artikel_2'), dat_formdate OPTIONS(description='Bezugsdatum'), cy_month
OPTIONS(description='Monat_2 des Geschäftsjahres im Format \"JJJJMM\"'), currency_iso_cd
OPTIONS(description='3 stelliger ISO-Währungs-Code'), val_rtl_net_sfo_store_day_py
OPTIONS(description='Tagessumme der Abschriften_2 in Landeswährung'), val_rtl_net_sfo_qty_day_py
OPTIONS(description='Tagessumme der Abschriften_2 in Stk/kg'), sales_net_val_day_py
OPTIONS(description='Umsatz Tagesebene'), val_rtl_net_sfo_pct_day_py
OPTIONS(description='Tagessumme der Abschriften_2 in %'), rank_itm_total
OPTIONS(description='Artikelrang basierend auf Abschriftenwert ohne WG'), dwh_updated
OPTIONS(description='Technischer Zeitstempel'))
OPTIONS(DESCRIPTION = `Aggregierte Abschriften_2 - Schlüssel: client_id/orig_store_nr/dat_formdate`) 
AS 
/* #-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_2/day
#
#-----------------------------------------------------------------------------
# History:
#  1.0  06.09.2023     Stefan Sockel         Initial version of Redesign
#----------------------------------------------------------------------------- 
*/
SELECT DISTINCT agg.client_id
, agg.move_to_store_id
, agg.aspect_id
, agg.orig_item_nr  
, agg.dat_valid_from
, agg.dat_formdate                           
, agg.cy_month     
, agg.currency_iso_cd          
, agg.val_rtl_net_sfo_store_day_py                 
, agg.val_rtl_net_sfo_qty_day_py
, agg.sales_net_val_day_py	
, agg.val_rtl_net_sfo_pct_day_py
, agg.rank_itm_total
, agg.dwh_updated
FROM ldl_p_lew_mart_lead.t_agg_mo_rd_item_wgi_store_day_py_flop20_2 AS agg;