 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_SPACEMAN_KOP_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  01.01.2025	Akash Patil INITIAL SETUP
#  2.0  22.01.2025	Simeon Nikolaev Adding BUSYEAR
#
#----------------------------------------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_SCM.V_ORDER_ITEM_LOOKUP_1(
   BA_NR
 , CLIENT_ID
 , BUSYEAR
 , BA_BEZEICHNUNG
 , IAN
 , ARTIKEL_BEZEICHNUNG
 , KOLLIINHALT
 , PALFKT
) AS
 SELECT DISTINCT 
    WK_SUM.BA_NR
  , CLIENT.CLIENT_ID
  , CAL.BUSYEAR
  , WK_SUM.BA_BEZEICHNUNG
  , WK_SUM.IAN
  , WK_SUM.ARTIKEL_BEZEICHNUNG
  , WK_SUM.KOLLIINHALT
  , WK_SUM.PALFKT

 FROM CORE.T_DEMAND_ORDR_RECVD_WEEKLY_SUM_1 AS WK_SUM

 INNER JOIN CORE.V_CLIENT_1 CLIENT
  ON (WK_SUM.LAND_1=CLIENT.COUNTRY_CD)

 INNER JOIN CORE_REL.V_BUSYEAR_MONTH_WEEK_1 CAL
  ON WK_SUM.LAND_1 = CAL.LAND_1
  AND WK_SUM.BA_NR = CAL.BA_NR
  AND WK_SUM.CAL_MONTH BETWEEN CAL.START_MONTH AND CAL.END_MONTH

 WHERE BEDARFSOURCE NOT LIKE '%ELM%'
 AND WK_SUM.SUPPLIER_ID_INT IN ('10390','31838','31982','31837','31839','-99')  
;