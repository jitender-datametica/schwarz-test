CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_agg_mo_item_wgi_store_mth_flop20_1 COMMENT = 'Aggregierte Abschriften_1 - Schlüssel: client_id/store_id/cy_month'
(
  client_id                      COMMENT 'MIS Client ID'
, wh_id                          COMMENT 'Gesellschaft ID'
, move_to_store_id               COMMENT 'S-Key der Location_1, hier der Filiale'
, orig_store_nr                  COMMENT 'Fachliche Store ID'
, aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, cy_month                       COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, busyear                        COMMENT 'Geschäftsjahr'
, currency_iso_cd                COMMENT '3 stelliger ISO-Währungs-Code'
--, item_sid                       COMMENT 'S-Key für Item_1 Id'
, orig_item_nr                   COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)'
, itemgroup_int_id               COMMENT 'Warengruppe ID'
, sales_net_val_mth              COMMENT 'Umsatz Monatsebene'
--, sales_net_val_mth_py           COMMENT 'Umsatz Monatsebene VJ'
, val_rtl_net_sfo_store_mth      COMMENT 'Monatssumme der Abschriften_1 in Landeswährung'
--, val_rtl_net_sfo_store_mth_py   COMMENT 'Monatssumme der Abschriften_1 in Landeswährung VJ'
, val_rtl_net_sfo_qty_mth        COMMENT 'Monatssumme der Abschriften_1 in Stk/kg'
, val_rtl_net_sfo_pct_mth        COMMENT 'Monatssumme der Abschriften_1 in %'
, rank_item                      COMMENT 'Artikelrang basierend auf Abschriftenwert'
, dat_valid_from                 COMMENT 'Startdatum der Validität für Artikel_1'
, dat_valid_to                   COMMENT 'Enddatum der Validität für Artikel_1'
, dwh_updated                    COMMENT 'Technischer Zeitstempel'
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
SELECT DISTINCT agg.client_id
       , asm.wh_id
	   , asm.move_to_store_id
	   , asm.orig_store_nr
	   , asm.aspect_id
       , agg.cy_month      
       , agg.busyear
       , agg.currency_iso_cd        
   --    , agg.item_sid               
       , agg.orig_item_nr                         
       , agg.itemgroup_int_id  
       , agg.sales_net_val_mth	
--       , agg.sales_net_val_mth_py 	   
       , agg.val_rtl_net_sfo_store_mth
--	   , val_rtl_net_sfo_store_mth_py  
       , agg.val_rtl_net_sfo_qty_mth 
       , agg.val_rtl_net_sfo_pct_mth 
       , ROW_NUMBER() OVER (PARTITION BY agg.client_id,asm.wh_id,asm.orig_store_nr,asm.move_to_store_id,agg.cy_month,agg.itemgroup_int_id,agg.currency_iso_cd 
	     ORDER BY agg.val_rtl_net_sfo_store_mth ASC, agg.val_rtl_net_sfo_pct_mth ASC, agg.orig_item_nr ASC) AS rank_item 
	   , agg.dwh_valid_from                           AS dat_valid_from
       , '9999-12-30'                             AS dat_valid_to
       , agg.dwh_updated    

  FROM p_lew_mart_lead.t_agg_mo_item_wgi_store_day_flop20_1 AS agg

  INNER JOIN p_lew_mart_lead_ac.v_org_store_merge_1 AS asm
    ON agg.client_id     = asm.client_id
   AND agg.loc_sid_store = asm.move_to_store_id  
     
  WHERE agg.val_rtl_net_sfo_store_mth IS NOT NULL 
  AND asm.mis_store_active_fg = 1 AND asm.aspect_id = 2
GROUP BY
        agg.client_id                   
       , asm.wh_id                                     
       , asm.move_to_store_id            
       , asm.orig_store_nr  
       , asm.aspect_id	    
       , agg.cy_month     
       , agg.busyear	   
       , agg.currency_iso_cd             
   --    , agg.item_sid        
       , agg.orig_item_nr                                 
       , agg.itemgroup_int_id   
       , agg.sales_net_val_mth
--	   , agg.sales_net_val_mth_py 
       , agg.val_rtl_net_sfo_store_mth 
 --      , val_rtl_net_sfo_store_mth_py   
       , agg.val_rtl_net_sfo_qty_mth        
       , agg.val_rtl_net_sfo_pct_mth
       , agg.dwh_valid_from
--       , agg.dwh_valid_to	   
       , agg.dwh_updated 
  QUALIFY rank_item <= 20
;