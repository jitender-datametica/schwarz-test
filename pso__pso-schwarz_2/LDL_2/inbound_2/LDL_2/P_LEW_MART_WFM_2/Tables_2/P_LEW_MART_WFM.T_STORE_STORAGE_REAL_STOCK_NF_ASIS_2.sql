/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.T_STORE_STORAGE_REAL_STOCK_NF_ASIS_2 
#----------------------------------------------------------------------------
# History:
#  1.0  06.07.2023    Ulrich Ross        User Story 490502, Init 
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_WFM.T_STORE_STORAGE_REAL_STOCK_NF_ASIS_2 COMMENT='Bestand Filiale NF (verkaufsflaeche)'
(
   client_id                      NUMBER(38,0) NOT NULL COMMENT 'Landeskennung'
  ,country_lidl_cd                VARCHAR(20)  NOT NULL COMMENT 'ISO-Code Land_2'
  ,orig_store_nr                  NUMBER(38,0) NOT NULL COMMENT 'Filiale Nr'
  ,loc_sid                        NUMBER(38,0) NOT NULL COMMENT 'Filiale ID'
  ,wh_id                          NUMBER(38,0) NOT NULL COMMENT 'Lager Nr'
  ,orig_item_nr                   NUMBER(38,0) NOT NULL COMMENT 'Artikel_2 Nr'
  ,item_sid                       NUMBER(38,0) NOT NULL COMMENT 'Artikel_2 ID'
  ,stock_real_qty                 NUMBER(38,5)          COMMENT 'Bestand der Filiale'
  ,valid_from_stockreal           DATE                  COMMENT 'Datum von aktueller Bestand'
  ,valid_to_stockreal             DATE                  COMMENT 'Datum bis aktueller Bestand'  
  ,store_storage_qty              NUMBER(38,5)          COMMENT 'Bestand Lager der Filiale'
  ,valid_from_storestorage        DATE                  COMMENT 'Datum von Lager Filiale'
  ,valid_to_storestorage          DATE                  COMMENT 'Datum bis Lager Filiale'
  ,update_date                    DATETIME              COMMENT 'Datum Datensatz eingefuegt'
  ,insert_date                    DATETIME              COMMENT 'Datum Datensatz update'

);