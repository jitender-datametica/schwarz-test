
   /*    
   #DESCSTART#       
   #SUBJECTAREAS#: KPGES VIEWS 
   # 1.0  2024.03.11 STEPHANE TONGA ROLLBACK TO INITIAL VERSION   
   # 1.1  2024.06.28 Marcin Malec   add logic for indicator 338; average headcount for last only open 12 months; User Story 643630
   # 1.2  2025.10.10 Marcin Malec   add logic for indicator 340; sum for last 12 months, calculated by month; User Story 767991
   #DESCEND#   
   */
   
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_MTH_STORE
(
     CLIENT_ID
   , ORIG_STORE_NR
   , STORE_ID
   , INDICATOR_ID
   , CY_MONTH
   , VAL_INDICATOR
   , CURRENCY_ISO_CD
   , DAT_DAYEND
) 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT  
     IMTH.CLIENT_ID 
   , OSK.ORIG_STORE_NR  
   , OSK.ST_LOC_SID AS STORE_ID 
   , IMTH.INDICATOR_ID  
   , IMTH.CY * 100 + IMTH.MONTH_ID AS CY_MONTH  
   , CASE WHEN IMTH.INDICATOR_ID IN (117,120,125,126,133,135,136,155,156,157,163,168,169,170,172,174,177,179,203,204,209,210,212,216,228,229,230,238,240,242,250,251,255,256,257,258,259,260,261,270,271,272,273,280,281,282,283,284,286)   
    THEN IMTH.VAL_INDICATOR / CRY.RATE_CURRENCY_EXCHANGE 
          WHEN imth.indicator_id = 338 THEN (SELECT ROUND(SUM(val_indicator) / COALESCE((CASE WHEN SUM(CASE WHEN val_indicator != 0 THEN 1 ELSE 0 END) != 0 THEN SUM(CASE WHEN val_indicator != 0 THEN 1 ELSE 0 END) ELSE 1 END), 1), 2) 
                                       FROM P_LEW_BIL_AC.v_kpi_month AS subqry 
                                       INNER JOIN P_LEW_CORE_AC.v_cal_month submon
                                       ON subqry.cy * 100 + subqry.month_id = submon.cy_month
                                       AND submon.cy_month_seq BETWEEN mon.cy_month_seq - 11 AND mon.cy_month_seq
                                       WHERE imth.client_id = subqry.client_id 
                                       AND imth.org_unit_nr = subqry.org_unit_nr 
                                       AND subqry.indicator_id = 236 
                                       AND subqry.indicator_type_id = 1   
                                       AND subqry.org_type_id = 90)
          WHEN imth.indicator_id = 340 THEN (SELECT ROUND(SUM(val_indicator), 2) 
                                       FROM P_LEW_BIL_AC.v_kpi_month AS subqry 
                                       INNER JOIN P_LEW_CORE_AC.v_cal_month submon
                                       ON subqry.cy * 100 + subqry.month_id = submon.cy_month
                                       AND submon.cy_month_seq BETWEEN mon.cy_month_seq - 11 AND mon.cy_month_seq
                                       WHERE imth.client_id = subqry.client_id 
                                       AND imth.org_unit_nr = subqry.org_unit_nr 
                                       AND subqry.indicator_id = 191
                                       AND subqry.indicator_type_id = 1   
                                       AND subqry.org_type_id = 90)
    ELSE IMTH.VAL_INDICATOR END AS VAL_INDICATOR    
   , CRY.CURRENCY_ISO_CD
   , IMTH.DAT_DAYEND    
   FROM P_LEW_BIL_AC.V_KPI_MONTH AS IMTH    
   INNER JOIN P_LEW_CORE_AC.V_WAWI_REF_CLIENT_CURRENCY_RATE AS CRY  
   ON  IMTH.CLIENT_ID = CRY.CLIENT_ID   
   AND IMTH.INDICATOR_TYPE_ID = 1   
   AND IMTH.ORG_TYPE_ID = 90    
   AND CURRENT_DATE BETWEEN CRY.DAT_REC_START AND CRY.DAT_REC_END   
   INNER JOIN P_LEW_CORE_AC.V_WAWI_ORG_STORE_SKEY_ACT AS OSK    
   ON  OSK.CLIENT_ID = IMTH.CLIENT_ID   
   AND OSK.ORIG_STORE_NR = IMTH.ORG_UNIT_NR 
   INNER JOIN P_LEW_CORE_AC.v_cal_month AS mon
   ON imth.cy * 100 + imth.month_id = mon.cy_month
;
