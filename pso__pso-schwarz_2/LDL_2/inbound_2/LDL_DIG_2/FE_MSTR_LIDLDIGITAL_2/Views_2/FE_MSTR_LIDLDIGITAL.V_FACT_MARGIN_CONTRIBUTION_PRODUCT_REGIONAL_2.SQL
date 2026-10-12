CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_MARGIN_CONTRIBUTION_PRODUCT_REGIONAL_2 (
	WSHOP_CD
	,BUS_YEAR
	,MONTH_OF_BUS_YEAR
	,CAL_DT
	,PROD_SID
	,PROD_VARIANT_SID
	,IS_WINE_SPIRITS_FG
	,PACK_SIZE_HANDLE_GROUP_CD
	,PROD_SIZE_TYPE_GROUP_CD
	,PROD_SIZE_HANDLE_GROUP_CD
	,SHIP_SIZE_HANDLE_GROUP_CD
	,DELIVERY_SRC_TYPE_CD
	,PROD_FOOD_CLASS_CD
	,BRAND_CLASS_CD
	,PROD_ORG_LVL_NAME
	,PROD_PROMO_CLASS_CD
	,PROD_VARIANT_NR
	,PROD_QTY
	,REVENUE_NET_EUR_VAL
	,REVENUE_BEFORE_LOSS_NET_EUR_VAL
	,COGS_NET_EUR_VAL
	,RETURN_PROD_QTY
	,RETURN_GOOD_PROD_QTY
	,RETURN_FOR_SERVICE_PROD_QTY
	,RETURN_DAMAGED_PROD_QTY
	,PACK_QTY_MF
	,PACK_QTY_NMF
	,PACK_QTY_2MH
	,PACK_QTY
	,RETURN_PACK_QTY_MF
	,RETURN_PACK_QTY_NMF
	,RETURN_PACK_QTY_2MH
	,RETURN_PACK_QTY
	,WH_COSTS_NET_EUR_VAL
	,SHIP_COUPON_NET_EUR_VAL
	,RETURN_PROD_BEFORE_LOSS_NET_EUR_VAL
	,RETURN_PROD_NET_EUR_VAL
	,RETURN_GOOD_PROD_NET_EUR_VAL
	,COGS_RETURN_NET_EUR_VAL
	,COGS_RETURN_GOOD_PROD_NET_EUR_VAL
	,WRITE_OFF_LOSS_NET_EUR_VAL
	,PRICE_CHANGE_LOSS_NET_EUR_VAL
	,TOTAL_COUPON_CHANGE_LOSS_NET_EUR_VAL
	,COUPON_CHANGE_LOSS_NET_EUR_VAL
	,COUPON_WRITE_OFF_LOSS_NET_EUR_VAL
	,RECYCLED_GOODS_NET_EUR_VAL
	,RECYCLING_LOSS_NET_EUR_VAL
	,SCRAPPING_LOSS_NET_EUR_VAL
	,RECYCLED_AND_SCRAPPED_PROD_QTY
	,RECYCLED_PROD_QTY
	,SCRAPPED_PROD_QTY
	,RECYCLING_REVENUE_NET_EUR_VAL
	,DISPOSAL_TRANSPORT_COST_NET_EUR_VAL
	,PROD_WITH_COUPON_QTY
	,ORDER_QTY
	,GROSS_MARGIN_NET_EUR_VAL
	,SHIP_PAUSHAL_REVENUE_NET_EUR_VAL
	,SHIP_SURCHARGE_REVENUE_NET_EUR_VAL
	,ADD_SERVICES_NET_EUR_VAL
	,RETURN_SHIP_PAUSHAL_COST_NET_EUR_VAL
	,RETURN_SHIP_SURCHARGE_COST_NET_EUR_VAL
	,RETURN_ADD_SERVICES_NET_EUR_VAL
	,GOODWILL_COST_NET_EUR_VAL
	,TOT_GOODWILL_COST_NET_EUR_VAL
	,PARTIAL_GOODWILL_COST_NET_EUR_VAL
	,VALUE_CREDIT_COST_NET_EUR_VAL
	,GHOST_PACK_COST_NET_EUR_VAL
	,PACK_LOST_BY_HAULER_COST_NET_EUR_VAL
	,SELLBACK_NET_EUR_VAL
	,SELLBACK_PROD_QTY
	,WRITE_OFF_RESIDUAL_UTIL_LOSS_NET_EUR_VAL
	,WRITE_OFF_DISCOUNT_LOSS_NET_EUR_VAL
	,PROMO_PRICE_CHANGE_LOSS_NET_EUR_VAL
	,PERM_PRICE_CHANGE_LOSS_NET_EUR_VAL
	,ADM_COST_NET_EUR_VAL
	,IT_WSHOP_COST_NET_EUR_VAL
	,IT_IC_COST_NET_EUR_VAL
	,FIN_COMPENSATION_NET_EUR_VAL
	,CURR_TAX_NET_EUR_VAL
	,RETURN_SHIP_COST_MF_NET_EUR_VAL
	,RETURN_SHIP_COST_NMF_NET_EUR_VAL
	,RETURN_SHIP_COST_2MH_NET_EUR_VAL
	,RETURN_SHIP_COST_NET_EUR_VAL
	,STOCK_DEVAL_NET_EUR_VAL
	,REIMBURS_NET_EUR_VAL
	,PERSONAL_COST_NET_EUR_VAL
	,MATERIAL_COST_NET_EUR_VAL
	,CURR_EX_RATE_DIFF_NET_EUR_VAL
	,ADV_COST_NET_EUR_VAL
	,IC_INCOME_NET_EUR_VAL
	,IC_COST_NET_EUR_VAL
	,CORPORATE_COST_NET_EUR_VAL
	,OTHER_MATERIAL_COST_NET_EUR_VAL
	,EXT_STORAGE_COST_NET_EUR_VAL
	,TRANSPORT_COST_NET_EUR_VAL
	,DELIVERY_COST_NET_EUR_VAL
	,SHIP_COST_MF_NET_EUR_VAL
	,SHIP_COST_NMF_NET_EUR_VAL
	,SHIP_COST_2MH_NET_EUR_VAL
	,SHIP_COST_NET_EUR_VAL
	,TAX_NET_EUR_VAL
	,COMMON_FEES_NET_EUR_VAL
	,REPLACEMENT_ORDER_REVENUE_NET_EUR_VAL
	,REPLACEMENT_ORDER_COGS_NET_EUR_VAL
	,REPLACEMENT_ORDER_SHIP_REVENUE_NET_EUR_VAL
	,REPLACEMENT_ORDER_PROD_QTY
	,ORDER_QTY_WITH_VK_ZERO
	,ADV_COST_NET_PERFORMANCE
	,ADV_COST_NET_GENERIC
	,ADV_COST_NET_FIX
	,WH_COSTS_NET_VARIABLE_SHIPMENT
	,WH_COSTS_NET_VARIABLE_RETURN
	,WH_COSTS_NET_FIX_SHIPMENT
	,WH_COSTS_NET_FIX_RETURN
	,PERSONAL_COST_NET_CENTRAL
	,PERSONAL_COST_NET_COUNTRY
	,BRANCH_SHIP_COUPON_NET_EUR_VAL
	,CSA_SHIP_COUPON_NET_EUR_VAL
	,CANCEL_REVENUE_NET_EUR_VAL
	) COMMENT = ' Version  1.10  | Dominik Pfarr      | 2025-04-23 | adding new metrics for Advertising, wh cost, personal cost, orders as of AP0265479
            Version  1.11  | Dominik Pfarr      | 2025-04-28 | adding more metrics as of AP0265479
            Version  1.12  | Dominik Pfarr      | 2025-05-15 | adjust formula for vk_frei  ' 
            
            AS

SELECT wshop_cd
	,bus_year
	,month_of_bus_year
	,cal_dt
	,prod_sid
	,prod_variant_sid
	,is_wine_spirits_fg
	,IFNULL(NULLIF(pack_size_handle_group_cd, ''), '-1') AS pack_size_handle_group_cd
	,IFNULL(NULLIF(prod_size_type_group_cd, ''), '-1') AS prod_size_type_group_cd
	,IFNULL(NULLIF(prod_size_handle_group_cd, ''), '-1') AS prod_size_handle_group_cd
	,IFNULL(NULLIF(ship_size_handle_group_cd, ''), 'P_-1') AS ship_size_handle_group_cd
	,IFNULL(NULLIF(delivery_src_type_cd, ''), '-1') AS delivery_src_type_cd
	,IFNULL(NULLIF(prod_food_class_cd, ''), '-1') AS prod_food_class_cd
	,IFNULL(NULLIF(brand_class_cd, ''), '-1') AS brand_class_cd
	,IFNULL(NULLIF(prod_org_lvl_name, ''), '-1') AS prod_org_lvl_name
	,IFNULL(NULLIF(prod_promo_class_cd, ''), '-1') AS prod_promo_class_cd
	,IFNULL(NULLIF(prod_variant_nr, ''), '-1') AS prod_variant_nr
	,prod_qty
	,revenue_net_eur_val
	,revenue_before_loss_net_eur_val
	,cogs_net_eur_val
	,return_prod_qty
	,return_good_prod_qty
	,return_for_service_prod_qty
	,return_damaged_prod_qty
	,pack_qty_mf
	,pack_qty_nmf
	,pack_qty_2mh
	,ZEROIFNULL(pack_qty_mf) + ZEROIFNULL(pack_qty_nmf) + ZEROIFNULL(pack_qty_2mh) AS pack_qty
	,return_pack_qty_mf
	,return_pack_qty_nmf
	,return_pack_qty_2mh
	,ZEROIFNULL(return_pack_qty_mf) + ZEROIFNULL(return_pack_qty_nmf) + ZEROIFNULL(return_pack_qty_2mh) AS return_pack_qty
	,wh_costs_net_eur_val
	,ship_coupon_net_eur_val
	,return_prod_before_loss_net_eur_val
	,return_prod_net_eur_val
	,return_good_prod_net_eur_val
	,cogs_return_net_eur_val
	,cogs_return_good_prod_net_eur_val
	,ZEROIFNULL(write_off_residual_util_loss_net_eur_val) + ZEROIFNULL(write_off_discount_loss_net_eur_val) AS write_off_loss_net_eur_val
	,ZEROIFNULL(promo_price_change_loss_net_eur_val) + ZEROIFNULL(perm_price_change_loss_net_eur_val) AS price_change_loss_net_eur_val
	,ZEROIFNULL(coupon_change_loss_net_eur_val) + ZEROIFNULL(coupon_write_off_loss_net_eur_val) AS total_coupon_loss_net_eur_val
	,coupon_change_loss_net_eur_val
	,ZEROIFNULL(coupon_write_off_loss_net_eur_val) AS coupon_write_off_loss_net_eur_val
	,ZEROIFNULL(recycled_goods_net_eur_val) + ZEROIFNULL(recycling_revenue_net_eur_val) + ZEROIFNULL(disposal_transport_cost_net_eur_val) AS recycled_goods_net_eur_val --disposal losses + revenue + transport costs
	,ZEROIFNULL(recycling_loss_net_eur_val) AS recycling_loss_net_eur_val
	,ZEROIFNULL(scrapping_loss_net_eur_val) AS scrapping_loss_net_eur_val
	,ZEROIFNULL(recycled_and_scrapped_prod_qty) AS recycled_and_scrapped_prod_qty
	,ZEROIFNULL(recycled_prod_qty) AS recycled_prod_qty
	,ZEROIFNULL(scrapped_prod_qty) AS scrapped_prod_qty
	,ZEROIFNULL(recycling_revenue_net_eur_val) AS recycling_revenue_net_eur_val
	,ZEROIFNULL(disposal_transport_cost_net_eur_val) AS disposal_transport_cost_net_eur_val
	,prod_with_coupon_qty
	,order_qty
	,gross_margin_net_eur_val
	,ship_paushal_revenue_net_eur_val
	,ship_surcharge_revenue_net_eur_val
	,ZEROIFNULL(add_services_net_eur_val) AS add_services_net_eur_val
	,return_ship_paushal_cost_net_eur_val
	,return_ship_surcharge_cost_net_eur_val
	,ZEROIFNULL(return_add_services_net_eur_val) AS return_add_services_net_eur_val
	,ZEROIFNULL(goodwill_cost_net_eur_val) + ZEROIFNULL(value_credit_cost_net_eur_val) + ZEROIFNULL(ghost_pack_cost_net_eur_val) + ZEROIFNULL(pack_lost_by_hauler_cost_net_eur_val) AS goodwill_cost_net_eur_val
	,ZEROIFNULL(goodwill_cost_net_eur_val) + ZEROIFNULL(value_credit_cost_net_eur_val) + ZEROIFNULL(ghost_pack_cost_net_eur_val) + ZEROIFNULL(pack_lost_by_hauler_cost_net_eur_val) AS tot_goodwill_cost_net_eur_val
	,goodwill_cost_net_eur_val AS partial_goodwill_cost_net_eur_val
	,value_credit_cost_net_eur_val
	,ghost_pack_cost_net_eur_val
	,pack_lost_by_hauler_cost_net_eur_val
	,sellback_net_eur_val
	,sellback_prod_qty
	,write_off_residual_util_loss_net_eur_val
	,write_off_discount_loss_net_eur_val
	,promo_price_change_loss_net_eur_val
	,perm_price_change_loss_net_eur_val
	,adm_cost_net_eur_val
	,it_wshop_cost_net_eur_val
	,it_ic_cost_net_eur_val
	,fin_compensation_net_eur_val
	,curr_tax_net_eur_val
	,return_ship_cost_mf_net_eur_val
	,return_ship_cost_nmf_net_eur_val
	,return_ship_cost_2mh_net_eur_val
	,ZEROIFNULL(return_ship_cost_mf_net_eur_val) + ZEROIFNULL(return_ship_cost_nmf_net_eur_val) + ZEROIFNULL(return_ship_cost_2mh_net_eur_val) AS return_ship_cost_net_eur_val
	,stock_deval_net_eur_val
	,reimburs_net_eur_val
	,personal_cost_net_eur_val
	,material_cost_net_eur_val
	,curr_ex_rate_diff_net_eur_val
	,adv_cost_net_eur_val
	,ic_income_net_eur_val
	,ic_cost_net_eur_val
	,corporate_cost_net_eur_val
	,other_material_cost_net_eur_val
	,ext_storage_cost_net_eur_val
	,transport_cost_net_eur_val
	,delivery_cost_net_eur_val
	,ship_cost_mf_net_eur_val
	,ship_cost_nmf_net_eur_val
	,ship_cost_2mh_net_eur_val
	,ZEROIFNULL(ship_cost_mf_net_eur_val) + ZEROIFNULL(ship_cost_nmf_net_eur_val) + ZEROIFNULL(ship_cost_2mh_net_eur_val) AS ship_cost_net_eur_val
	,tax_net_eur_val
	,common_fees_net_eur_val
	,ZEROIFNULL(replacement_order_revenue_net_eur_val) AS replacement_order_revenue_net_eur_val
	,ZEROIFNULL(replacement_order_cogs_net_eur_val) AS replacement_order_cogs_net_eur_val
	,ZEROIFNULL(replacement_order_ship_revenue_net_eur_val) AS replacement_order_ship_revenue_net_eur_val
	,ZEROIFNULL(replacement_order_prod_qty) AS replacement_order_prod_qty
	,CASE 
		WHEN (SHIP_PAUSHAL_REVENUE_NET_EUR_VAL + SHIP_COUPON_NET_EUR_VAL) = 0
			THEN order_qty
		END AS order_qty_with_vk_zero
	,adv_cost_net_eur_val * 0.2 AS ADV_COST_NET_PERFORMANCE
	,adv_cost_net_eur_val * 0.3 AS ADV_COST_NET_GENERIC
	,adv_cost_net_eur_val * 0.5 AS ADV_COST_NET_FIX
	,WH_COSTS_NET_EUR_VAL * 0.1 AS WH_COSTS_NET_VARIABLE_SHIPMENT
	,WH_COSTS_NET_EUR_VAL * 0.2 AS WH_COSTS_NET_VARIABLE_RETURN
	,WH_COSTS_NET_EUR_VAL * 0.3 AS WH_COSTS_NET_FIX_SHIPMENT
	,WH_COSTS_NET_EUR_VAL * 0.4 AS WH_COSTS_NET_FIX_RETURN
	,personal_cost_net_eur_val * 0.3 AS PERSONAL_COST_NET_CENTRAL
	,personal_cost_net_eur_val * 0.7 AS PERSONAL_COST_NET_COUNTRY
	,BRANCH_SHIP_COUPON_NET_EUR_VAL
	,CSA_SHIP_COUPON_NET_EUR_VAL
	,CANCEL_REVENUE_NET_EUR_VAL
FROM core.t_fact_margin_contribution_product_regional_daily_2;