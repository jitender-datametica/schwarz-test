/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.t_agg_mo_item_wgi_store_day_flop20_2
#----------------------------------------------------------------------------
# History:
#  1.0  22-05-2023     Marvin Rekovsky       Initial Version of script
#  1.1  28-06-2023     Stefan Sockel         Added cumulative calculations
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MO_ITEM_WGI_STORE_DAY_FLOP20_2 COMMENT = 'Aggregierte Abschriften_2 - Schlüssel: client_id/store_id/dat_formdate'
(
  client_id                    COMMENT 'MIS Client ID'
, wh_id                        COMMENT 'Gesellschaft ID'
, move_to_store_id             COMMENT 'S-Key der Location_2, hier der Filiale'
, orig_store_nr                COMMENT 'Fachliche Store ID'
, aspect_id                    COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, dat_formdate                 COMMENT 'Bezugsdatum'
, cy_week                      COMMENT 'Geschäftsjahr - Woche_2 Id - Format "JJJJWW"'
--, cy_week_partial_week_id      COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                     COMMENT 'Monat_2 des Geschäftsjahres im Format "JJJJMM"'
, busyear                      COMMENT 'Geschäftsjahr'
, currency_iso_cd              COMMENT '3 stelliger ISO-Währungs-Code'
--, item_sid                     COMMENT 'S-Key für Item_2 Id'
, orig_item_nr                 COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)'
, itemgroup_int_id             COMMENT 'Warengruppe ID'
, sales_net_val_day            COMMENT 'Umsatz Tagesebene'
, sales_net_val_day_py         COMMENT 'Umsatz Tagesebene VJ'
, val_rtl_net_sfo_store_day    COMMENT 'Tagessumme der Abschriften_2 in Landeswährung'
, val_rtl_net_sfo_store_day_py COMMENT 'Tagessumme der Abschriften_2 in Landeswährung VJ'
, val_rtl_net_sfo_qty_day      COMMENT 'Tagessumme der Abschriften_2 in Stk/kg'
, val_rtl_net_sfo_pct_day      COMMENT 'Tagessumme der Abschriften_2 in %'
, rank_item                    COMMENT 'Artikelrang basierend auf Abschriftenwert'
, dat_valid_from               COMMENT 'Startdatum der Validität für Artikel_2'
, dat_valid_to                 COMMENT 'Enddatum der Validität für Artikel_2'
, dwh_updated                  COMMENT 'Technischer Zeitstempel'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_2/day
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.03.2023      Marvin Rekovsky           Initial Version
#  1.1	   27.06.2023	   Stefan Sockel			 Update cumulated values
#-----------------------------------------------------------------------------
*/
SELECT   client_id                   
       , wh_id                                        
       , move_to_store_id            
       , orig_store_nr 
       , aspect_id	   
       , dat_formdate                
       , cy_week                     
--       , cy_week_partial_week_id     
       , cy_month         
       , busyear	   
       , currency_iso_cd             
 --      , item_sid     
       , orig_item_nr                                  
       , itemgroup_int_id 
       , sales_net_val_day  
       , sales_net_val_day_py	   
       , val_rtl_net_sfo_store_day 
       , val_rtl_net_sfo_store_day_py 	   
       , val_rtl_net_sfo_qty_day         
       , val_rtl_net_sfo_pct_day        
       , rank_item     
       , dat_valid_from       
       , dat_valid_to 	   
       , dwh_updated 
  FROM p_lew_mart_lead.v_agg_mo_item_wgi_store_day_flop20_2 
;