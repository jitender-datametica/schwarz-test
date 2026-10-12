/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_CAL_WEEK_BER
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  20.02.2020    Tris Bayliff             20200221_2392_Cumulative_Cal
#                                              Add column for running total cumulative calculations
#  1.4  14.04.2021    Michael Ueding           Attributs ergaenzt:
#                                              - "prev_prev_cy_dat_calendar_swd_ber" und "prev_prev_cy_dat_calendar_swd_ber_cum"
#  1.5  01.06.2021    Rekovsky, Marvin         20210601_2848_CalWeekBer_TransAll (REP1-14578) - Change mapping to BIL-Layer
#  1.6  02.16.2022    Jaroslaw Syrokosz        B-0011292A-AP0120280 added PPPY columns
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_WEEK_BER
(
    DAT_CALENDAR
  , PREV_CY_DAT_CALENDAR_SWD_BER
  , PREV_PREV_CY_DAT_CALENDAR_SWD_BER
  , PREV_PREV_PREV_CY_DAT_CALENDAR_SWD_BER
  , PREV_CY_DAT_CALENDAR_SWD_BER_CUM
  , PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM
  , PREV_PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM
)
AS 
  SELECT
      CAL_DT AS DAT_CALENDAR
    , PREV_CY_DAT_CALENDAR_SWD_BER
    , PREV_PREV_CY_DAT_CALENDAR_SWD_BER
    , PREV_PREV_PREV_CY_DAT_CALENDAR_SWD_BER
    , PREV_CY_DAT_CALENDAR_SWD_BER_CUM
    , PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM
    , PREV_PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM
FROM p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_ber
;