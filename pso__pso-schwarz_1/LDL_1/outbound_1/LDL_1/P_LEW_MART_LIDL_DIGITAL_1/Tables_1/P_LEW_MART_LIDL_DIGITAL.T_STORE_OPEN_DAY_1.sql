/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface:    DDL for t_store_open_day_1
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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_store_open_day_1 (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifer for client.'),
store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifer for store.'),
move_to_store_id BIGNUMERIC(38,0) OPTIONS(description='Store ID'),
dat_calendar DATE NOT NULL OPTIONS(description='Data date'),
open_store_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag. Includes the closing date of a store'),
closed_store_fg BIGNUMERIC(38,0)
OPTIONS(description='Store closing date flag. Indicates the last day when store operates'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier.'),
dwh_created DATETIME NOT NULL OPTIONS(description='DWH record created timestamp.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='DWH record updated timestamp.'),
PRIMARY KEY (client_id, store_id, dat_calendar) NOT ENFORCED
) OPTIONS(description='LidlPlus : Store open through days flags');