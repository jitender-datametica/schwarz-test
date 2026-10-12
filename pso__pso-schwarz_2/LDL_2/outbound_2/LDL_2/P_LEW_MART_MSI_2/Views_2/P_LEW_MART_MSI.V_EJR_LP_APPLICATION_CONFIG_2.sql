/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_LP_APPLICATION_CONFIG_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  27.02.2019    Florence Sklenarz        20190228_1975_ZKP_cnt_allow_wh_DWHSup - Change cnt_allow_wh from 10 to 12
#  1.4  24.01.2023    Andrzej Wandtke          AP0158847 - Change cnt_allow_wh from 12 to 15
#  1.5  18.12.2023    Andrzej Wandtke          AP0191702 - Change cnt_allow_wh from 15 to 20
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_lp_application_config_2 AS SELECT 20 AS cnt_allow_wh,
 10 AS cnt_allow_branch,
 18 AS last_entry_hour,
 0 AS last_entry_minute,
  MOD(DATE_DIFF(CURRENT_DATE, DATE '1900-01-01', DAY), 7) + 1 AS act_day_of_week,
 EXTRACT(HOUR FROM CURRENT_TIME) AS act_hour,
 EXTRACT(MINUTE FROM CURRENT_TIME) AS act_minute;