CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_goods_loss_price_change_no_gc_lc AS SELECT CASE
  WHEN business_event_type_cd = ''
  THEN '-1'
  ELSE IFNULL(business_event_type_cd, '-1')
  END AS business_event_type_cd,
  CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd,
 event_dt AS event_date,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '-1')
  END AS curr_cd,
 IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
  CASE
  WHEN delivery_src_type_cd = ''
  THEN '-1'
  ELSE IFNULL(delivery_src_type_cd, '-1')
  END AS delivery_src_type_cd,
  CASE
  WHEN profit_loss_reason_cd = ''
  THEN '-1'
  ELSE IFNULL(profit_loss_reason_cd, '-1')
  END AS profit_loss_reason_cd,
  CASE
  WHEN goods_loss_origin_type_cd = ''
  THEN '-1'
  ELSE IFNULL(goods_loss_origin_type_cd, '-1')
  END AS goods_loss_origin_type_cd,
 IFNULL(national_acct_sid, -1) AS national_account_sid,
 national_acct_nr AS national_account_nr,
 prod_qty,
 tgt_price_net_local_val,
 tgt_price_net_eur_val,
 actual_price_net_local_val,
 actual_price_net_eur_val,
 ivp_price_net_local_val,
 ivp_price_net_eur_val,
 pc_losses_net_local_val,
 pc_losses_net_eur_val,
 transfer_margin_net_local_val,
 transfer_margin_net_eur_val,
 correction_cogs_net_local_val,
 correction_cogs_net_eur_val
FROM ldl_dig_lec_share.v_agg_goods_loss_summary
WHERE goods_loss_origin_type_cd = 'PC';