/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20181203_1895_Update_Fixes_LidlPlus
#            DDL for v_store_open_week
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
#  1.2 2021-02-05 Pawel Wieczorek         SD-1862 20210205_2737_harmo_cal_2
#                                         add columns: aspect_id, move_to_store_id, harmo_cal_week_no, pyw_wk_ending_str_open_fg, pyw_wk_anytime_str_open_fg, pyw_wk_alltime_str_open_fg
#                                         rename prev_wk_ to pw_wk, mth to cw_wk
#  1.3 2022-02-25 Patrick Mittler         INC4011778_add_null_logic
#                                         Userstory 290471
#  1.4 2022-17-08 Marcin Kikola           Removal of unnecesary columns, 
#                                         adding comments and renaming of dwh_inserted column 
#
#----------------------------------------------------------------------------
*/




/* ==============================================================================
   View DDL
   ============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_STORE_OPEN_WEEK
COMMENT = ' LidlPlus view  : Store open during week flags'
(
 ASPECT_ID COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
,CLIENT_ID COMMENT 'Identifer for client.'
,STORE_ID COMMENT 'Identifer for store.'
,MOVE_TO_STORE_ID COMMENT 'Store ID'
,CY_WEEK COMMENT 'Identifer for week.'
,HARMO_CAL_WEEK_NO COMMENT 'Harmonized week no  per country - week since rollout'
,ADJUST_GROWTH_FG COMMENT 'Flag used to differentiate between bereinigte and unbereinigte values for metrics'
,CW_WK_ENDING_STR_OPEN_FG COMMENT 'Store open at week end flag.'
,CW_WK_ANYTIME_STR_OPEN_FG COMMENT 'Store open any day during the week flag.'
,CW_WK_ALLTIME_STR_OPEN_FG COMMENT 'Store open every day during the week flag.'
,PW_WK_ENDING_STR_OPEN_FG COMMENT 'Store open at previous week end flag.'
,PW_WK_ANYTIME_STR_OPEN_FG COMMENT 'Store open any day during the previous week flag.'
,PW_WK_ALLTIME_STR_OPEN_FG COMMENT 'Store open every day during the previous week flag.'
,PYW_WK_ENDING_STR_OPEN_FG COMMENT 'Store open at previous yeasr week end flag.'
,PYW_WK_ANYTIME_STR_OPEN_FG COMMENT 'Store open any day during the previous year week flag.'
,PYW_WK_ALLTIME_STR_OPEN_FG COMMENT 'Store open every day during the previous year week flag.'
,LAST_DATA_DAY_STR_OPEN_FG COMMENT 'Store open last day of the available data in v_lead_store_master_data_day. Can be used if partially through the current week.'
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
,CY_WEEK
,HARMO_CAL_WEEK_NO
,ADJUST_GROWTH_FG
,CW_WK_ENDING_STR_OPEN_FG
,CW_WK_ANYTIME_STR_OPEN_FG 
,CW_WK_ALLTIME_STR_OPEN_FG 
,PW_WK_ENDING_STR_OPEN_FG
,PW_WK_ANYTIME_STR_OPEN_FG 
,PW_WK_ALLTIME_STR_OPEN_FG 
,PYW_WK_ENDING_STR_OPEN_FG
,PYW_WK_ANYTIME_STR_OPEN_FG
,PYW_WK_ALLTIME_STR_OPEN_FG
,LAST_DATA_DAY_STR_OPEN_FG 
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_STORE_OPEN_WEEK
;

