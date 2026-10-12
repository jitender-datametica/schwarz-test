/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_itm_item_active_aswas_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_2 mit V_WAREHOUSE_2 ersetzt
#  1.4  17.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_item_active_aswas_2
AS
/* Gesellschaft */ /* Artikel_2 */ /* Gueltigkeitsdatum */ /* nur Daten der letzten 25 Monate */ SELECT ITM.client_id
 /* Land_2 */,
 WH.src_wh_id AS wh_id,
 ITM.item_sid AS item_id,
 ITM.buying_list_type_id /* Artikelart-ID */,
 ITM.buying_list_type_desc /* Artikelart-Beschreibung */,
 ITM.subitemgroup_id /* UWG */,
 IIWH.item_status /* Status_2 */,
 CAL.cal_dt AS dat_valid,
 ORIG.orig_item_nr /* Orig Item_2 Nr */,
 ORIG.case_size /* Packungsgroesse */
FROM ldl_p_lew_core_ac.v_wawi_itm_item_2 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh_2 AS IIWH ON ITM.client_id = IIWH.client_id AND ITM.item_sid = IIWH.item_sid
       AND ITM.subitemgroup_id BETWEEN 20 AND 93 /* geforderte UWG's */ AND IIWH.item_status BETWEEN 6 AND 10
    /* Aufloesung WH */ AND ITM.buying_list_type_id NOT IN (7, 8, 16)
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON IIWH.client_id = WH.client_id AND IIWH.wh_loc_sid = WH.loc_sid_wh AND
   WH.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey_act_2 AS ORIG ON ITM.client_id = ORIG.client_id AND ITM.item_sid = ORIG
   .item_sid
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON CAL.cal_dt BETWEEN ITM.dat_rec_start AND ITM.dat_rec_end AND
     CAL.cal_dt BETWEEN IIWH.dat_rec_start AND IIWH.dat_rec_end AND CAL.cal_dt <= CURRENT_DATE
    /* nur bis aktuelles Tagesdatum */ AND CAL.cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE
      ,INTERVAL - 25 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 25 MONTH));

