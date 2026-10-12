/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: 20181203_1895_Update_Fixes_LidlPlus
#            DDL for t_store_open_week_1
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
#  1.3 2022-17-08 Marcin Kikola           Removal of unnecesary columns, 
#                                         adding comments and renaming of dwh_inserted column 
#
#----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_store_open_week_1 (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifer for client.'),
store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifer for store.'),
move_to_store_id BIGNUMERIC(38,0) OPTIONS(description='Store ID'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifer for week.'),
harmo_cal_week_no BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Harmonized week no  per country_1 - week since rollout'),
adjust_growth_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag used to differentiate between bereinigte and unbereinigte values for metrics'),
cw_wk_ending_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open at week end flag.'),
cw_wk_anytime_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open any day during the week flag.'),
cw_wk_alltime_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open every day during the week flag.'),
pw_wk_ending_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open at previous week end flag.'),
pw_wk_anytime_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open any day during the previous week flag.'),
pw_wk_alltime_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open every day during the previous week flag.'),
pyw_wk_ending_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open at previous yeasr week end flag.'),
pyw_wk_anytime_str_open_fg BIGNUMERIC(38,0)
OPTIONS(description='Store open any day during the previous year week flag.'),
pyw_wk_alltime_str_open_fg BIGNUMERIC(38,0)
OPTIONS(description='Store open every day during the previous year week flag.'),
last_data_day_str_open_fg BIGNUMERIC(38,0)
OPTIONS(description='Store open last day of the available data in v_lead_store_master_data_day. Can be used if partially through the current week.'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier.'),
dwh_created DATETIME NOT NULL OPTIONS(description='DWH record created timestamp.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='DWH record updated timestamp.'),
PRIMARY KEY (client_id, store_id, cy_week) NOT ENFORCED
) OPTIONS(description='LidlPlus : Store open during week flags');