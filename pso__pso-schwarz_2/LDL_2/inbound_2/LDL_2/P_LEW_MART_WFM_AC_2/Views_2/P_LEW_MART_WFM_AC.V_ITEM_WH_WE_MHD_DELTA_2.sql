/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM_AC.V_ITEM_WH_WE_MHD_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2021    Martin Murtenthaler        VTWG-334
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_ITEM_WH_WE_MHD_DELTA_2 COMMENT = 'Wareneingaenge'
(
  client_id              COMMENT 'Landeskennzeichen'
 ,country_lidl_cd        COMMENT 'ISO-Code Land_2'
 ,wh_id                  COMMENT 'Warehouse'
 ,orig_item_nr           COMMENT 'Artikelnummer'
 ,entry_dt               COMMENT 'Eingangsdatum'
 ,dat_min_durability_rcv COMMENT 'Haltbarkeitsdatum'
 ,receive_piece_qty      COMMENT 'Wareneingaenge'
)
AS
SELECT
  client_id
 ,country_lidl_cd
 ,wh_id
 ,orig_item_nr
 ,entry_dt
 ,dat_min_durability_rcv
 ,receive_piece_qty
FROM P_LEW_MART_WFM.V_ITEM_WH_WE_MHD_DELTA_2
;