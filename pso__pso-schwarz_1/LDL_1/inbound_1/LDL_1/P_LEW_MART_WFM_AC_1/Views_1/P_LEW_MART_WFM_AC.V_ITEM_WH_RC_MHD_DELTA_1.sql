/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM_AC.V_ITEM_WH_RC_MHD_DELTA_1
#----------------------------------------------------------------------------
# History:
#  1.0  20.03.2023    Ulrich Ross               Init, User Story 455584 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_ITEM_WH_RC_MHD_DELTA_1 COMMENT = 'Receiving' 
(
  client_id              COMMENT 'Landeskennzeichen'
 ,country_lidl_cd        COMMENT 'ISO-Code Land_1'
 ,wh_id                  COMMENT 'Warehouse'
 ,orig_item_nr           COMMENT 'Artikelnummer'
 ,receipt_date           COMMENT 'Eingangsdatum'
 ,dat_min_durability_rcv COMMENT 'Haltbarkeitsdatum'
 ,receive_piece_qty      COMMENT 'Wareneingaenge'
)
AS
SELECT
  client_id
 ,country_lidl_cd
 ,wh_id
 ,orig_item_nr
 ,receipt_date
 ,dat_min_durability_rcv
 ,receive_piece_qty
FROM P_LEW_MART_WFM.V_ITEM_WH_RC_MHD_DELTA_1
;