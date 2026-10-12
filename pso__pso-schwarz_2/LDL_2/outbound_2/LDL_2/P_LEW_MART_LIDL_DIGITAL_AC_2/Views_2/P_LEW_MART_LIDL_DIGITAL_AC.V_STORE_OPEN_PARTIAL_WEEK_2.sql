/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20181203_1895_Update_Fixes_LidlPlus
#            DDL for v_store_open_partial_week_2
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
#
#  1.2 2022-17-08 Marcin Kikola           Removal of unnecesary columns, 
#                                         adding comments and renaming of dwh_inserted column 

#----------------------------------------------------------------------------
*/




/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_store_open_partial_week_2 (client_id
OPTIONS(description='Identifer for client.'), store_id OPTIONS(description='Identifer for store.'), cy_week
OPTIONS(description='Identifer for week.'), cy_week_part OPTIONS(description='Partial week.'), cy_week_partial_week_id
OPTIONS(description='Identifier for partial week.'), cy_partial_week_name
OPTIONS(description='Description for partial week.'), partial_wk_ending_str_open_fg
OPTIONS(description='Store open at current parialweek end flag.'), partial_wk_anytime_str_open_fg
OPTIONS(description='Store open any day during at current parialweek flag.'), partial_wk_alltime_str_open_fg
OPTIONS(description='Store open every day at current parialweek flag.'), last_data_day_str_open_fg
OPTIONS(description='Store open last day of the available data in v_lead_store_master_data_day.'), load_id
OPTIONS(description='Load identifier.'), dwh_created OPTIONS(description='DWH record created timestamp.'), dwh_updated
OPTIONS(description='DWH record updated timestamp.'))
OPTIONS(DESCRIPTION = ` LIDLPLUS VIEW : STORE OPEN DURING PARTIAL WEEKS FLAGS`) AS SELECT client_id,
 store_id,
 cy_week,
 cy_week_part,
 cy_week_partial_week_id,
 cy_partial_week_name,
 partial_wk_ending_str_open_fg,
 partial_wk_anytime_str_open_fg,
 partial_wk_alltime_str_open_fg,
 last_data_day_str_open_fg,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_store_open_partial_week_2;