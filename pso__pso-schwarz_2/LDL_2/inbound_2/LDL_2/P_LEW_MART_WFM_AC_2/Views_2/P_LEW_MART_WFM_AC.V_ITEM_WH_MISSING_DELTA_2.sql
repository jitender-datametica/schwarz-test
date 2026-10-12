/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM_AC.V_ITEM_WH_MISSING_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2021    Martin Murtenthaler        VTWG-334
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_ITEM_WH_MISSING_DELTA_2 COMMENT = 'Fehlartikel'
(
  client_id              COMMENT 'Landeskennzeichen'
 ,country_lidl_cd        COMMENT 'ISO-Code Land_2'
 ,wh_id                  COMMENT 'Warehouse'
 ,orig_item_nr           COMMENT 'Artikelnummer'
 ,dat_formdate           COMMENT 'Datum'
)
AS
SELECT
  client_id
 ,country_lidl_cd
 ,wh_id
 ,orig_item_nr
 ,dat_formdate
FROM P_LEW_MART_WFM.V_ITEM_WH_MISSING_DELTA_2
;