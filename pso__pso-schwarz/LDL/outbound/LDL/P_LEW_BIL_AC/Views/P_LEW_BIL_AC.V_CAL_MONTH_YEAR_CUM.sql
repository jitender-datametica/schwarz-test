/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_CAL_MONTH_YEAR_CUM
#----------------------------------------------------------------------------
# History:
#  1.0  2021-09-27    Jaroslaw Syrokosz        Initial
#                                              20210921_2939_TransAllCal_updts
#                                              https://jira.schwarz/browse/REP2-10367
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_cal_month_year_cum (cy_month OPTIONS(description='Year and month identifier'),
cy_month_year_cum OPTIONS(description='Cumulative month'), cy_month_year_cum_py
OPTIONS(description='Cumulative month (previous year)'), cy_month_year_cum_ppy
OPTIONS(description='Cumulative month (previous, previous year)'))
OPTIONS(DESCRIPTION = `CALENDAR MONTH YEAR CUMULATIVE`) AS SELECT *
FROM ldl_p_lew_bil.v_cal_month_year_cum;