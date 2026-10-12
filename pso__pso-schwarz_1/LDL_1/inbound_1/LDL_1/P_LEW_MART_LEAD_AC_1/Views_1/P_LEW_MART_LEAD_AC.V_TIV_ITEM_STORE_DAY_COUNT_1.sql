/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_TIV_ITEM_STORE_DAY_COUNT_1
#----------------------------------------------------------------------------
# History:
#  --- ---------- ----------------------- --------------------------------
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT                                        
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_TIV_ITEM_STORE_DAY_COUNT_1
(
  DAT_FORMDATE                  COMMENT 'DATUM DER INVENTURANFORDERUNG'
, CLIENT_ID                     COMMENT 'MIS CLIENT ID'
, REQUEST_ID                    COMMENT 'ANFORDERUNGS ID'
, LOC_SID_WH                    COMMENT 'S-KEY DER LOCATION_1, HIER DER GESELLSCHAFT'
, MOVE_TO_STORE_ID              COMMENT 'S-KEY DER LOCATION_1, HIER DER FILIALE'
, ASPECT_ID                     COMMENT 'GESELLSCHAFTSFORM (1 = BETRIEBS- 2 = VERTRIEBSGESELLSCHAFT)'
, CURRENCY_ISO_CD               COMMENT '3 STELLIGER WÄHRUNGS-CODE'
, CURR_TOT_ID                   COMMENT 'INTERNER WÄHRUNGS-CODE'
, REQUEST_LIST_ID               COMMENT 'ANFORDERUNGS LITE ID' --
, INV_TYPE_ID                   COMMENT 'INVENTURTYP' --
, STOCK_CORR_REQ_STATUS_ID      COMMENT 'STATUS_1 DER INVENTURANFORDERUNG' --
, ITEM_SID                      COMMENT 'S-KEY DER ARTIKEL_1'
, CNT_REASON_ID                 COMMENT 'GRUND DER INVENTURANFORDERUNG' --
, ACT_ITEM_CNT                  COMMENT 'GEZÄHLTE MENGE'
, CALC_ITEM_CNT                 COMMENT 'SOLLMENGE'
, KORREKTURMENGE                COMMENT 'KORREKTURMENGE'
, PRICE_RETAIL_NETTO
, KORREKTURWERT
, INV_CNT                       COMMENT 'REPORTING-ZÄHLER'
)
AS
/*
#-----------------------------------------------------------------------------
# DESCRIPTION:
# THIS VIEW PROVIDES INVENTORY AND STOCK CORRECTION DATA ON STORE/DAY/ITEM_1 LEVEL.
#
#----------------------------------------------------------------------------
# HISTORY:
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT
#
#----------------------------------------------------------------------------
*/
SELECT   DAT_FORMDATE
       , CLIENT_ID
       , REQUEST_ID
       , LOC_SID_WH
       , MOVE_TO_STORE_ID
       , ASPECT_ID
       , CURRENCY_ISO_CD
       , CURR_TOT_ID
       , REQUEST_LIST_ID
       , INV_TYPE_ID
       , STOCK_CORR_REQ_STATUS_ID
       , ITEM_SID
       , CNT_REASON_ID
       , ACT_ITEM_CNT
       , SOLL_BESTAND
       , KORREKTURMENGE
       , PRICE_RETAIL_NETTO
       , KORREKTURWERT
       , INV_CNT
  FROM P_LEW_MART_LEAD.V_TIV_ITEM_STORE_DAY_COUNT_1
;