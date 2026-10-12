/*
#-------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: DDL for view P_LEW_MART_LEAD.v_stc_item_nfb_wh_day
#-------------------------------------------------------------------------------
# History:
#  1.0  01.07.2019    Chandramani Kumbhale     Initial version.
#                                              VIEW migrated from MSI layer to LEAD layer for LEAD reports.
#                                              https://jira-lidl-public.pixsoftware.de/browse/IDMO-1975
#                                              20190701_2138_MCD_Obj_Migrt_To_Lead_Rep5
#  1.1  17.07.2020    Martin Lysik             20200702_2519_WH_Move_Store_Form_Access_DWH20
#                                              Pointed to new core stock-NFB table
#  1.2  30.12.2020    Michal Malinowski        20201214_2691_Frischfish_adjustments, REP3-7935
#                                              FrischFish WGI ID Conversion (3=>30,32) && (i(1,2,4,5,6,7,8,9)=>(i*10...)
#-------------------------------------------------------------------------------
*/



/*
#-------------------------------------------------------------------------------
# View: P_LEW_MART_LEAD.v_stc_item_nfb_wh_day
#-------------------------------------------------------------------------------
*/


/* Internationale Warengruppe Non-Food */ /* Bestandsstichtag */ /* Umrechnen in Kolli damit Coex mit MIS korrekt ist */
/* Ermitteln WH */ CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_stc_item_nfb_wh_day
OPTIONS(DESCRIPTION = `$Revision: 16563 $ `) AS SELECT BIL.client_id,
 cry.curr_cd_from AS currency_iso_cd,
 BIL.dwh_cal_dt AS dat_calendar,
 ITMP.item_sid_map AS item_id,
 CAST(BIL.price / cry.exchange_rate AS NUMERIC) AS price_retail,
 CAST(BIL.price_net / cry.exchange_rate AS NUMERIC) AS price_retail_net,
 CAST(BIL.stock_calc_qty / COALESCE(CAST(ITEM.src_case_size AS BIGNUMERIC), 1) AS NUMERIC) AS qty_case_nfb_continuous,
 0 AS qty_case_nfb_diff,
 WH.src_wh_id AS wh_id
FROM ldl_p_lew_bil_ac.v_stock_location_item AS BIL
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON BIL.client_id = WH.client_id AND BIL.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1 /* Ermitteln Item Infos */
 INNER JOIN ldl_p_lew_bil_ac.v_item AS ITEM ON BIL.client_id = ITEM.client_id AND BIL.item_sid = ITEM.item_sid AND ITEM
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_bil_ac.v_itemgroup_international AS WGI ON ITEM.client_id = WGI.client_id AND ITEM.item_grp_int_sid_asis
    = WGI.item_grp_int_sid /* Kurse für Währungsumrechnung bestimmen */
 INNER JOIN (SELECT XR_KN_H.client_id,
   XRTYP.src_kurst,
   XR_KN_H.curr_cd_from,
   XR_KN_H.curr_cd_to,
   XR_KN_H.curr_sid_from,
   XR_KN_H.curr_sid_to,
   XR_KN_H.exchange_rate,
   XR_KN_H.active_from_dt,
   XR_KN_H.active_to_dt,
   XR_KN_H.deleted_fg
  FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist AS XR_KN_H
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS XRTYP ON XR_KN_H.client_id = XRTYP.client_id AND XR_KN_H.x_rate_type_sid
      = XRTYP.x_rate_type_sid
  WHERE /* nur die aktuellste bekannte Kurs-Zeit-Tabelle: */ CURRENT_DATE BETWEEN XR_KN_H.dwh_valid_from AND XR_KN_H.dwh_valid_to
    /* und nur die Berichtswesen-Kurse, diese werden extern geliefert als File und gelten als aktiv für einen langen Zeitraum: */
    
   AND XRTYP.src_kurst = '@BEWE') AS cry ON BIL.client_id = cry.client_id AND CURRENT_DATE BETWEEN cry.active_from_dt
   AND cry.active_to_dt
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON BIL.client_id = ITMP.client_id AND BIL.item_sid = ITMP.item_sid
WHERE ROUND(CAST(ITEM.log_var_cd AS BIGNUMERIC), 0) = 3 /* Beschaffungsvariante */
 AND ROUND(CAST(WGI.src_itemgrp_int_cd AS BIGNUMERIC), 0) IN (7, 70)
 AND WH.bges_active_fg = 1
UNION ALL
SELECT SINW.client_id,
 CRY.currency_iso_cd,
 CAL.cal_dt AS dat_calendar,
 ITMP.item_sid_map AS item_id,
  SINW.retail_price / CRY.rate_currency_exchange AS price_retail,
  SINW.retail_net_price / CRY.rate_currency_exchange AS price_retail_net,
 SINW.calc_stock_case_qty AS qty_case_nfb_continuous,
  CASE
  WHEN SINW.active_from_dt = CAL.cal_dt
  THEN SINW.delta_case_qty
  ELSE 0
  END AS qty_case_nfb_diff,
 WH.src_wh_id AS wh_id
FROM ldl_p_lew_core_ac.v_item_wh_stock_nfb AS SINW
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAL.cal_dt BETWEEN SINW.active_from_dt AND SINW.active_to_dt
   AND SINW.calc_stock_case_qty <> 0 AND SINW.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON SINW.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON SINW.client_id = WH.client_id AND SINW.loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON SINW.client_id = ITMP.client_id AND SINW.item_sid = ITMP.item_sid
   
WHERE WH.bges_active_fg = 1;