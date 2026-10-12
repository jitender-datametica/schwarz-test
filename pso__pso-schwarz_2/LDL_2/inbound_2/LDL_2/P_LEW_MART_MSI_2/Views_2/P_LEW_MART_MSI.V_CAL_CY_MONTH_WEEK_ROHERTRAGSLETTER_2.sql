/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_CAL_CY_MONTH_WEEK_ROHERTRAGSLETTER_2
#----------------------------------------------------------------------------
# History:
#  1.0  26.04.2021    Marcin Malec             Created
#                                              https://jira.schwarz/browse/REP2-9469
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_CY_MONTH_WEEK_ROHERTRAGSLETTER_2 AS 
    SELECT 
        a11.cy_week
        , a11.partialweek_in_mth_seq_asc AS week_in_mth
        , CASE WHEN (a11.partialweek_in_mth_seq_asc = 1 AND a13.cy_week_sequence = 0) THEN a11.cy_month - 1 
             ELSE a11.cy_month END AS cy_month_rohertragsletter
        , (SELECT cweek.partialweek_in_mth_seq_asc
                FROM P_LEW_MART_MSI_AC.v_cal_calendarday_2 cday
                INNER JOIN P_LEW_MART_MSI_AC.v_cal_partial_week_2 cweek
                ON  cday.cy_week  = cweek.cy_week
                AND cday.cy_month = cweek.cy_month
                WHERE cday.cy_day_sequence = 0
          ) AS week_in_mth_current_seq     
        , CASE WHEN (week_in_mth_current_seq = 1 AND a12.cy_month_sequence < 0) THEN a12.cy_month_sequence + 1
             ELSE a12.cy_month_sequence END AS cy_month_sequence
        , a13.cy_week_sequence
    FROM P_LEW_MART_MSI_AC.v_cal_partial_week_2 AS a11

    INNER JOIN P_LEW_MART_MSI_AC.v_cal_month_2 AS a12
    ON a11.cy_month = a12.cy_month

    INNER JOIN P_LEW_MART_MSI_AC.v_cal_week_2 AS a13
    ON a11.cy_week = a13.cy_week
;