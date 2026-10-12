
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STR_DAY_ITEM_RETURN_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*
   #DescStart#
   #$Revision: 8320 $, $LastChangedBy: mueding $
   #SubjectAreas#: Rückgaben 
   #DescEnd#
   2022-01-12 Martin Murtenthaler    AP0103419_INT-B-172  New column sysind (necessary for a lookup), 
                                     as return_reason_cd_ejr can have a different description
                                     coming either from ELWIS or from WAWI
   2022-02-14 Martin Murtenthaler    AP0103419_INT-B-172  EURO also for ELWIS source
   */
SELECT
  elw_agg.client_id
 ,elw_agg.loc_sid_store AS store_id
 ,elw_agg.orig_wh_nr AS wh_id
 ,itmp.item_sid_map AS item_id
 ,elw_agg.dwh_cal_dt AS dat_formdate
 ,2 AS return_receipttype_id
 ,COALESCE(CAST(TO_NUMBER(elw_agg.return_reason_mark) AS INTEGER), -1) AS return_reason_cd_ejr_sfo
 ,elw_agg.ship_qty * -1 AS qty_return_ejr_sfo
 ,(elw_agg.ship_val * -1) / curr.exchange_rate AS val_return_ejr_sfo
 ,(elw_agg.ship_net_val * -1) / curr.exchange_rate AS val_return_net_ejr_sfo
 ,curr.curr_cd_from AS currency_iso_cd
 ,2 AS sysind
FROM p_lew_bil_ac.v_agg_store_day_return_1 AS elw_agg
INNER JOIN p_lew_mart_msi.v_report_fixed_exchange_rate_1 AS curr
ON elw_agg.client_id = curr.client_id
AND CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
INNER JOIN p_lew_core_ac.v_item_map_key_1 itmp
ON itmp.client_id = elw_agg.client_id
AND itmp.item_sid = elw_agg.item_sid
UNION ALL
SELECT
  agg.client_id AS client_id
 ,agg.st_loc_sid AS store_id
 ,s2w.src_wh_id AS wh_id
 ,itmp.item_sid_map AS item_id
 ,agg.dat_formdate AS dat_formdate
 ,agg.return_receipttype_id AS return_receipttype_id
 ,agg.return_reason_cd_ejr_sfo AS return_reason_cd_ejr_sfo
 ,agg.qty_return_ejr_sfo AS qty_return_ejr_sfo
 ,(agg.val_return_ejr_sfo / curr.exchange_rate) AS val_return_ejr_sfo
 ,(agg.val_return_net_ejr_sfo / curr.exchange_rate)  AS val_return_net_ejr_sfo
 ,curr.curr_cd_from AS currency_iso_code
 ,1 AS sysind
FROM p_lew_core_ac.v_wawi_agg_str_day_item_return_1 AS agg
INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS s2w
ON agg.client_id = s2w.client_id
AND agg.st_loc_sid = s2w.loc_sid_store
INNER JOIN p_lew_mart_msi.v_report_fixed_exchange_rate_1 AS curr
ON agg.client_id = curr.client_id
AND CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
INNER JOIN p_lew_core_ac.v_item_map_key_1 itmp
ON itmp.client_id = agg.client_id
AND itmp.item_sid = agg.item_sid
;
