/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_INV_STORE_DAY
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  23.04.2021    Rekovsky, Marvin         20210422_2813_TransAll_Shutdown_Update(REP1-14416): Replace legacy object
#                                              v_wawi_cal_calendarday with v_cal_calendarday
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_inv_store_day
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT ST.dat_valid_from,
 ST.client_id,
 ST.st_loc_sid AS store_id,
 CAL.cal_dt AS dat_formdate
FROM ldl_p_lew_core_ac.v_wawi_inv_store AS ST
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAL.cal_dt BETWEEN DATE_SUB(ST.dat_valid_from, INTERVAL 1 DAY
   ) AND ST.dat_valid_until
WHERE ST.inv_fg = 71
 AND ST.status_inv_sic = 64;