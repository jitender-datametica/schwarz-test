/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#
#  1.0 2022-05-30 Pawel Wieczorek         INC4728874 Initial version
#  1.1 2022-05-30 Pawel Wieczorek         INC4728874 changing column name to is_default_store and commet to wh_id
#  1.2 2022-06-07 Pawel Wieczorek         INC4728874 Changing comments
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_moved_store_ldpl_2 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), store_id OPTIONS(description='Store ID'), store_desc
OPTIONS(description='Store description'), move_to_store_id
OPTIONS(description='Move to store ID. If this wh_id with aspect_id 2 does not exist, default move_to_store_id is taken.'),
move_store_desc
OPTIONS(description='Move to store description. If this wh_id with aspect_id 2 does not exist, default move_store_desc is taken.'),
wh_id
OPTIONS(description='Warehouse ID. If this wh_id with aspect_id 2 does not exist, the warehouse of the default store (e.g. #DE) is taken.'),
is_default_store OPTIONS(description='Default store per country. O - no, 1 - yes'))
OPTIONS(DESCRIPTION = `MOVE TO STORE FOR LIDLPLUS - VERTRIEBSGESELLSCHAFT (ASPECT_ID = 2)`) AS SELECT aspect_id,
 client_id,
 store_id,
 move_store_desc AS store_desc,
 move_to_store_id,
 move_store_desc,
 wh_id,
 is_default_store
FROM ldl_p_lew_mart_lidl_digital.v_moved_store_ldpl_2;