/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            1:1 DDL
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2022-02-25 Patrick Mittler         Initial version
#                                         INC4011778_add_null_logic
#                                         User Story 290471
#  1.1 2022-17-08 Marcin Kikola           Removal of unnecesary columns, 
#                                         adding comments and renaming of dwh_inserted column 
#
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Object DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_store_open_week_1 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifer for client.'), store_id OPTIONS(description='Identifer for store.'), move_to_store_id
OPTIONS(description='Store ID'), cy_week OPTIONS(description='Identifer for week.'), harmo_cal_week_no
OPTIONS(description='Harmonized week no  per country_1 - week since rollout'), adjust_growth_fg
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
OPTIONS(DESCRIPTION = `LIDLPLUS : STORE OPEN DURING WEEKS FLAGS`) AS SELECT aspect_id,
 client_id,
 store_id,
 move_to_store_id,
 cy_week,
 harmo_cal_week_no,
 adjust_growth_fg,
 cw_wk_ending_str_open_fg,
 cw_wk_anytime_str_open_fg,
 cw_wk_alltime_str_open_fg,
 pw_wk_ending_str_open_fg,
 pw_wk_anytime_str_open_fg,
 pw_wk_alltime_str_open_fg,
 pyw_wk_ending_str_open_fg,
 pyw_wk_anytime_str_open_fg,
 pyw_wk_alltime_str_open_fg,
 last_data_day_str_open_fg,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_store_open_week_1;