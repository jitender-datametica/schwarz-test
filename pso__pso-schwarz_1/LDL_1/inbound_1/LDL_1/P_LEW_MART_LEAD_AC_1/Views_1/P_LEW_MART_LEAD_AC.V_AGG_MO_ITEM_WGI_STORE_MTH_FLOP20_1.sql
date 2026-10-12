CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_agg_mo_item_wgi_store_mth_flop20_1 COMMENT = 'Aggregierte Abschriften_1 - Schlüssel: client_id/store_id/cy_month'
(
  client_id                     COMMENT 'MIS Client ID'
, wh_id                         COMMENT 'Gesellschaft ID'
, move_to_store_id              COMMENT 'S-Key der Location_1, hier der Filiale'
, orig_store_nr                 COMMENT 'Fachliche Store ID'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, cy_month                      COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, busyear                       COMMENT 'Geschäftsjahr'
, currency_iso_cd               COMMENT '3 stelliger ISO-Währungs-Code'
--, item_sid                      COMMENT 'S-Key für Item_1 Id'
, orig_item_nr                  COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)'
, itemgroup_int_id              COMMENT 'Warengruppe ID'
, sales_net_val_mth             COMMENT 'Umsatz Monatsebene'
--, sales_net_val_mth_py          COMMENT 'Umsatz Monatseben VJ'
, val_rtl_net_sfo_store_mth     COMMENT 'Monatssumme der Abschriften_1 in Landeswährung'
--, val_rtl_net_sfo_store_mth_py  COMMENT 'Monatssumme der Abschriften_1 in Landeswährung VJ'
, val_rtl_net_sfo_qty_mth       COMMENT 'Monatssumme der Abschriften_1 in Stk/kg'
--, val_rtl_net_sfo_pct_mth       COMMENT 'Monatssumme der Abschriften_1 in %'
, rank_item                     COMMENT 'Artikelrang basierend auf Abschriftenwert'
, dat_valid_from                COMMENT 'Startdatum der Validität für Artikel_1'
, dat_valid_to                  COMMENT 'Enddatum der Validität für Artikel_1'
, dwh_updated                   COMMENT 'Technischer Zeitstempel'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_1/month
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13-03-2023      Marvin Rekovsky           Initial Version
#  1.1     09-08-2023      Stefan Sockel             rank_item added
#-----------------------------------------------------------------------------
*/
SELECT   client_id                   
       , wh_id                              
       , move_to_store_id            
       , orig_store_nr
       , aspect_id	   
       , cy_month   
       , busyear	   
       , currency_iso_cd             
   --    , item_sid       
       , orig_item_nr                                  
       , itemgroup_int_id   
       , sales_net_val_mth  
--       , sales_net_val_mth_py 	   
       , val_rtl_net_sfo_store_mth 
--       , val_rtl_net_sfo_store_mth_py     
       , val_rtl_net_sfo_qty_mth       
--       , val_rtl_net_sfo_pct_mth         
       , rank_item  
       , dat_valid_from 
       , dat_valid_to	   
       , dwh_updated 
  FROM p_lew_mart_lead.v_agg_mo_item_wgi_store_mth_flop20_1
;