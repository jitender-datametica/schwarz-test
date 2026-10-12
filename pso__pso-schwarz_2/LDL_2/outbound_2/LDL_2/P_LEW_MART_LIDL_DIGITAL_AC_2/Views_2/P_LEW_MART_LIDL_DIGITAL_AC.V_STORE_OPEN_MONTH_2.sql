/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: 20181203_1895_Update_Fixes_LidlPlus
#            DDL for v_store_open_month_2
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
#                                         add columns: aspect_id, move_to_store_id, harmo_cal_month_no, pym_mth_ending_str_open_fg, pym_mth_anytime_str_open_fg, pym_mth_alltime_str_open_fg
#                                         rename prev_mth_ to pm_mth, mth to cm_mth
#  1.3 2022-02-25 Patrick Mittler         INC4011778_add_null_logic
#                                         Userstory 290471
#  1.4 2022-17-08 Marcin Kikola           Removal of unnecesary columns, 
#                                         adding comments and renaming of dwh_inserted column 
#
#----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_store_open_month_2 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifer for client.'), store_id OPTIONS(description='Identifer for store.'), move_to_store_id
OPTIONS(description='Store ID'), cy_month OPTIONS(description='Identifer for month.'), harmo_cal_month_no
OPTIONS(description='Harmonized month no  per country_2 - month since rollout'), adjust_growth_fg
OPTIONS(description='Flag used to differentiate between bereinigte and unbereinigte values for metrics'),
cm_mth_ending_str_open_fg OPTIONS(description='Store open at month end flag.'), cm_mth_anytime_str_open_fg
OPTIONS(description='Store open any day during the month flag.'), cm_mth_alltime_str_open_fg
OPTIONS(description='Store open every day during the month flag.'), pm_mth_ending_str_open_fg
OPTIONS(description='Store open at previous month end flag.'), pm_mth_anytime_str_open_fg
OPTIONS(description='Store open any day during the previous month flag.'), pm_mth_alltime_str_open_fg
OPTIONS(description='Store open every day during the previous month flag.'), pym_mth_ending_str_open_fg
OPTIONS(description='Store open at previous year month end flag.'), pym_mth_anytime_str_open_fg
OPTIONS(description='Store open any day during the previous year month flag.'), pym_mth_alltime_str_open_fg
OPTIONS(description='Store open every day during the previous year month flag.'), last_data_day_str_open_fg
OPTIONS(description='Store open last day of the available data in v_lead_store_master_data_day. Can be used if partially through the current month.'),
load_id OPTIONS(description='Load identifier.'), dwh_created OPTIONS(description='DWH record created timestamp.'),
dwh_updated OPTIONS(description='DWH record updated timestamp.'))
OPTIONS(DESCRIPTION = ` LIDLPLUS VIEW  : STORE OPEN DURING MONTH FLAGS`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_store_open_month_2;