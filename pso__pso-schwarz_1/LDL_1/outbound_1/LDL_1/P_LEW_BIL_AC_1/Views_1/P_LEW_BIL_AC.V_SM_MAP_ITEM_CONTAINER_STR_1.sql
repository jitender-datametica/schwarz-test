/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_SM_MAP_ITEM_CONTAINER_STR_1
#----------------------------------------------------------------------------
# History:
#  1.0  10.03.2022    Bachmann, Torsten        Initial version for SortimentsModularity
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_sm_map_item_container_str_1 (client_id OPTIONS(description='Landeskennzeichen'),
item_sid OPTIONS(description='Artikelnummer'), loc_sid_wh
OPTIONS(description='Surrogate Key LOCATION_1 (eindeutig ueber alle Laender/Mandanten hinweg)'), wh_id
OPTIONS(description='WH ID from source (WAWI)'), container_id OPTIONS(description='Surrogate Key container'),
move_to_store_id OPTIONS(description='Store-Nr'), aspect_id OPTIONS(description='only 1= BGES'), dat_rec_start
OPTIONS(description='Gültigkeitsdatum von'), dat_rec_end OPTIONS(description='Gültigkeitsdatum bis')) AS SELECT
 client_id,
 item_sid,
 loc_sid_wh,
 wh_id,
 container_id,
 move_to_store_id,
 aspect_id,
 dat_rec_start,
 dat_rec_end
FROM ldl_p_lew_bil.t_sm_map_item_container_str_1;