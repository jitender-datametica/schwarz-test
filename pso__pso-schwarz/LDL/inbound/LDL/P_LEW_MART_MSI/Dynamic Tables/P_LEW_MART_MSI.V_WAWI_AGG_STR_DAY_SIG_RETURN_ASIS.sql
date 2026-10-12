
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_WAWI_AGG_STR_DAY_SIG_RETURN_ASIS

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
2022-01-12 Martin Murtenthaler    AP0103419_INT-B-172  New column sysind (necessary for a lookup), 
                                  as return_reason_cd_ejr can have a different description
                                  coming either from ELWIS or from WAWI 
*/
SELECT
  agg.client_id
 ,agg.st_loc_sid                                        AS loc_sid_store
 ,wh.orig_wh_nr                                         AS wh_id
 ,agg.subitemgroup_id 
 ,agg.dat_formdate                                      AS dat_formdate 
 ,agg.return_receipttype_id                             AS return_receipttype_id  
 ,agg.return_reason_cd_ejr_sfo                          AS return_reason_cd_ejr_sfo 
 ,agg.qty_return_ejr_sfo                                AS qty_return_ejr_sfo 
 ,(agg.val_return_ejr_sfo / currh.exchange_rate)        AS val_return_ejr_sfo 
 ,(agg.val_return_net_ejr_sfo / currh.exchange_rate)    AS val_return_net_ejr_sfo
 ,currh.curr_cd_from                                    AS currency_iso_cd
 ,1                                                     AS sysind
FROM p_lew_core_ac.v_wawi_agg_str_day_sig_return_asis       AS agg  
INNER JOIN p_lew_bil_ac.v_store_to_warehouse AS wh  
ON agg.client_id = wh.client_id 
AND agg.st_loc_sid = wh.loc_sid_store 
AND dwh_actual_fg = 1 
AND active_fg = 1 
INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS currh  
ON currh.client_id = agg.client_id  
AND CURRENT_DATE BETWEEN currh.active_from_dt AND currh.active_to_dt  
AND CURRENT_DATE BETWEEN currh.dwh_valid_from AND currh.dwh_valid_to  
INNER JOIN p_lew_core_ac.v_exchange_rate_type AS currt  
ON currt.client_id = currh.client_id  
AND currt.x_rate_type_sid = currh.x_rate_type_sid 
AND currt.src_kurst = '@BEWE';
