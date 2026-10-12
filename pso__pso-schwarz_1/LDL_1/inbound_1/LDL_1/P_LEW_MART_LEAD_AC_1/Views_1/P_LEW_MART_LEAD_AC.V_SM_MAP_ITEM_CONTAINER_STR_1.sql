/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead_ac.V_SM_MAP_ITEM_CONTAINER_STR_1
#----------------------------------------------------------------------------
# History:
#  1.0  03.03.2022    Bachmann, Torsten        Initial version for SortimentsModularity
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_SM_MAP_ITEM_CONTAINER_STR_1(
   client_id         COMMENT 'Landeskennzeichen'
,  item_sid          COMMENT 'Artikelnummer'
,  loc_sid_wh        COMMENT 'Surrogate Key LOCATION_1 (eindeutig ueber alle Laender/Mandanten hinweg)'
,  wh_id             COMMENT 'WH ID from source (WAWI)'
,  container_id      COMMENT 'Surrogate Key container'
,  move_to_store_id  COMMENT 'Store-Nr'
,  aspect_id         COMMENT 'only 1= BGES'
,  dat_rec_start     COMMENT 'Gültigkeitsdatum von'
,  dat_rec_end       COMMENT 'Gültigkeitsdatum bis'
) AS
SELECT
   client_id
,  item_sid
,  loc_sid_wh
,  wh_id
,  container_id
,  move_to_store_id
,  aspect_id
,  dat_rec_start
,  dat_rec_end
FROM P_LEW_BIL_AC.V_SM_MAP_ITEM_CONTAINER_STR_1
;
