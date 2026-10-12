/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_bil.T_SM_MAP_ITEM_CONTAINER_STR_1
#----------------------------------------------------------------------------
# History:
#  1.0  10.03.2022    Bachmann, Torsten        Initial version for SortimentsModularity
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_sm_map_item_container_str_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Landeskennzeichen'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer'),
loc_sid_wh BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key LOCATION_1 (eindeutig ueber alle Laender/Mandanten hinweg)'),
wh_id BIGNUMERIC(38,0) OPTIONS(description='WH ID from source (WAWI)'),
container_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key container'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store-Nr'),
aspect_id BIGNUMERIC(38,0) OPTIONS(description='only 1= BGES'),
dat_rec_start DATE OPTIONS(description='Gültigkeitsdatum von'),
dat_rec_end DATE OPTIONS(description='Gültigkeitsdatum bis')
) OPTIONS(description='Base Relation-Table for item_1 assignment to container on store level');