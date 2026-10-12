/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.t_agg_mo_item_wgi_store_day_flop20_1
#----------------------------------------------------------------------------
# History:
#  1.0  22.05.2023     Marvin Rekovsky       Initial Version of script
#  1.1  28.06.2023     Stefan Sockel         Added cumulative calculations
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MO_ITEM_WGI_STORE_DAY_FLOP20_1 COMMENT = 'Aggregierte Abschriften_1 - Schlüssel: client_id/store_id/dat_formdate'
(
	CLIENT_ID COMMENT 'MIS Client ID',
	WH_ID COMMENT 'Gesellschaft ID',
	MOVE_TO_STORE_ID COMMENT 'S-Key der Location_1, hier der Filiale',
	ORIG_STORE_NR COMMENT 'Fachliche Store ID',
	ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	DAT_FORMDATE COMMENT 'Bezugsdatum',
	CY_WEEK COMMENT 'Geschäftsjahr - Woche_1 Id - Format \"JJJJWW\"',
	CY_MONTH COMMENT 'Monat_1 des Geschäftsjahres im Format \"JJJJMM\"',
	BUSYEAR COMMENT 'Geschäftsjahr',
	CURRENCY_ISO_CD COMMENT '3 stelliger ISO-Währungs-Code',
	ORIG_ITEM_NR COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)',
	ITEMGROUP_INT_ID COMMENT 'Warengruppe ID',
	SALES_NET_VAL_DAY COMMENT 'Umsatz Tagesebene',
	SALES_NET_VAL_DAY_PY COMMENT 'Umsatz Tagesebene VJ',
	VAL_RTL_NET_SFO_STORE_DAY COMMENT 'Tagessumme der Abschriften_1 in Landeswährung',
	VAL_RTL_NET_SFO_STORE_DAY_PY COMMENT 'Tagessumme der Abschriften_1 in Landeswährung VJ',
	VAL_RTL_NET_SFO_QTY_DAY COMMENT 'Tagessumme der Abschriften_1 in Stk/kg',
	VAL_RTL_NET_SFO_PCT_DAY COMMENT 'Tagessumme der Abschriften_1 in %',
	RANK_ITEM COMMENT 'Artikelrang basierend auf Abschriftenwert',
	DAT_VALID_FROM COMMENT 'Startdatum der Validität für Artikel_1',
	DAT_VALID_TO COMMENT 'Enddatum der Validität für Artikel_1',
	DWH_UPDATED COMMENT 'Technischer Zeitstempel'
) 
 AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_1/day
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.03.2023      Marvin Rekovsky           Initial Version
#  1.1	   27.06.2023	   Stefan Sockel			 Update cumulated values
#  1.2	   05.07.2023	   Stefan Sockel			 Added partial week in row number over partition to avoid double rows
#-----------------------------------------------------------------------------
*/
SELECT DISTINCT agg.client_id
       , asm.wh_id
	   , asm.move_to_store_id
	   , asm.orig_store_nr
	   , asm.aspect_id
	   , agg.dat_formdate                           
       , agg.cy_week                
       , agg.cy_month     
       , agg.busyear	   
       , agg.currency_iso_cd          
       , agg.orig_item_nr                        
       , agg.itemgroup_int_id  
       , agg.sales_net_val_day	
       , agg.sales_net_val_day_py   
       , agg.val_rtl_net_sfo_store_day 
       , agg.val_rtl_net_sfo_store_day_py	   
       , agg.val_rtl_net_sfo_qty_day    
       , agg.val_rtl_net_sfo_pct_day
       , ROW_NUMBER() OVER (PARTITION BY agg.client_id,asm.wh_id,asm.orig_store_nr,asm.move_to_store_id,agg.dat_formdate,agg.itemgroup_int_id,agg.currency_iso_cd,agg.cy_week_partial_week_id
	     ORDER BY agg.val_rtl_net_sfo_store_day ASC,agg.val_rtl_net_sfo_pct_day ASC,agg.orig_item_nr ASC) AS rank_item 
	   , agg.dwh_valid_from                           AS dat_valid_from
       , agg.dwh_valid_to                             AS dat_valid_to
       , agg.dwh_updated    

  FROM p_lew_mart_lead.t_agg_mo_item_wgi_store_day_flop20_1 AS agg

  INNER JOIN p_lew_mart_lead_ac.v_org_store_merge_1 AS asm
    ON agg.client_id     = asm.client_id
   AND agg.loc_sid_store = asm.move_to_store_id  
   
  WHERE agg.val_rtl_net_sfo_store_day IS NOT NULL 
  AND asm.mis_store_active_fg = 1 AND asm.aspect_id = 2
  QUALIFY rank_item <= 20 
;