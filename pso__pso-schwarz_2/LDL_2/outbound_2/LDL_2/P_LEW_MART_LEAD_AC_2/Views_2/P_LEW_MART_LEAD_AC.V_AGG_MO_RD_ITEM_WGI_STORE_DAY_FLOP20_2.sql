CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_mo_rd_item_wgi_store_day_flop20_2 (client_id
OPTIONS(description='MIS Client ID'), move_to_store_id OPTIONS(description='S-Key der Location_2, hier der Filiale'),
wh_id OPTIONS(description='WAREHOUSE ID'), wh_id_exp OPTIONS(description='WAREHOUSE EXP ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), dat_valid_from OPTIONS(description='Startdatum der Validität für Artikel_2'),
dat_formdate OPTIONS(description='Bezugsdatum'), rep_day_flag OPTIONS(description='Flag für MO-Reporting'), cy_month
OPTIONS(description='Monat_2 des Geschäftsjahres im Format \"JJJJMM\"'), sales_manager_id
OPTIONS(description='VERKAUFSLEITER'), account_manager_id OPTIONS(description='VERTRIEBSLEITER'), currency_iso_cd
OPTIONS(description='3 stelliger ISO-Währungs-Code'), val_rtl_net_sfo_store_day
OPTIONS(description='Tagessumme der Abschriften_2 in Landeswährung'), val_rtl_net_sfo_qty_day
OPTIONS(description='Tagessumme der Abschriften_2 in Stk/kg'), sales_net_val_day OPTIONS(description='Umsatz Tagesebene'),
val_rtl_net_sfo_pct_day OPTIONS(description='Tagessumme der Abschriften_2 in %'), rank_itm_itmgroup
OPTIONS(description='Artikelrang basierend auf Abschriftenwert je WG'), rank_itm_total
OPTIONS(description='Artikelrang basierend auf Abschriftenwert ohne WG'), rank_itm_sm
OPTIONS(description='RANG DES ARTIKELS AUF VERKAUFSLEITER-EBENE'), rank_itm_am
OPTIONS(description='RANG DES ARTIKELS AUF VERTRIEBSLEITER-EBENE'), dwh_updated
OPTIONS(description='Technischer Zeitstempel')
)OPTIONS(DESCRIPTION = `Aggregierte Abschriften_2 - Schlüssel: client_id/orig_store_nr/dat_formdate`) 
AS 
/* #-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_2/day
#
#-----------------------------------------------------------------------------
# History:
#  1.0  06.09.2023     Stefan Sockel         Initial version of Redesign
#  1.1  24.04.2024     Stefan Sockel         Added new ranks and identifier for VT and VL
#----------------------------------------------------------------------------- 
*/
SELECT DISTINCT agg.client_id
, agg.move_to_store_id
, agg.wh_id
, agg.wh_id_exp
, agg.aspect_id
, agg.orig_item_nr
, agg.itemgroup_int_id  
, agg.dat_valid_from
, agg.dat_formdate                           
, agg.rep_day_flag                           
, agg.cy_month   
, agg.sales_manager_id
, agg.account_manager_id
, agg.currency_iso_cd          
, agg.val_rtl_net_sfo_store_day                  
, agg.val_rtl_net_sfo_qty_day
, agg.sales_net_val_day	
, agg.val_rtl_net_sfo_pct_day
, agg.rank_itm_itmgroup
, agg.rank_itm_total
, agg.rank_itm_sm
, agg.rank_itm_am
, agg.dwh_updated
FROM ldl_p_lew_mart_lead.t_agg_mo_rd_item_wgi_store_day_flop20_2 AS agg;