
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STR_DAY_SIG_RETURN_ASIS 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
2022-01-12 Martin Murtenthaler    AP0103419_INT-B-172  New column sysind (necessary for a lookup), 
                                  as return_reason_cd_ejr can have a different description
                                  coming either from ELWIS or from WAWI
2022-02-14 Martin Murtenthaler    AP0103419_INT-B-172  EURO also for ELWIS source
*/
   -- Filialinitiierte Rücksendungen aus eLWIS (return_receipttype_id = 2)
SELECT 
  agg.client_id
 ,agg.loc_sid_store AS store_id
 ,agg.orig_wh_nr AS wh_id
 ,agg.src_subitemgrp_cd AS subitemgroup_id
 ,agg.dwh_cal_dt  AS dat_formdate
 ,2  AS return_receipttype_id
 ,COALESCE(CAST(TO_NUMBER(agg.return_reason_mark) AS INTEGER), -1)  AS return_reason_cd_ejr_sfo
 ,SUM(agg.ship_qty * -1)  AS qty_return_ejr_sfo
 ,SUM(agg.ship_val * -1) / MAX(curr.exchange_rate)  AS val_return_ejr_sfo
 ,SUM(agg.ship_net_val * -1) / MAX(curr.exchange_rate) AS val_return_net_ejr_sfo
 ,curr.curr_cd_from AS currency_iso_cd
 ,2 AS sysind
FROM p_lew_bil_ac.v_agg_store_day_return AS agg
INNER JOIN p_lew_mart_msi.v_report_fixed_exchange_rate AS curr
ON agg.client_id = curr.client_id
AND CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
GROUP BY
  agg.client_id
 ,agg.loc_sid_store
 ,agg.orig_wh_nr
 ,agg.src_subitemgrp_cd
 ,agg.dwh_cal_dt
 ,agg.return_reason_mark
 ,curr.curr_cd_from
UNION ALL
   -- Kassenretouren und weitere filialiinitiierte Rücksendungen aus WAWI
SELECT 
  agg.client_id
 ,agg.st_loc_sid AS store_id
 ,wh.src_wh_id AS wh_id
 ,agg.subitemgroup_id
 ,agg.dat_formdate AS dat_formdate
 ,agg.return_receipttype_id AS return_receipttype_id
 ,agg.return_reason_cd_ejr_sfo AS return_reason_cd_ejr_sfo
 ,agg.qty_return_ejr_sfo AS qty_return_ejr_sfo
 ,agg.val_return_ejr_sfo / curr.exchange_rate AS val_return_ejr_sfo
 ,agg.val_return_net_ejr_sfo / curr.exchange_rate AS val_return_net_ejr_sfo
 ,curr.curr_cd_from AS currency_iso_cd
 ,1 AS sysind
FROM p_lew_core_ac.v_wawi_agg_str_day_sig_return_asis AS agg
INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown AS wh
ON agg.client_id = wh.client_id
AND agg.st_loc_sid = wh.loc_sid_store
INNER JOIN p_lew_mart_msi.v_report_fixed_exchange_rate AS curr
ON agg.client_id = curr.client_id
AND CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
;
