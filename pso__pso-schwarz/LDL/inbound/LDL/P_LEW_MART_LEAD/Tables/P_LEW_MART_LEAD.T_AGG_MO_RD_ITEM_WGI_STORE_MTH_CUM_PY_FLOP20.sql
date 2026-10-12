/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_DAY_FLOP20
#----------------------------------------------------------------------------
# History:
#  1.0  20-09-2023     Stefan Sockel         Initial version of Redesign
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_MTH_CUM_PY_FLOP20 CLUSTER BY (CLIENT_ID, CY_WEEK_PARTIAL_WEEK_ID) COMMENT = 'Aggregierte Abschriften - Schlüssel: client_id/orig_store_nr/dat_formdate'

(
  CLIENT_ID                         INTEGER             NOT NULL        COMMENT 'MIS CLIENT ID'  
, MOVE_TO_STORE_ID                  INTEGER             NOT NULL        COMMENT 'S-KEY DER LOCATION, HIER DER FILIALE'
, ASPECT_ID                         INTEGER             NOT NULL        COMMENT 'GESELLSCHAFTSFORM (1 = BETRIEBS- 2 = VERTRIEBSGESELLSCHAFT)'
, ORIG_ITEM_NR                      INTEGER             NOT NULL        COMMENT 'URSPRÜNGLICHE ARTIKELNUMMER (FACHLICHER SCHLÜSSEL)'
, DAT_VALID_FROM                    DATE                NOT NULL        COMMENT 'STARTDATUM DER VALIDITÄT FÜR ARTIKEL'
, CY_WEEK_PARTIAL_WEEK_ID           INTEGER             NOT NULL        COMMENT 'BEZUGSDATUM'    
, CURRENCY_ISO_CD                   VARCHAR(3)          COLLATE 'EN-CI' COMMENT '3 STELLIGER ISO-WÄHRUNGS-CODE'  
, VAL_RTL_NET_SFO_STORE_MTH_CUM_PY  DECIMAL(38,5)                       COMMENT 'TAGESSUMME DER ABSCHRIFTEN IN LANDESWÄHRUNG'
, VAL_RTL_NET_SFO_QTY_MTH_CUM_PY    DECIMAL(38,5)                       COMMENT 'TAGESSUMME DER ABSCHRIFTEN IN STK/KG'
, SALES_NET_VAL_MTH_CUM_PY          DECIMAL(38,5)                       COMMENT 'UMSATZ TAGESEBENE'
, VAL_RTL_NET_SFO_PCT_MTH_CUM_PY    DECIMAL(38,5)                       COMMENT 'TAGESSUMME DER ABSCHRIFTEN IN %'
, RANK_ITM_TOTAL                    INTEGER                             COMMENT 'RANG DES ARTIKELS OHNE WG-EBENE'
, DWH_UPDATED                       TIMESTAMP                           COMMENT 'TECHNISCHER ZEITSTEMPEL'  
)
;