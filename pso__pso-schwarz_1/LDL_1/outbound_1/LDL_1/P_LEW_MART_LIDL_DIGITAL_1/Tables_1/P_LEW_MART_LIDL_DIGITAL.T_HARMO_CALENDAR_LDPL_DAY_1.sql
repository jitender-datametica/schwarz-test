/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: t_harmo_calendar_ldpl_day_1
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-11-17 Pawel Wieczork   Initial version 20201117_2664_harmo_cal SD-1544
#
#----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_harmo_calendar_ldpl_day_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The surrogate key for a WAWI client.'),
cal_dt DATE NOT NULL OPTIONS(description='Calendar_1 date'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Calendar_1 week'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Day 1 for harmonized calendar_1 per country_1'),
last_day_week_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Is this day the last day of the containing month? 0=No, 1=Yes, -1=Unknown    Flag]'),
last_day_month_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Is this day the last day of the containing week? 0=No, 1=Yes, -1=Unknown    Flag'),
harmo_start_dt DATE NOT NULL,
harmo_cal_day_no BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Harmonized day no per country_1 - day since rollout'),
harmo_cal_week_no BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Harmonized week no per country_1 - week since rollout'),
harmo_cal_month_no BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Harmonized month no per country_1 - month since rollout'),
harmo_cal_year_no BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Harmonized year no per country_1 - year since rollout'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_inserted DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time')
) OPTIONS(description='Lidl Plus Harmonized calendar_1');