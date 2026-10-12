
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_itm_item_active_aswas
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY mit V_WAREHOUSE ersetzt
#  1.4  17.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ITEM_ACTIVE_ASWAS COMMENT = 'Nur Wawi! $Revision: 16817 $. Auto Generated Thursday, September 7, 2017 '
 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI
 
 AS
 /*
 #DescStart#
 #$Revision: 16817 $, $LastChangedBy: tbachmann $
 #SubjectAreas#: Artikelstamm
 #DescEnd#
 */
 SELECT
 itm.client_id                   /* Land */
 , wh.src_wh_id AS wh_id                        /* Gesellschaft */
 ,itm.item_sid AS item_id                     /* Artikel */
 ,itm.buying_list_type_id         /* Artikelart-ID */
 ,itm.buying_list_type_desc       /* Artikelart-Beschreibung */
 ,itm.subitemgroup_id             /* UWG */
 ,iiwh.item_status                  /* Status */
 ,cal.cal_dt AS dat_valid   /* Gueltigkeitsdatum */
 ,orig.orig_item_nr               /* Orig Item Nr */
 ,orig.case_size                  /* Packungsgroesse */
 FROM P_LEW_CORE_AC.v_wawi_itm_item AS itm
 INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_wh AS iiwh
  ON  itm.client_id = iiwh.client_id
 AND itm.item_sid    =  iiwh.item_sid
 AND itm.buying_list_type_id NOT IN (7, 8, 16)
 AND itm.subitemgroup_id BETWEEN 20 AND 93 /* geforderte UWG's */
 AND iiwh.item_status BETWEEN 6 AND 10
/* Aufloesung WH */
 INNER JOIN P_LEW_BIL_AC.v_warehouse AS wh
 ON wh.client_id = iiwh.client_id
 AND wh.loc_sid_wh = iiwh.wh_loc_sid
 AND wh.dwh_actual_fg = 1
 INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_skey_act AS orig
 ON  itm.client_id = orig.client_id
 AND itm.item_sid    =  orig.item_sid
 INNER JOIN P_LEW_CORE_AC.v_cal_calendarday AS cal
 ON  cal.cal_dt BETWEEN itm.dat_rec_start AND itm.dat_rec_end
 AND cal.cal_dt BETWEEN iiwh.dat_rec_start AND iiwh.dat_rec_end
 AND cal.cal_dt <= CURRENT_DATE                  /* nur bis aktuelles Tagesdatum */
 AND cal.cal_dt > ADD_MONTHS(CURRENT_DATE, -25)  /* nur Daten der letzten 25 Monate */
;
