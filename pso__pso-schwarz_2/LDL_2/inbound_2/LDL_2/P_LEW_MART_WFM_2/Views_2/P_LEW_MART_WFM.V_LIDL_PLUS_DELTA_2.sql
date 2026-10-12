/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_LIDL_PLUS_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  14.12.2023    Camila Arango               Init, User Story 532106
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_LIDL_PLUS_DELTA_2(
	 client_id
	,country_iso_cd
	,store
	,item_2
	,receiptdate
	,coupon_type
	,lidl_plus_qty
	,lidl_plus_turnover
	,lidl_plus_discount
) AS
SELECT                                                         
   agg.client_id                                                              AS client_id
  ,cli.country_cd                                                             AS country_iso_cd
  ,loc.src_orig_store_nr                                                      AS store
  ,COALESCE(itmkey.dwh_orig_item_nr, itmkey.wawi_dwh_orig_item_nr)            AS item_2
  ,agg.dwh_cal_dt                                                             AS receiptdate
  ,t1.orig_coupon_type_descr                                                  AS coupon_type
  ,ROUND(SUM (DISTINCT(receipt_item_discount_piece_weight_qty_uniq)),2)       AS lidl_plus_qty  
  ,ROUND(SUM (DISTINCT(receipt_total_net_val_uniq)),4)                        AS lidl_plus_turnover
  ,ROUND(SUM (DISTINCT(discount_val)),4)                                      AS lidl_plus_discount
FROM   p_lew_mart_lidl_digital.t_agg_rcpt_coupon_promo_discount_ldpl_day_2    AS agg  

INNER JOIN p_lew_process_ac.v_wfm_last_export_2                               AS ex
  ON ex.last_export_tmsp <= agg.dwh_updated
  AND ex.process_name = 'export_wfm_lidl_plus'
  AND ex.process_specification = 'delta'
           
INNER JOIN p_lew_process_ac.v_wfm_export_specification_2                      AS expo_spec
  ON ex.export_specification = expo_spec.export_specification
  AND agg.client_id = expo_spec.client_id

INNER JOIN p_lew_core.t_client_2                                              AS cli
  ON cli.client_id = agg.client_id

INNER JOIN p_lew_core_ac.v_item_map_key_2                                     AS itmkey
  ON agg.client_id = itmkey.client_id
  AND agg.item_sid = itmkey.item_sid

INNER JOIN p_lew_bil_ac.v_item_2                                              AS itm
  ON agg.client_id = itm.client_id
  AND agg.item_sid = itm.item_sid
  AND agg.dwh_cal_dt BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to

INNER JOIN p_lew_bil_ac.v_store_2                                             AS loc
  ON agg.client_id = loc.client_id
  AND agg.LOC_SID = loc.loc_sid_store
  AND agg.dwh_cal_dt BETWEEN loc.dwh_valid_from AND loc.dwh_valid_to

INNER JOIN p_lew_core.t_ref_orig_coupon_type_2                                AS t1_2
 ON agg.coupon_type_id = t1.orig_coupon_type_sid

WHERE agg.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE

GROUP BY  agg.client_id, country_cd, store, item_2, receiptdate, coupon_type
;