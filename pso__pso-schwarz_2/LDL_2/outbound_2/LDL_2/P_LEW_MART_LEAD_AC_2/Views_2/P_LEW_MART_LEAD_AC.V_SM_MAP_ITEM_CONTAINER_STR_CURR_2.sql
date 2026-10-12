/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead_ac.V_SM_MAP_ITEM_CONTAINER_STR_CURR_2
#----------------------------------------------------------------------------
# History:
#  1.0  03.03.2022    Bachmann, Torsten        Initial version for SortimentsModularity
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_sm_map_item_container_str_curr_2 (client_id
OPTIONS(description='Landeskennzeichen'), item_sid OPTIONS(description='Artikelnummer'), loc_sid_wh
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender/Mandanten hinweg)'), wh_id
OPTIONS(description='WH ID from source (WAWI)'), container_id OPTIONS(description='Surrogate Key container'),
move_to_store_id OPTIONS(description='Store-Nr'), aspect_id OPTIONS(description='only 1= BGES'), dat_rec_start
OPTIONS(description='Gültigkeitsdatum von'), dat_rec_end OPTIONS(description='Gültigkeitsdatum bis')) AS SELECT *
FROM ldl_p_lew_bil_ac.v_sm_map_item_container_str_2
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end;