CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MO_RD_ITEM_WGI_STORE_DAY_FLOP20_1
(
	  CLIENT_ID                 COMMENT 'MIS Client ID' 
	, MOVE_TO_STORE_ID          COMMENT 'S-Key der Location_1, hier der Filiale' 
    , WH_ID                     COMMENT 'WAREHOUSE ID' 
    , WH_ID_EXP                 COMMENT 'WAREHOUSE EXP ID'   
	, ASPECT_ID                 COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)' 
	, ORIG_ITEM_NR              COMMENT 'Ursprüngliche Artikelnummer (fachlicher Schlüssel)' 
	, ITEMGROUP_INT_ID          COMMENT 'Warengruppe ID' 
	, DAT_VALID_FROM            COMMENT 'Startdatum der Validität für Artikel_1' 
	, DAT_FORMDATE              COMMENT 'Bezugsdatum' 
	, REP_DAY_FLAG              COMMENT 'Flag für MO-Reporting' 
	, CY_MONTH                  COMMENT 'Monat_1 des Geschäftsjahres im Format \"JJJJMM\"' 
    , SALES_MANAGER_ID          COMMENT 'VERKAUFSLEITER' 
    , ACCOUNT_MANAGER_ID        COMMENT 'VERTRIEBSLEITER'     
	, CURRENCY_ISO_CD           COMMENT '3 stelliger ISO-Währungs-Code' 
	, VAL_RTL_NET_SFO_STORE_DAY COMMENT 'Tagessumme der Abschriften_1 in Landeswährung' 
	, VAL_RTL_NET_SFO_QTY_DAY   COMMENT 'Tagessumme der Abschriften_1 in Stk/kg' 
	, SALES_NET_VAL_DAY         COMMENT 'Umsatz Tagesebene' 
	, VAL_RTL_NET_SFO_PCT_DAY   COMMENT 'Tagessumme der Abschriften_1 in %' 
	, RANK_ITM_ITMGROUP         COMMENT 'Artikelrang basierend auf Abschriftenwert je WG' 
	, RANK_ITM_TOTAL            COMMENT 'Artikelrang basierend auf Abschriftenwert ohne WG' 
    , RANK_ITM_SM               COMMENT 'RANG DES ARTIKELS AUF VERKAUFSLEITER-EBENE' 
    , RANK_ITM_AM               COMMENT 'RANG DES ARTIKELS AUF VERTRIEBSLEITER-EBENE'   
	, DWH_UPDATED               COMMENT 'Technischer Zeitstempel'
) COMMENT = 'Aggregierte Abschriften_1 - Schlüssel: client_id/orig_store_nr/dat_formdate'
 AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_1/day
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
, AGG.DAT_FORMDATE                           
, AGG.REP_DAY_FLAG                           
, AGG.CY_MONTH
, AGG.SALES_MANAGER_ID
, AGG.ACCOUNT_MANAGER_ID
, AGG.CURRENCY_ISO_CD          
, AGG.VAL_RTL_NET_SFO_STORE_DAY                  
, AGG.VAL_RTL_NET_SFO_QTY_DAY
, AGG.SALES_NET_VAL_DAY	
, AGG.VAL_RTL_NET_SFO_PCT_DAY
, AGG.RANK_ITM_ITMGROUP
, AGG.RANK_ITM_TOTAL
, AGG.RANK_ITM_SM
, AGG.RANK_ITM_AM
, AGG.DWH_UPDATED    

  FROM P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_DAY_FLOP20_1 AS AGG
;