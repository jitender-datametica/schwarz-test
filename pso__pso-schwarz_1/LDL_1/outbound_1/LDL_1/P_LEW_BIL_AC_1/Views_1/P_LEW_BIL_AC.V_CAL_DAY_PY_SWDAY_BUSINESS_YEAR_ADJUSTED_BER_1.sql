/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : DDL for P_LEW_BIL_AC.V_CAL_DAY_PY_SWDAY_BUSINESS_YEAR_ADJUSTED_BER_1
#----------------------------------------------------------------------------
# History:
#  1.0  01.06.2021    Rekovsky, Marvin    Initial Version
#                                         20210526_2844_CalWeekBer_TransAll (REP1-14578)
#  2.0  02.16.2022    Jaroslaw Syrokosz   B-0011292A-AP0120280 added PPPY columns
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_ber_1 (cal_dt, cy_week_part,
prev_cy_dat_calendar_swd_ber, prev_prev_cy_dat_calendar_swd_ber, prev_prev_prev_cy_dat_calendar_swd_ber,
prev_cy_dat_calendar_swd_ber_cum, prev_prev_cy_dat_calendar_swd_ber_cum, prev_prev_prev_cy_dat_calendar_swd_ber_cum) AS
SELECT *
FROM ldl_p_lew_bil.v_cal_day_py_swday_business_year_adjusted_ber_1;