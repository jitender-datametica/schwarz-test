/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: LidlPlus Application metrics
#            DDL for t_agg_app_store_ldpl_wk_1
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-08-10 Barbara Seneta          Initial version - SD-1006
#  1.1 2020-11-25 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Add column
#                                                   harmo_cal_week_no
#                                                   adjust_growth_fg
#  1.3 2021-05-06 Pawel Wieczorek         [SF] Remove cluster the same way as it is in P_LEW_MART_LIDL_DIGITAL_AC_MATERIALIZED
#
#----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_app_store_ldpl_wk_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Current Year Week'),
harmo_cal_week_no BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Harmonized week no per country_1 - week since rollout'),
adjust_growth_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
org_lvl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Organisiation level identifier'),
tm_lvl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Time level identifier'),
app_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for application'),
app_name STRING(100) OPTIONS(description='Application name'),
app_store_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for application store'),
app_store_name STRING(100) OPTIONS(description='Application store name'),
country_pol_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='unique identifier of the Country_1 in which the events happened, i.e. where the user had been when he/she downloaded, uninstalled, etc.'),
cw_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - current week'),
pw_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - previous week'),
pyw_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - week in previous year'),
cw_total_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - current week, in total from LidlPlus rollout date'),
pw_total_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - previous week, in total from LidlPlus rollout date'),
pyw_total_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - week in previous year, in total from LidlPlus rollout date'),
cw_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - current week'),
pw_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - previous week'),
pyw_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - week in previous year'),
cw_total_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - current week, in total from LidlPlus rollout date'),
pw_total_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - previous week, in total from LidlPlus rollout date'),
pyw_total_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - week in previous year, in total from LidlPlus rollout date'),
cw_update_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was updated - current week'),
pw_update_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was updated - previous week'),
pyw_update_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was updated - week in previous year'),
cw_total_update_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was updated - current week, in total from LidlPlus rollout date'),
pw_total_update_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was updated - previous week, in total from LidlPlus rollout date'),
pyw_total_update_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was updated - week in previous year, in total from LidlPlus rollout date'),
cw_uninstall_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was uninstalled - current week'),
pw_uninstall_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was uninstalled - previous week'),
pyw_uninstall_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was uninstalled - week in previous year'),
cw_total_uninstall_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was uninstalled - current week, in total from LidlPlus rollout date'),
pw_total_uninstall_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was uninstalled - previous week, in total from LidlPlus rollout date'),
pyw_total_uninstall_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was uninstalled - week in previous year, in total from LidlPlus rollout date'),
cw_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was \u00E2\u20AC\u0153returned\u00E2\u20AC\uFFFD (only relevant for apps that the customer needs to pay for) - current week'),
pw_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was \u00E2\u20AC\u0153returned\u00E2\u20AC\uFFFD (only relevant for apps that the customer needs to pay for) - previous week'),
pyw_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was \u00E2\u20AC\u0153returned\u00E2\u20AC\uFFFD (only relevant for apps that the customer needs to pay for) - week in previous year'),
cw_total_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was \u00E2\u20AC\u0153returned\u00E2\u20AC\uFFFD (only relevant for apps that the customer needs to pay for) - current week, in total from LidlPlus rollout date'),
pw_total_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was \u00E2\u20AC\u0153returned\u00E2\u20AC\uFFFD (only relevant for apps that the customer needs to pay for) - previous week, in total from LidlPlus rollout date'),
pyw_total_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was \u00E2\u20AC\u0153returned\u00E2\u20AC\uFFFD (only relevant for apps that the customer needs to pay for) - week in previous year, in total from LidlPlus rollout date'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_inserted DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time')
) OPTIONS(description='Lidlplus : Table which contains application metrics on weekly level');