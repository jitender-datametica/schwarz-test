/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_DAY_FLOP20_1
#----------------------------------------------------------------------------
# History:
#  1.0  20-09-2023     Stefan Sockel         Initial version of Redesign
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MO_RD_ITEM_WGI_STORE_BY_CUM_FLOP20_1 COMMENT = 'Aggregierte Abschriften_1 - Schlüssel: client_id/orig_store_nr/dat_formdate'
(
	CLIENT_ID COMMENT 'MIS Client ID'
  ,MOVE_TO_STORE_ID COMMENT 'S-Key der Location_1, hier der Filiale'
  ,ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
  ,ORIG_ITEM_NR COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)'
  ,DAT_VALID_FROM COMMENT 'Startdatum der Validität für Artikel_1'
  ,CY_WEEK_PARTIAL_WEEK_ID COMMENT 'Bezugsdatum'
  ,CURRENCY_ISO_CD COMMENT '3 stelliger ISO-Währungs-Code'
  ,VAL_RTL_NET_SFO_STORE_BY_CUM COMMENT 'Tagessumme der Abschriften_1 in Landeswährung'
  ,VAL_RTL_NET_SFO_QTY_BY_CUM COMMENT 'Tagessumme der Abschriften_1 in Stk/kg'
  ,SALES_NET_VAL_BY_CUM COMMENT 'Umsatz Tagesebene'
  ,VAL_RTL_NET_SFO_PCT_BY_CUM COMMENT 'Tagessumme der Abschriften_1 in %'
  ,RANK_ITM_TOTAL COMMENT 'Artikelrang basierend auf Abschriftenwert ohne WG'
  ,DWH_UPDATED COMMENT 'Technischer Zeitstempel'
) 
 AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_1/day
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
     , AGG.CY_WEEK_PARTIAL_WEEK_ID                           
     , AGG.CURRENCY_ISO_CD          
     , AGG.VAL_RTL_NET_SFO_STORE_BY_CUM
     , AGG.VAL_RTL_NET_SFO_QTY_BY_CUM
     , AGG.SALES_NET_VAL_BY_CUM
     , AGG.VAL_RTL_NET_SFO_PCT_BY_CUM
     , AGG.RANK_ITM_TOTAL
     , AGG.DWH_UPDATED    
  FROM P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_BY_CUM_FLOP20_1 AS AGG
;