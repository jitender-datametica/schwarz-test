/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20181203_1895_Update_Fixes_LidlPlus
#            DDL for v_store_open_py_partial_week
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2019-01-03 LEAD Reporting team 2   Initial version
#                                         20181203_1895_Update_Fixes_LidlPlus
#  1.1 2019-04-28 Tris Bayliff            Standardise DDL
#                                         20190405_2026_KPI_PPM_LidlPlus_Mgmt_Rep
#  1.2 2020-05-06 Barbara Seneta          Renamed columns to py_week, py_week_part, py_week_partial_week_id, py_partial_week_name
#
#  1.3 2022-17-08 Marcin Kikola           Removal of unnecesary columns, 
#                                         adding comments and renaming of dwh_inserted column 

#----------------------------------------------------------------------------
*/




/* ==============================================================================
   View DDL
   ============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_store_open_py_partial_week
COMMENT = ' LidlPlus view : Store open during py partial weeks flags'
(
  CLIENT_ID COMMENT 'Identifer for client.'
, STORE_ID COMMENT 'Identifer for store.'
, PY_WEEK COMMENT 'Identifer for previous year week.'
, PY_WEEK_PART COMMENT 'Previous year partial week.'
, PY_WEEK_PARTIAL_WEEK_ID COMMENT 'Identifier for previous year partial week.'
, PY_PARTIAL_WEEK_NAME COMMENT 'Description for partial week.'
, PARTIAL_WK_ENDING_STR_OPEN_FG  COMMENT 'Store open at previous year parialweek end flag.'
, PARTIAL_WK_ANYTIME_STR_OPEN_FG COMMENT 'Store open any day during at previous year parialweek flag.'
, PARTIAL_WK_ALLTIME_STR_OPEN_FG COMMENT 'Store open every day at previous year parialweek flag.'
, LAST_DATA_DAY_STR_OPEN_FG COMMENT 'Store open last day of the available data in v_lead_store_master_data_day.'
, LOAD_ID COMMENT 'Load identifier.'
, DWH_CREATED COMMENT 'DWH record created timestamp.'
, DWH_UPDATED COMMENT 'DWH record updated timestamp.'
)
AS 
SELECT
  CLIENT_ID
, STORE_ID
, PY_WEEK
, PY_WEEK_PART
, PY_WEEK_PARTIAL_WEEK_ID
, PY_PARTIAL_WEEK_NAME
, PARTIAL_WK_ENDING_STR_OPEN_FG
, PARTIAL_WK_ANYTIME_STR_OPEN_FG
, PARTIAL_WK_ALLTIME_STR_OPEN_FG
, LAST_DATA_DAY_STR_OPEN_FG
, LOAD_ID
, DWH_CREATED
, DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.T_STORE_OPEN_PY_PARTIAL_WEEK
;
