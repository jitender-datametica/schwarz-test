/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface:    DDL for v_store_open_day_2
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

CREATE OR REPLACE VIEW  P_LEW_MART_LIDL_DIGITAL_AC.V_STORE_OPEN_DAY_2 
COMMENT = ' LidlPlus view : Store open during day flags'
(
 ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
,CLIENT_ID COMMENT 'Identifer for client.'
,STORE_ID COMMENT 'Identifer for store.'
,MOVE_TO_STORE_ID COMMENT 'Store ID'
,DAT_CALENDAR COMMENT 'Data date'
,OPEN_STORE_FG COMMENT 'Store open flag. Includes the closing date of a store'
,CLOSED_STORE_FG COMMENT 'Store closing date flag. Indicates the last day when store operates'
,LOAD_ID COMMENT 'Load identifier.'
,DWH_CREATED COMMENT 'DWH record created timestamp.'
,DWH_UPDATED COMMENT 'DWH record updated timestamp.'
)
AS 
SELECT
 ASPECT_ID
,CLIENT_ID
,STORE_ID
,MOVE_TO_STORE_ID
,DAT_CALENDAR
,OPEN_STORE_FG
,CLOSED_STORE_FG
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_STORE_OPEN_DAY_2
;