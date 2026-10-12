/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.t_agg_mo_item_wgi_store_day_flop20_1
#----------------------------------------------------------------------------
# History:
#  1.0  22-05-2023     Marvin Rekovsky       Initial Version of script
#  1.1  28-06-2023     Stefan Sockel         Added cumulative calculations
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MO_ITEM_WGI_STORE_PWK_FLOP20_1 COMMENT = 'Aggregierte Abschriften_1 - Schlüssel: client_id/store_id/cy_week_partial_week_id'
(
  client_id                      COMMENT 'MIS Client ID'
, wh_id                          COMMENT 'Gesellschaft ID'
, move_to_store_id               COMMENT 'S-Key der Location_1, hier der Filiale'
, orig_store_nr                  COMMENT 'Fachliche Store ID'
, aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, cy_week                        COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJWW"'
, cy_week_partial_week_id        COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
--, cy_month                       COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, busyear                        COMMENT 'Geschäftsjahr'
, currency_iso_cd                COMMENT '3 stelliger ISO-Währungs-Code'
--, item_sid                       COMMENT 'S-Key für Item_1 Id'
, orig_item_nr                   COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)'
, itemgroup_int_id               COMMENT 'Warengruppe ID'
, sales_net_val_pw               COMMENT 'Umsatz Teilwochenebene'
, sales_net_val_pw_py            COMMENT 'Umsatz Teilwochenebene VJ'
, val_rtl_net_sfo_store_pw       COMMENT 'Teilwochensumme der Abschriften_1 in Landeswährung'
, val_rtl_net_sfo_store_wk_py    COMMENT 'Teilwochensumme der Abschriften_1 in Landeswährung VJ'
, val_rtl_net_sfo_qty_pw         COMMENT 'Teilwochensumme der Abschriften_1 in Stk/kg'
, val_rtl_net_sfo_qty_mth_cum    COMMENT 'Teilwochensumme Monat_1 aufgelaufen der Abschriften_1 in Stk/kg'
, val_rtl_net_sfo_pct_pw         COMMENT 'Teilwochensumme der Abschriften_1 in %'
, sales_net_val_mth_cum          COMMENT 'Umsatz Teilwochenebene Monat_1 aufgel. (für Berechnung Umsatz Monat_1 aufgel.)'
, sales_net_val_by_cum           COMMENT 'Umsatz Teilwochenebene GJ aufgel. (für Berechnung Umsatz GJ aufgel.)'
, sales_net_val_mth_cum_py       COMMENT 'Umsatz Teilwochenebene Monat_1 VJ aufgel. (für Berechnung Umsatz Monat_1 VJ aufgel.)'
, sales_net_val_by_cum_py        COMMENT 'Umsatz Teilwochenebene GJ VJ aufgel. (für Berechnung Umsatz GJ VJ aufgel.)'
, val_rtl_net_sfo_store_mth_cum  COMMENT 'Abschriften_1 Teilwochenebene Monat_1 aufgel. (für Berechnung Abschriften_1 Monat_1 aufgel.)'
, val_rtl_net_sfo_store_by_cum      COMMENT 'Abschriften_1 Teilwochenebene GJ aufgel. (für Berechnung Abschriften_1 GJ aufgel.)'
, val_rtl_net_sfo_store_mth_cum_py  COMMENT 'Abschriften_1 Teilwochenebene Monat_1 VJ aufgel. (für Berechnung Abschriften_1 Monat_1 VJ aufgel.)'
, val_rtl_net_sfo_store_by_cum_py   COMMENT 'Abschriften_1 Teilwochenebene GJ VJ aufgel. (für Berechnung Abschriften_1 GJ VJ aufgel.)'  
, rank_item                      COMMENT 'Artikelrang basierend auf Abschriftenwert'
, dat_valid_from                 COMMENT 'Startdatum der Validität für Artikel_1'
, dat_valid_to                   COMMENT 'Enddatum der Validität für Artikel_1'
, dwh_updated                    COMMENT 'Technischer Zeitstempel'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_1/partial_week
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.03.2023      Marvin Rekovsky           Initial Version
#  1.1	   27.06.2023	   Stefan Sockel			 Update cumulated values
#-----------------------------------------------------------------------------
*/
SELECT DISTINCT agg.client_id
       , asm.wh_id
	   , asm.move_to_store_id
	   , asm.orig_store_nr
	   , asm.aspect_id
	   , agg.cy_week                
       , agg.cy_week_partial_week_id
       --, agg.cy_month    
       , agg.busyear	   
       , agg.currency_iso_cd        
 --      , agg.item_sid    
       , agg.orig_item_nr                        
       , agg.itemgroup_int_id 
	   , agg.sales_net_val_pw
	   , agg.sales_net_val_pw_py
       , agg.val_rtl_net_sfo_store_pw
	   , val_rtl_net_sfo_store_wk_py    
       , agg.val_rtl_net_sfo_qty_pw 
       , agg.val_rtl_net_sfo_qty_mth_cum       
       , agg.val_rtl_net_sfo_pct_pw
       , agg.sales_net_val_mth_cum 
       , agg.sales_net_val_by_cum  
       , agg.sales_net_val_mth_cum_py 
       , agg.sales_net_val_by_cum_py  
       , agg.val_rtl_net_sfo_store_mth_cum
       , agg.val_rtl_net_sfo_store_by_cum 
       , agg.val_rtl_net_sfo_store_mth_cum_py
       , agg.val_rtl_net_sfo_store_by_cum_py 
       , ROW_NUMBER() OVER (PARTITION BY agg.client_id,asm.wh_id,asm.orig_store_nr,asm.move_to_store_id,agg.cy_week_partial_week_id,agg.itemgroup_int_id,agg.currency_iso_cd 
	     ORDER BY agg.val_rtl_net_sfo_store_pw ASC,agg.val_rtl_net_sfo_pct_pw ASC,agg.orig_item_nr ASC) AS rank_item 
	   , agg.dwh_valid_from                          AS dat_valid_from
       , agg.dwh_valid_to                            AS dat_valid_to
       , agg.dwh_updated  
        
  FROM p_lew_mart_lead.t_agg_mo_item_wgi_store_day_flop20_1 AS agg

  INNER JOIN p_lew_mart_lead_ac.v_org_store_merge_1 AS asm
    ON agg.client_id     = asm.client_id
   AND agg.loc_sid_store = asm.move_to_store_id  
     
  WHERE agg.val_rtl_net_sfo_store_pw IS NOT NULL 
  AND asm.mis_store_active_fg = 1 AND asm.aspect_id = 2
GROUP BY
        agg.client_id                   
       , asm.wh_id                                     
       , asm.move_to_store_id            
       , asm.orig_store_nr  
       , asm.aspect_id	   
       , agg.cy_week                     
       , agg.cy_week_partial_week_id     
       --, agg.cy_month     
       , agg.busyear	   
       , agg.currency_iso_cd             
   --    , agg.item_sid        
       , agg.orig_item_nr                                  
       , agg.itemgroup_int_id 
       , agg.sales_net_val_pw
       , agg.sales_net_val_pw_py   
       , agg.val_rtl_net_sfo_store_pw 
       , val_rtl_net_sfo_store_wk_py  	   
       , agg.val_rtl_net_sfo_qty_pw  
       , agg.val_rtl_net_sfo_qty_mth_cum
       , agg.val_rtl_net_sfo_pct_pw 
       , agg.sales_net_val_mth_cum 
       , agg.sales_net_val_by_cum  
       , agg.sales_net_val_mth_cum_py 
       , agg.sales_net_val_by_cum_py  
       , agg.val_rtl_net_sfo_store_mth_cum
       , agg.val_rtl_net_sfo_store_by_cum 
       , agg.val_rtl_net_sfo_store_mth_cum_py
       , agg.val_rtl_net_sfo_store_by_cum_py        
       , agg.dwh_valid_from
       , agg.dwh_valid_to	   
       , agg.dwh_updated 
  QUALIFY rank_item <= 20
;