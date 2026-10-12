
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STR_DAY_RETURN
(
/*
 #DescStart#
 #$Revision: 6244 $, $LastChangedBy: hwieber $
 #SubjectAreas#: Rückgaben
 #DescEnd#
*/
  client_id
, store_id
, loc_sid
, wh_id
, item_id
, subitemgroup_id
, booking_dat
, order_return_reason_cd
, return_qty
, return_val
, return_net_val
, currency_iso_cd
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
         imrp.client_id,
   lc_str.src_orig_store_nr                                                  AS store_id,
   imrp.loc_sid                                                              AS loc_sid_store,
   s_to_wh.orig_wh_nr                                                        AS wh_id,
   imrp.item_sid                                                             AS item_id,
   ihns.src_subitemgrp_cd                                                    AS subitemgroup_id,
   imrp.dwh_cal_dt                                                           AS booking_dat,
   orp.return_reason_mark                                                    AS order_return_reason_cd,
   SUM(imrp.ship_qty)                                                        AS return_qty,
   SUM(imrp.ship_qty * COALESCE(ilscd.cond_val_eff_calc, 0))                 AS return_val,
   SUM(CAST(imrp.ship_qty * COALESCE(ilscd.cond_val_eff_calc, 0) * 100
   / (100 + COALESCE(ilscd.tax_rate_calc, 0)) AS DECIMAL(18,2)))             AS return_net_val,
   hcurr.curr_iso_cd                                                         AS currency_iso_cd
  /* Als Basisview werden die Artikelbewegungen Positionsdaten verwendet*/
  FROM
   p_lew_core_ac.v_item_movement_record_pos imrp
   INNER JOIN p_lew_bil_ac.v_store lc_str
   ON imrp.client_id = lc_str.client_id
   AND imrp.loc_sid = lc_str.loc_sid_store
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse s_to_wh
   ON imrp.client_id = s_to_wh.client_id
   AND imrp.loc_sid = s_to_wh.loc_sid_store
   INNER JOIN p_lew_core_ac.v_item_hist itms
   ON  imrp.client_id = itms.client_id
   AND imrp.item_sid = itms.item_sid
   AND CURRENT_DATE BETWEEN itms.dwh_valid_from AND itms.dwh_valid_to
   LEFT JOIN p_lew_bil_ac.v_item_hierarchy ihns
   ON  imrp.client_id = ihns.client_id
   AND imrp.item_sid = ihns.item_sid
   INNER JOIN p_lew_core_ac.v_order_record_pos orp
   ON  imrp.client_id = orp.client_id
   AND imrp.order_record_id = orp.order_record_id
   AND imrp.order_record_pos_id = orp.order_record_pos_id
   LEFT JOIN p_lew_bil_ac.v_item_loc_sales_cond_denorm ilscd
   ON  imrp.client_id   = ilscd.client_id
   AND imrp.item_sid = ilscd.item_sid
   AND imrp.loc_sid = ilscd.loc_sid
   AND imrp.uom_sid_base = ilscd.uom_sid_cond
   AND imrp.dwh_cal_dt BETWEEN  ilscd.dwh_valid_from AND ilscd.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_currency  hcurr
   ON  imrp.client_id = hcurr.client_id
   AND imrp.curr_sid = hcurr.curr_sid
   INNER JOIN p_lew_core_ac.v_order_record orec
   ON  orec.client_id = orp.client_id
   AND orec.order_record_id = orp.order_record_id
-- 96X = WE Retoure o Vbr 
-- ZR01 = Filialinitiierte Rücksendungen Retoure
WHERE imrp.move_type_cd = '96X'
   AND orec.order_type_cd = 'ZR01'
GROUP BY 1,2,3,4,5,6,7,8,12;
