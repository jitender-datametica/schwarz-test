CREATE OR REPLACE VIEW fe_mstr_lidldigital.v_fact_customer_order_line_no_gc_lc
AS 
WITH 
	epo_is_single_position AS (
		SELECT 
			cust_order_sid																				AS cust_order_sid
			, COUNT( DISTINCT cust_order_pos_nr ) 														AS cnt_distinct_order_pos_per_cust_order
			, SUM( prod_qty ) 																			AS sum_prod_qty_per_cust_order
			, ( cnt_distinct_order_pos_per_cust_order = 1 ) AND ( sum_prod_qty_per_cust_order = 1 ) 	AS is_single_position
		FROM 
			lec_share.v_fact_customer_order_line
		GROUP BY 
			cust_order_sid
     )
SELECT 
	col_fact.wshop_cd 																		AS wshop_cd
	, IFNULL( col_fact.cust_order_sid , -1 ) 												AS cust_order_sid
	, CONVERT_TIMEZONE( 'Europe/Berlin', col_fact.cust_order_create_tmsp )::TIMESTAMP_NTZ 	AS cust_order_create_tmsp
	, col_fact.cust_order_dt 																AS cust_order_dt
	, col_fact.cust_order_tm 																AS cust_order_tm
	, TO_TIME( col_fact.cust_order_create_tmsp ) 											AS cust_order_create_time
	, TO_DATE( col_fact.cust_order_create_tmsp ) 											AS cust_order_create_date
	, IFNULL( col_fact.prod_variant_sid , -1 ) 												AS prod_variant_sid
	, IFNULL( col_fact.prod_sid , -1 ) 														AS prod_sid
	
	, CASE
		WHEN col_fact.bundle_header_pos_nr > 0 	THEN 'Group Component'
		WHEN col_fact.is_bundle_header_fg = 1 	THEN 'Group Header'
												ELSE 'Single Item'
	  END::VARCHAR(20) 																		AS article_set
	  
	, IFNULL( col_fact.cust_sid , -1 ) 														AS cust_sid
	, col_fact.cust_order_nr 																AS cust_order_nr
	, col_fact.cust_order_pos_nr 															AS cust_order_pos_nr
	, col_fact.prod_qty 																	AS prod_qty
	, col_fact.is_bundle_header_fg 															AS is_bundle_header_fg
	, col_fact.bundle_header_pos_nr 														AS bundle_header_pos_nr
	, IFNULL( col_fact.delivery_addr_sid , -1 ) 											AS delivery_addr_sid
	, IFNULL( NULLIF( col_fact.curr_cd, '' ), '-1' )										AS curr_cd
	, cer_fact.exchange_rate 																AS exchange_rate
	, IFNULL( NULLIF( cer_fact.curr_exchange_rate_type_cd, '' ), '-1' ) 					AS curr_exchange_rate_type_cd
	, cer_fact.active_from_dt 																AS curr_exchange_rate_active_from_dt
	, cer_fact.active_to_dt 																AS curr_exchange_rate_active_to_dt
	, cer_fact.active_fg 																	AS curr_exchange_rate_active_fg
	, col_fact.prod_price_net_local_val / cer_fact.exchange_rate 							AS prod_price_net_eur_val
	, col_fact.prod_price_net_local_val 													AS prod_price_net_local_val
	, col_fact.prod_price_gross_local_val / cer_fact.exchange_rate 							AS prod_price_gross_eur_val
	, col_fact.prod_price_gross_local_val 													AS prod_price_gross_local_val
	, col_fact.prod_price_vat_local_val / cer_fact.exchange_rate 							AS prod_price_vat_eur_val
	, col_fact.prod_price_vat_local_val 													AS prod_price_vat_local_val
	, col_fact.prod_coupon_net_local_val / cer_fact.exchange_rate 							AS prod_coupon_net_eur_val
	, col_fact.prod_coupon_net_local_val 													AS prod_coupon_net_local_val
	, col_fact.prod_coupon_gross_local_val / cer_fact.exchange_rate 						AS prod_coupon_gross_eur_val
	, col_fact.prod_coupon_gross_local_val 													AS prod_coupon_gross_local_val
	, col_fact.prod_coupon_vat_local_val / cer_fact.exchange_rate 							AS prod_coupon_vat_eur_val
	, col_fact.prod_coupon_vat_local_val 													AS prod_coupon_vat_local_val
	, col_fact.delivery_cost_net_local_val / cer_fact.exchange_rate 						AS delivery_cost_net_eur_val
	, col_fact.delivery_cost_net_local_val 													AS delivery_cost_net_local_val
	, col_fact.delivery_cost_gross_local_val / cer_fact.exchange_rate 						AS delivery_cost_gross_eur_val
	, col_fact.delivery_cost_gross_local_val 												AS delivery_cost_gross_local_val
	, col_fact.delivery_cost_vat_local_val / cer_fact.exchange_rate 						AS delivery_cost_vat_eur_val
	, col_fact.delivery_cost_vat_local_val 													AS delivery_cost_vat_local_val
	, col_fact.delivery_coupon_net_local_val / cer_fact.exchange_rate 						AS delivery_coupon_net_eur_val
	, col_fact.delivery_coupon_net_local_val 												AS delivery_coupon_net_local_val
	, col_fact.delivery_coupon_gross_local_val / cer_fact.exchange_rate 					AS delivery_coupon_gross_eur_val
	, col_fact.delivery_coupon_gross_local_val 												AS delivery_coupon_gross_local_val
	, col_fact.delivery_coupon_vat_local_val / cer_fact.exchange_rate 						AS delivery_coupon_vat_eur_val
	, col_fact.delivery_coupon_vat_local_val 												AS delivery_coupon_vat_local_val
	, col_fact.delivery_paushal_net_local_val / cer_fact.exchange_rate 						AS delivery_paushal_net_eur_val
	, col_fact.delivery_paushal_net_local_val 												AS delivery_paushal_net_local_val
	, col_fact.delivery_paushal_gross_local_val / cer_fact.exchange_rate 					AS delivery_paushal_gross_eur_val
	, col_fact.delivery_paushal_gross_local_val 											AS delivery_paushal_gross_local_val
	, col_fact.delivery_paushal_vat_local_val / cer_fact.exchange_rate 						AS delivery_paushal_vat_eur_val
	, col_fact.delivery_paushal_vat_local_val 												AS delivery_paushal_vat_local_val
	, col_fact.delivery_paushal_coupon_net_local_val / cer_fact.exchange_rate 				AS delivery_paushal_coupon_net_eur_val
	, col_fact.delivery_paushal_coupon_net_local_val 										AS delivery_paushal_coupon_net_local_val
	, col_fact.delivery_paushal_coupon_gross_local_val / cer_fact.exchange_rate 			AS delivery_paushal_coupon_gross_eur_val
	, col_fact.delivery_paushal_coupon_gross_local_val 										AS delivery_paushal_coupon_gross_local_val
	, col_fact.delivery_paushal_coupon_vat_local_val / cer_fact.exchange_rate 				AS delivery_paushal_coupon_vat_eur_val
	, col_fact.delivery_paushal_coupon_vat_local_val 										AS delivery_paushal_coupon_vat_local_val
	, col_fact.ivp_price_net_local_val / cer_fact.exchange_rate 							AS ivp_price_net_eur_val
	, col_fact.ivp_price_net_local_val 														AS ivp_price_net_local_val
	, col_fact.gld_price_net_local_val / cer_fact.exchange_rate 							AS gld_price_net_eur_val
	, col_fact.gld_price_net_local_val 														AS gld_price_net_local_val
	, col_fact.ivp_original_price_net_local_val / cer_fact.exchange_rate 					AS ivp_original_price_net_eur_val
	, col_fact.ivp_original_price_net_local_val 											AS ivp_original_price_net_local_val
	, col_fact.cogs_price_net_local_val / cer_fact.exchange_rate 							AS cogs_price_net_eur_val
	, col_fact.cogs_price_net_local_val 													AS cogs_price_net_local_val
	, gld_unit_price_net_eur_val 															AS gld_unit_price_net_eur_val
	, ivp_unit_price_net_eur_val 															AS ivp_unit_price_net_eur_val
	, ivp_original_unit_price_net_eur_val 													AS ivp_original_unit_price_net_eur_val
	, IFNULL( NULLIF( col_fact.tax_class_cd, '' ), '-1' ) 									AS tax_class_cd
	, IFNULL( col_fact.delivery_cust_sid , -1 ) 											AS delivery_cust_sid
	, IFNULL( col_fact.billing_addr_sid, -1 ) 												AS billing_addr_sid
	, col_fact.is_blocked_delivery_fg 														AS is_blocked_delivery_fg
	, IFNULL( NULLIF( col_fact.delivery_blocked_reason_cd, '' ), '-1' ) 					AS delivery_blocked_reason_cd
	, col_fact.is_order_cancel_fg 															AS is_order_cancel_fg
	, IFNULL( NULLIF( col_fact.cust_paym_method_cd, '' ), '-1' )							AS cust_paym_method_cd
	, IFNULL( NULLIF( col_fact.sales_channel_type_cd, '' ), '-1' )							AS sales_channel_type_cd
	, IFNULL( NULLIF( col_fact.order_cancel_reason_cd, '' ), '-1' )							AS order_cancel_reason_cd
	, IFNULL( NULLIF( col_fact.cust_order_type_cd, '' ), '-1' ) 							AS cust_order_type_cd
	, col_fact.cust_order_perform_dt 														AS cust_order_perform_dt
	, col_fact.cust_delivery_tgt_dt 														AS cust_delivery_tgt_dt
	, IFNULL( col_fact.wh_sid, -1 ) 														AS wh_sid
	, IFNULL( NULLIF( col_fact.wh_cd, '' ), '-1' ) 											AS wh_cd
	, IFNULL( NULLIF( col_fact.prod_assortment_class_cd, '' ), '-1' ) 						AS product_assortiment_type_cd
	, col_fact.dropshipment_order_fg 														AS dropshipment_order_fg
	, col_fact.is_part_of_bundle_header_cnt_fg 												AS is_part_of_bundle_header_cnt_fg
	, col_fact.is_part_of_bundle_pos_cnt_fg 												AS is_part_of_bundle_pos_cnt_fg
	, col_fact.prod_sale_type_cd                                                            AS prod_sale_type_cd
	, IFNULL( NULLIF( col_fact.sales_segment_type_cd, '' ), '-1' ) 							AS sales_segment_type_cd
	, IFNULL( NULLIF( col_fact.order_reason_cd, '' ), '-1' ) 								AS order_reason_cd
	, IFNULL( NULLIF( col_fact.order_cancel_status_cd, '' ), '-1' ) 						AS order_cancel_status_cd
	, IFNULL( NULLIF( col_fact.delivery_src_type_cd, '' ), '-1' ) 							AS delivery_src_type_cd
	, col_fact.is_legacy_fg 																AS is_legacy_fg
	, col_fact.prod_variant_nr 																AS prod_variant_nr
	, col_fact.prod_nr 																		AS prod_nr
	, col_fact.ekp_unit_price_net_eur_val                           						AS ekp_unit_price_net_eur_val
	, col_fact.gross_margin_net_eur_val                             						AS gross_margin_net_eur_val
	, epo.is_single_position																AS is_single_position
    , col_fact.add_services_net_local_val / cer_fact.exchange_rate 						    AS add_services_net_eur_val
	, col_fact.add_services_net_local_val 													AS add_services_net_local_val
	, col_fact.add_services_gross_local_val / cer_fact.exchange_rate 						AS add_services_gross_eur_val
	, col_fact.add_services_gross_local_val 												AS add_services_gross_local_val
	, col_fact.add_services_vat_local_val / cer_fact.exchange_rate 						    AS add_services_vat_eur_val
	, col_fact.add_services_vat_local_val 													AS add_services_vat_local_val
    , col_fact.is_replacement_order_fg                                                      AS is_replacement_order_fg                                                                             
    , col_fact.ref_cust_order_sid                                                           AS ref_cust_order_sid                    
    , col_fact.ref_cust_order_nr                                                            AS ref_cust_order_nr
    , col_fact.ref_cust_order_pos_nr                                                        AS ref_cust_order_pos_nr
	, col_fact.dist_channel_cd																	AS dist_channel_cd
	, col_fact.dist_country_cd																	AS dist_country_cd
	, col_fact.dist_channel_type_cd 																AS dist_channel_type_cd
 
FROM
	lec_share.v_fact_customer_order_line 		AS col_fact

INNER JOIN
	epo_is_single_position 					AS epo 			ON epo.cust_order_sid = col_fact.cust_order_sid

INNER JOIN
	lec_share.v_fact_currency_exchange_rate 		AS cer_fact 	ON col_fact.curr_cd = cer_fact.from_curr_cd
															AND col_fact.cust_order_dt BETWEEN cer_fact.active_from_dt AND cer_fact.active_to_dt
															AND cer_fact.to_curr_cd = 'EUR'
INNER JOIN
	lec_share.v_dim_currency_exchange_rate_type 	AS cert			ON cert.curr_exchange_rate_type_cd = cer_fact.curr_exchange_rate_type_cd
															AND cert.is_general_used_fg

/* WHERE CONDITION */

INNER JOIN
	lec_share.v_dim_cal_day 						AS cal_dim 		ON cal_dim.cal_dt = col_fact.cust_order_dt
															AND cal_dim.bus_year >= 2020
;