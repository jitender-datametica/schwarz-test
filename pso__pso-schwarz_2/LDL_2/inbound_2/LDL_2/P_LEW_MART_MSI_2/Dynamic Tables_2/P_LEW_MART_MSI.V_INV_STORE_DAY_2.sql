
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_INV_STORE_DAY_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  23.04.2021    Rekovsky, Marvin         20210422_2813_TransAll_Shutdown_Update(REP1-14416): Replace legacy object
#                                              v_wawi_cal_calendarday_2 with v_cal_calendarday_2
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_INV_STORE_DAY_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT   
   st.dat_valid_from,   
   st.client_id,  
   st.st_loc_sid AS store_id, 
   cal.cal_dt AS dat_formdate 
    FROM p_lew_core_ac.v_wawi_inv_store_2 st   
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 cal  
   ON cal.cal_dt BETWEEN st.dat_valid_from -1 AND st.dat_valid_until 
   WHERE st.inv_fg = 71 
   AND st.status_inv_sic = 64 
;
