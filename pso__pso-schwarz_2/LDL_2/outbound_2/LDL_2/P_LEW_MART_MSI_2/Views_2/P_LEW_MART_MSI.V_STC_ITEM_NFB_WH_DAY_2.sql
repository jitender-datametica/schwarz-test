/*
#-------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: DDL for view P_LEW_MART_MSI.v_stc_item_nfb_wh_day_2
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------





#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  21.09.2017    H.Wieber                 Change loc_sid to loc_sid_wh
#  1.2  11.10.2017    Arnold.Arne              Spaltenreihenfolge fuer WAWI-Teil angepasst. ITEM_SID und DAT_CALENDAR waren vertauscht.
#  1.3  15.11.2017    Wieber.Harald            Release 1.1
#  1.4  16.11.2017    Thole.Jens               UNION->UNION ALL und Client-Einschränkung WAWI-Teil eliminiert. da sinnlos.
#  1.5  17.01.2018    Murtenthaler.Martin      WAWI-Item_2 if possible
#  1.6  17.01.2018    Wieber.Harald            Release 2.2
#  1.7  18.01.2018    Martin Murtenthaler      Group by Syntax changed
#  1.8  31.01.2018    Wieber,Harald            Release 2.3
#  1.9  17.04.2018    Michael Ueding           Gruppierung entfernt (erfolgt im FE)
#                                              Ermittlung Umrechnungskurs vereinheitlicht
#  2.0  18.04.2018    Michael Ueding           Datumstransformation Stichtag-1 ueber cal_calendarday
#  2.1  24.07.2018    Michael Ueding           Referenz Item_2 Mapping geaendert
#  2.2  05.11.2018    Thole,Jens               Umhängen auf historisierte globale Stockstruktur
#  2.3  30.09.2020    Martin Lysik             20200702_2519_WH_Move_Store_Form_Access_DWH20
#                                              Pointed to new core stock-NFB table
#  2.4  30.12.2020    Michal Malinowski        20201214_2691_Frischfish_adjustments, REP3-7935
#                                              FrischFish WGI ID Conversion (3=>30,32) && (i(1,2,4,5,6,7,8,9)=>(i*10...)
#  2.5  28.10.2021    Torsten Bachmann         20211026_2959_L145_bestande_eingelagert, REP3-9170
#                                              Added CROSS JOIN to P_LEW_CORE_AC.v_client_migration_per_2
#-------------------------------------------------------------------------------
*/



/*
#-------------------------------------------------------------------------------
# View: P_LEW_MART_MSI.v_inv_stc_store_item_2
#-------------------------------------------------------------------------------
*/


/* Bestandsstichtag */ /* Umrechnen in Kolli damit Coex mit MIS korrekt ist */ /* Internationale Warengruppe Non-Food */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_stc_item_nfb_wh_day_2 OPTIONS(DESCRIPTION = `$Revision: 16565 $ `) AS
SELECT BIL.client_id,
 CRY.curr_cd_from AS currency_iso_cd,
 BIL.dwh_cal_dt AS dat_calendar,
 ITMP.item_sid_map AS item_id,
 CAST(BIL.price / CRY.exchange_rate AS NUMERIC) AS price_retail,
 CAST(BIL.price_net / CRY.exchange_rate AS NUMERIC) AS price_retail_net,
 CAST(BIL.stock_calc_qty / COALESCE(CAST(ITEM.src_case_size AS BIGNUMERIC), 1) AS NUMERIC) AS qty_case_nfb_continuous,
 0 AS qty_case_nfb_diff,
 WH.src_wh_id AS wh_id
FROM ldl_p_lew_bil_ac.v_stock_location_item_2 AS BIL
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON BIL.client_id = MIG.client_id AND BIL.dwh_cal_dt BETWEEN
   MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to /* Ermitteln WH */
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON BIL.client_id = WH.client_id AND BIL.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1 /* Ermitteln Item_2 Infos */
 INNER JOIN ldl_p_lew_bil_ac.v_item_2 AS ITEM_2 ON BIL.client_id = ITEM.client_id AND BIL.item_sid = ITEM.item_sid AND ITEM_2
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_bil_ac.v_itemgroup_international_2 AS WGI ON ITEM.client_id = WGI.client_id AND ITEM.item_grp_int_sid_asis
    = WGI.item_grp_int_sid /* Kurse für Währungsumrechnung bestimmen */
 INNER JOIN ldl_p_lew_mart_msi.v_report_fixed_exchange_rate_2 AS CRY ON BIL.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.active_from_dt AND CRY.active_to_dt
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON BIL.client_id = ITMP.client_id AND BIL.item_sid = ITMP.item_sid
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
FROM ldl_p_lew_core_ac.v_item_wh_stock_nfb_2 AS SINW
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON CAL.cal_dt BETWEEN SINW.active_from_dt AND SINW.active_to_dt
   AND SINW.calc_stock_case_qty <> 0 AND SINW.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON SINW.client_id = MIG.client_id AND CAL.cal_dt NOT BETWEEN
   MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON SINW.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON SINW.client_id = WH.client_id AND SINW.loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON SINW.client_id = ITMP.client_id AND SINW.item_sid = ITMP.item_sid
   
WHERE WH.bges_active_fg = 1;