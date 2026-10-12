/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: LidlPlus Application metrics
#            DDL for t_agg_app_store_ldpl_day
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-08-10 Barbara Seneta          Initial version - SD-1006
#  1.1 2020-12-03 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Add column 
#                                                   harmo_cal_day_no
#                                                   adjust_growth_fg
#----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_app_store_ldpl_day (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
harmo_cal_day_no BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adjust_growth_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
org_lvl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Organisiation level identifier'),
tm_lvl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Time level identifier'),
app_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for application'),
app_name STRING(100) OPTIONS(description='Application name'),
app_store_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for application store'),
app_store_name STRING(100) OPTIONS(description='Application store name'),
country_pol_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='unique identifier of the Country in which the events happened, i.e. where the user had been when he/she downloaded, uninstalled, etc.'),
download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before '),
total_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - in total from LidlPlus rollout date'),
redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app'),
total_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - in total from LidlPlus rollout date'),
update_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was updated'),
total_update_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was updated - in total from LidlPlus rollout date'),
uninstall_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was uninstalled'),
total_uninstall_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was uninstalled - in total from LidlPlus rollout date'),
return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was \u00E2\u20AC\u0153returned\u00E2\u20AC\uFFFD (only relevant for apps that the customer needs to pay for)'),
total_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was \u00E2\u20AC\u0153returned\u00E2\u20AC\uFFFD (only relevant for apps that the customer needs to pay for) - in total from LidlPlus rollout date'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_inserted DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time')
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Lidlplus : Table which contains application metrics on daily level');