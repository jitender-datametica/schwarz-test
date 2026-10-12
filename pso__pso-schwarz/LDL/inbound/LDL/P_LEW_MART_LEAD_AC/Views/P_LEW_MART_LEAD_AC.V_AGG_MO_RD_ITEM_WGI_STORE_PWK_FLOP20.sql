CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_MO_RD_ITEM_WGI_STORE_PWK_FLOP20(
	  CLIENT_ID                COMMENT 'MIS Client ID' 
	, MOVE_TO_STORE_ID         COMMENT 'S-Key der Location, hier der Filiale' 
    , WH_ID                    COMMENT 'WAREHOUSE ID' 
    , WH_ID_EXP                COMMENT 'WAREHOUSE EXP ID'     
	, ASPECT_ID                COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)' 
	, ORIG_ITEM_NR             COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)' 
	, ITEMGROUP_INT_ID         COMMENT 'Warengruppe ID' 
	, DAT_VALID_FROM           COMMENT 'Startdatum der Validität für Artikel' 
	, CY_WEEK_PARTIAL_WEEK_ID  COMMENT 'Bezugsdatum' 
	, REP_WEEK_FLAG            COMMENT 'Flag für MO-Reporting' 
    , SALES_MANAGER_ID         COMMENT 'VERKAUFSLEITER' 
    , ACCOUNT_MANAGER_ID       COMMENT 'VERTRIEBSLEITER'    
	, CURRENCY_ISO_CD          COMMENT '3 stelliger ISO-Währungs-Code' 
	, VAL_RTL_NET_SFO_STORE_PW COMMENT 'Tagessumme der Abschriften in Landeswährung' 
	, VAL_RTL_NET_SFO_QTY_PW   COMMENT 'Tagessumme der Abschriften in Stk/kg' 
	, SALES_NET_VAL_PW         COMMENT 'Umsatz Tagesebene' 
	, VAL_RTL_NET_SFO_PCT_PW   COMMENT 'Tagessumme der Abschriften in %' 
	, RANK_ITM_ITMGROUP        COMMENT 'Artikelrang basierend auf Abschriftenwert je WG' 
	, RANK_ITM_TOTAL           COMMENT 'Artikelrang basierend auf Abschriftenwert ohne WG' 
    , RANK_ITM_SM              COMMENT 'RANG DES ARTIKELS AUF VERKAUFSLEITER-EBENE' 
    , RANK_ITM_AM              COMMENT 'RANG DES ARTIKELS AUF VERTRIEBSLEITER-EBENE'     
	, DWH_UPDATED              COMMENT 'Technischer Zeitstempel'
) COMMENT = 'Aggregierte Abschriften - Schlüssel: client_id/orig_store_nr/dat_formdate'
 AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item/day
#
#-----------------------------------------------------------------------------
# History:
#  1.0  06.09.2023     Stefan Sockel         Initial version of Redesign
#  1.1  24.04.2024     Stefan Sockel         Added new ranks and identifier for VT and VL
#-----------------------------------------------------------------------------
*/
SELECT DISTINCT AGG.CLIENT_ID
, AGG.MOVE_TO_STORE_ID
, AGG.WH_ID
, AGG.WH_ID_EXP
, AGG.ASPECT_ID
, AGG.ORIG_ITEM_NR
, AGG.ITEMGROUP_INT_ID  
, AGG.DAT_VALID_FROM
, AGG.CY_WEEK_PARTIAL_WEEK_ID                           
, AGG.REP_WEEK_FLAG   
, AGG.SALES_MANAGER_ID
, AGG.ACCOUNT_MANAGER_ID
, AGG.CURRENCY_ISO_CD          
, AGG.VAL_RTL_NET_SFO_STORE_PW
, AGG.VAL_RTL_NET_SFO_QTY_PW
, AGG.SALES_NET_VAL_PW
, AGG.VAL_RTL_NET_SFO_PCT_PW
, AGG.RANK_ITM_ITMGROUP
, AGG.RANK_ITM_TOTAL
, AGG.RANK_ITM_SM
, AGG.RANK_ITM_AM
, AGG.DWH_UPDATED    
FROM P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_PWK_FLOP20 AS AGG
;