/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface:        DDL for t_store_open_partial_week_1
#-----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2019-01-03 Barbara Senata          Initial version
#
#  1.1 2022-17-08 Marcin Kikola           Removal of unnecesary columns, 
#                                         adding comments and renaming of dwh_inserted column 
#  
#----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_store_open_py_partial_week_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifer for client.'),
store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifer for store.'),
py_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifer for previous year week.'),
py_week_part BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Previous year partial week.'),
py_week_partial_week_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for previous year partial week.'),
py_partial_week_name STRING(27) OPTIONS(description='Description for partial week.'),
partial_wk_ending_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open at previous year partialweek end flag.'),
partial_wk_anytime_str_open_fg BIGNUMERIC(38,0)
OPTIONS(description='Store open any day during at previous year partialweek flag.'),
partial_wk_alltime_str_open_fg BIGNUMERIC(38,0)
OPTIONS(description='Store open every day at previous year partialweek flag.'),
last_data_day_str_open_fg BIGNUMERIC(38,0)
OPTIONS(description='Store open last day of the available data in v_lead_store_master_data_day.'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier.'),
dwh_created DATETIME NOT NULL OPTIONS(description='DWH record created timestamp.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='DWH record updated timestamp.'),
PRIMARY KEY (client_id, store_id, py_week_partial_week_id) NOT ENFORCED
) OPTIONS(description=' LidlPlus table : Store open during previous year partial weeks flags');