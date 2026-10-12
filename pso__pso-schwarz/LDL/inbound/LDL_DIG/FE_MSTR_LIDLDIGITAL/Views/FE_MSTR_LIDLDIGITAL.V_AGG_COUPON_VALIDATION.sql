CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_COUPON_VALIDATION
(  
     coupon_validation_nr_agg
	,cust_order_sid
	,prod_variant_sid
	,coupon_id_combination
	,coupon_cd_combination
	,profit_loss_reason_cd_agg
    ,coupon_promo_cd_combination
	,curr_cd
	,wshop_cd
	,prod_qty
	,coupon_validation_tmsp
	,coupon_ship_gross_val
	,coupon_item_gross_val
	,coupon_pos_gross_val
    ,gc_lc_cd
) AS 
SELECT
     LISTAGG(DISTINCT coupon_validation_nr, ' | ') WITHIN GROUP (ORDER BY coupon_validation_nr)                                 AS coupon_validation_nr_agg
    ,IFNULL(cust_order_sid, -1)                                                                                                 AS cust_order_sid
    ,IFNULL(prod_variant_sid, -1)                                                                                               AS prod_variant_sid
    ,LISTAGG(DISTINCT (CASE WHEN coupon_id = '' THEN '-1' ELSE IFNULL(coupon_id, '-1') END), ' | ')                             AS coupon_id_combination
    ,LISTAGG(DISTINCT (CASE WHEN coupon_cd = '' THEN '-1' ELSE IFNULL(coupon_cd, '-1') END), ' | ')  
     WITHIN GROUP (ORDER BY CASE WHEN coupon_cd = '' THEN '-1' ELSE IFNULL(coupon_cd, '-1') END)                                AS coupon_cd_combination
    ,LISTAGG(DISTINCT (CASE WHEN profit_loss_reason_cd = '' THEN '-1' ELSE IFNULL(profit_loss_reason_cd, '-1') END), ' | ') 
     WITHIN GROUP (ORDER BY CASE WHEN profit_loss_reason_cd = '' THEN '-1' ELSE IFNULL(profit_loss_reason_cd, '-1') END)        AS profit_loss_reason_cd_agg
    ,LISTAGG(DISTINCT (CASE WHEN coupon_promo_cd = '' THEN '-1' ELSE IFNULL(coupon_promo_cd, '-1') END), ' | ')  
     WITHIN GROUP (ORDER BY CASE WHEN coupon_promo_cd = '' THEN '-1' ELSE IFNULL(coupon_promo_cd, '-1') END)                    AS coupon_promo_cd_combination
    ,CASE WHEN curr_cd = '' THEN '-1'  ELSE IFNULL(curr_cd, '-1') END                                                           AS curr_cd
    ,CASE WHEN wshop_cd = '' THEN '-1'  ELSE IFNULL(wshop_cd, '-1') END                                                         AS wshop_cd
    ,prod_qty                                                                                                                   AS prod_qty
    ,ANY_VALUE(coupon_validation_tmsp)                                                                                          AS coupon_validation_tmsp
    ,SUM(coupon_ship_gross_val)                                                                                                 AS coupon_ship_gross_val
    ,SUM(coupon_item_gross_val)                                                                                                 AS coupon_item_gross_val
    ,SUM(coupon_pos_gross_val)                                                                                                  AS coupon_pos_gross_val
    ,gc_lc_cd                                                                                                                   AS gc_lc_cd
FROM
    fe_mstr_lidldigital.v_fact_coupon_validation
GROUP BY 
    cust_order_sid
    ,prod_variant_sid
    ,curr_cd
    ,wshop_cd
    ,prod_qty
    ,gc_lc_cd
;