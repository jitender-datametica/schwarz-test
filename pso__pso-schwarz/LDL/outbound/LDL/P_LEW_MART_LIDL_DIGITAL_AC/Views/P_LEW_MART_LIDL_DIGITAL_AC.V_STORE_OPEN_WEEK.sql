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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_store_open_week (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifer for client.'), store_id OPTIONS(description='Identifer for store.'), move_to_store_id
OPTIONS(description='Store ID'), cy_week OPTIONS(description='Identifer for week.'), harmo_cal_week_no
OPTIONS(description='Harmonized week no  per country - week since rollout'), adjust_growth_fg
OPTIONS(description='Flag used to differentiate between bereinigte and unbereinigte values for metrics'),
cw_wk_ending_str_open_fg OPTIONS(description='Store open at week end flag.'), cw_wk_anytime_str_open_fg
OPTIONS(description='Store open any day during the week flag.'), cw_wk_alltime_str_open_fg
OPTIONS(description='Store open every day during the week flag.'), pw_wk_ending_str_open_fg
OPTIONS(description='Store open at previous week end flag.'), pw_wk_anytime_str_open_fg
OPTIONS(description='Store open any day during the previous week flag.'), pw_wk_alltime_str_open_fg
OPTIONS(description='Store open every day during the previous week flag.'), pyw_wk_ending_str_open_fg
OPTIONS(description='Store open at previous yeasr week end flag.'), pyw_wk_anytime_str_open_fg
OPTIONS(description='Store open any day during the previous year week flag.'), pyw_wk_alltime_str_open_fg
OPTIONS(description='Store open every day during the previous year week flag.'), last_data_day_str_open_fg
OPTIONS(description='Store open last day of the available data in v_lead_store_master_data_day. Can be used if partially through the current week.'),
load_id OPTIONS(description='Load identifier.'), dwh_created OPTIONS(description='DWH record created timestamp.'),
dwh_updated OPTIONS(description='DWH record updated timestamp.'))
OPTIONS(DESCRIPTION = ` LIDLPLUS VIEW  : STORE OPEN DURING WEEK FLAGS`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_store_open_week;