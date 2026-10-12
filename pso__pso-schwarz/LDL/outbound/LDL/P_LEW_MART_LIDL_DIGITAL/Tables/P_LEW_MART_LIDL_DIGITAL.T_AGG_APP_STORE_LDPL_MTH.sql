/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: LidlPlus Application metrics
#            DDL for t_agg_app_store_ldpl_mth
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
#                                                   harmo_cal_month_no
#                                                   adjust_growth_fg - add to key
#  1.3 2021-05-06 Pawel Wieczorek         [SF] Remove cluster the same way as it is in P_LEW_MART_LIDL_DIGITAL_AC_MATERIALIZED
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_app_store_ldpl_mth (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Current Year Month'),
harmo_cal_month_no BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Harmonized month no  per country - month since rollout'),
adjust_growth_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
org_lvl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Organisiation level identifier'),
tm_lvl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Time level identifier'),
app_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for application'),
app_name STRING(100) OPTIONS(description='Application name'),
app_store_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for application store'),
app_store_name STRING(100) OPTIONS(description='Application store name'),
country_pol_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='unique identifier of the Country in which the events happened, i.e. where the user had been when he/she downloaded, uninstalled, etc.'),
cm_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - current month'),
pm_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - previous month'),
pym_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - month in previous year'),
cm_total_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - current month, in total from LidlPlus rollout date'),
pm_total_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - previous month, in total from LidlPlus rollout date'),
pym_total_download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before - month in previous year, in total from LidlPlus rollout date'),
cm_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - current month'),
pm_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - previous month'),
pym_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - month in previous year'),
cm_total_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - current month, in total from LidlPlus rollout date'),
pm_total_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - previous month, in total from LidlPlus rollout date'),
pym_total_redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app - month in previous year, in total from LidlPlus rollout date'),
cm_update_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was updated - current month'),
pm_update_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was updated - previous month'),
pym_update_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was updated - month in previous year'),
cm_total_update_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was updated - current month, in total from LidlPlus rollout date'),
pm_total_update_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was updated - previous month, in total from LidlPlus rollout date'),
pym_total_update_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was updated - month in previous year, in total from LidlPlus rollout date'),
cm_uninstall_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was uninstalled - current month'),
pm_uninstall_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was uninstalled - previous month'),
pym_uninstall_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was uninstalled - month in previous year'),
cm_total_uninstall_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was uninstalled - current month, in total from LidlPlus rollout date'),
pm_total_uninstall_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was uninstalled - previous month, in total from LidlPlus rollout date'),
pym_total_uninstall_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was uninstalled - month in previous year, in total from LidlPlus rollout date'),
cm_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was returned (only relevant for apps that the customer needs to pay for) - current month'),
pm_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was returned (only relevant for apps that the customer needs to pay for) - previous month'),
pym_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was returned (only relevant for apps that the customer needs to pay for) - month in previous year'),
cm_total_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was returned (only relevant for apps that the customer needs to pay for) - current month, in total from LidlPlus rollout date'),
pm_total_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was returned (only relevant for apps that the customer needs to pay for) - previous month, in total from LidlPlus rollout date'),
pym_total_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was returned (only relevant for apps that the customer needs to pay for) - month in previous year, in total from LidlPlus rollout date'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_inserted DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time')
) OPTIONS(description='Lidlplus : Table which contains application metrics on monthly level');