/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface:    DDL for v_store_open_day
#-----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- ------------------------------------
#  1.0 2022-07-29 Marcin Kikola           Initial version
#                                         Removal of unnecesary columns, 
#                                         adding comments and renaming of dwh_inserted column 
#  1.1 2022-11-07 Marcin Kikola           Change in the naming of flag columns                     
#-----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_store_open_day (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifer for client.'), store_id OPTIONS(description='Identifer for store.'), move_to_store_id
OPTIONS(description='Store ID'), dat_calendar OPTIONS(description='Data date'), open_store_fg
OPTIONS(description='Store open flag. Includes the closing date of a store'), closed_store_fg
OPTIONS(description='Store closing date flag. Indicates the last day when store operates'), load_id
OPTIONS(description='Load identifier.'), dwh_created OPTIONS(description='DWH record created timestamp.'), dwh_updated
OPTIONS(description='DWH record updated timestamp.'))
OPTIONS(DESCRIPTION = ` LIDLPLUS VIEW : STORE OPEN DURING DAY FLAGS`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_store_open_day;