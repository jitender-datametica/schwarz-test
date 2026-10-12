/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.v_cal_cy_month_week_rohertragsletter_1
#----------------------------------------------------------------------------
# History:
#  1.0  26.04.2021    Marcin Malec             Created
#                                              https://jira.schwarz/browse/REP2-9469
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_cy_month_week_rohertragsletter_1 (cy_week, week_in_mth,
cy_month_rohertragsletter, cy_month_sequence, cy_week_sequence) AS SELECT cy_week,
 week_in_mth,
 cy_month_rohertragsletter,
 cy_month_sequence,
 cy_week_sequence
FROM ldl_p_lew_mart_msi.v_cal_cy_month_week_rohertragsletter_1;