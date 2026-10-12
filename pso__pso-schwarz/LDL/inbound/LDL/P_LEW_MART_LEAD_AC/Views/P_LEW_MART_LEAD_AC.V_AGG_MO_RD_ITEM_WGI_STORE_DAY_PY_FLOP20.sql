/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_DAY_FLOP20
#----------------------------------------------------------------------------
# History:
#  1.0  20-09-2023    Stefan Sockel         Initial version of Redesign
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MO_RD_ITEM_WGI_STORE_DAY_PY_FLOP20 COMMENT = 'Aggregierte Abschriften - Schlüssel: client_id/orig_store_nr/dat_formdate'
(
	CLIENT_ID COMMENT 'MIS Client ID'
  ,MOVE_TO_STORE_ID COMMENT 'S-Key der Location, hier der Filiale'
  ,ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
  ,ORIG_ITEM_NR COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)'
  ,DAT_VALID_FROM COMMENT 'Startdatum der Validität für Artikel'
  ,DAT_FORMDATE COMMENT 'Bezugsdatum'
  ,CY_MONTH COMMENT 'Monat des Geschäftsjahres im Format \"JJJJMM\"'
  ,CURRENCY_ISO_CD COMMENT '3 stelliger ISO-Währungs-Code'
  ,VAL_RTL_NET_SFO_STORE_DAY_PY COMMENT 'Tagessumme der Abschriften in Landeswährung'
  ,VAL_RTL_NET_SFO_QTY_DAY_PY COMMENT 'Tagessumme der Abschriften in Stk/kg'
  ,SALES_NET_VAL_DAY_PY COMMENT 'Umsatz Tagesebene'
  ,VAL_RTL_NET_SFO_PCT_DAY_PY COMMENT 'Tagessumme der Abschriften in %'
  ,RANK_ITM_TOTAL COMMENT 'Artikelrang basierend auf Abschriftenwert ohne WG'
  ,DWH_UPDATED COMMENT 'Technischer Zeitstempel'
) 
 AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item/day
#
#-----------------------------------------------------------------------------
# History:
#  1.0  06.09.2023     Stefan Sockel         Initial version of Redesign
#-----------------------------------------------------------------------------
*/
SELECT DISTINCT AGG.CLIENT_ID
, AGG.MOVE_TO_STORE_ID
, AGG.ASPECT_ID
, AGG.ORIG_ITEM_NR  
, AGG.DAT_VALID_FROM
, AGG.DAT_FORMDATE                           
, AGG.CY_MONTH     
, AGG.CURRENCY_ISO_CD          
, AGG.VAL_RTL_NET_SFO_STORE_DAY_PY                 
, AGG.VAL_RTL_NET_SFO_QTY_DAY_PY
, AGG.SALES_NET_VAL_DAY_PY	
, AGG.VAL_RTL_NET_SFO_PCT_DAY_PY
, AGG.RANK_ITM_TOTAL
, AGG.DWH_UPDATED    
  FROM P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_DAY_PY_FLOP20 AS AGG
;