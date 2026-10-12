/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_CAL_PREV_CY_SAMEWDAY.
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  16.09.2021    Jaroslaw Syrokosz        Change from CORE v_wawi_cal_prev_cy_samewday to BIL v_dim_cal_day
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_PREV_CY_SAMEWDAY
(
 dat_calendar
 , prev_cy_dat_calendar_samewday
 )
 AS 
 SELECT 
 cal_dt AS dat_calendar 
 , cal_dt_swday_prev_1y AS prev_cy_dat_calendar_samewday 
 FROM P_LEW_BIL_AC.V_DIM_CAL_DAY
 ;