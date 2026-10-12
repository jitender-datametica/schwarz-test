
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  18.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AUL_ITM_ART_TYPE_MTH COMMENT = 'Nur Wawi! $Revision: 16815 $. Auto Generated Thursday, September 7, 2017 '
 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI
 
 AS 
 /* 
 #DescStart# 
 #$Revision: 16815 $, $LastChangedBy: tbachmann $ 
 #SubjectAreas#: AUL 
 #DescEnd# 
 */ 
 SELECT 
 itm.client_id 
 , itm.item_sid AS item_id 
 , m.cy_month 
 , itm.buying_list_type_id 
 , itm.buying_list_type_desc 
  
 FROM P_LEW_CORE_AC.v_wawi_itm_item AS itm 
  
 CROSS JOIN P_LEW_CORE_AC.v_cal_month AS m 
  
 WHERE ADD_MONTHS(TO_DATE(cy_month || 01, 'YYYYMMDD'), 1) -1 BETWEEN itm.dat_rec_start AND itm.dat_rec_end 
 AND m.cy_month_seq <= 0
;
