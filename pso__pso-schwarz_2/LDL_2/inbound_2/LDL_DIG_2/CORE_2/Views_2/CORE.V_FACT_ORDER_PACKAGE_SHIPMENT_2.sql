CREATE OR REPLACE VIEW CORE.v_fact_order_package_shipment_2
(
    WSHOP_CD                        COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country_2'
   ,BUS_YEAR                        COMMENT 'The business year as a number in the form YYYY. Eg. 2019'
   ,MONTH_OF_BUS_YEAR               COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12'
   ,CUST_ORDER_DT                   COMMENT 'The date when order was made'
   ,CUST_ORDER_PERFORM_DT           COMMENT 'The timestamp when the delivery to the customer actually started. This timestamp is relevant from a financial perspective as until then you are not allowed to charge him/her. In case of serveral performance timestamps for a single article within a single order the last date is picked.'
   ,CUST_ORDER_SID                  COMMENT 'The unique identifier (surrogate key) for customer order'
   ,CUST_ORDER_POS_NR               COMMENT 'The particular position number of an item_2 in an order'
   ,PROD_VARIANT_SID                COMMENT 'Unique identifier (surrogate key) of the ordered/returned product'
   ,PROD_VARIANT_NR                 COMMENT 'The product variant number'
   ,BUNDLE_HEADER_PROD_VARIANT_SID  COMMENT 'Unique Identifier for the product variant of the bundle header to which this bundle item_2 belongs'
   ,PACK_SIZE_HANDLE_GROUP_CD       COMMENT 'A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - 1 person , 2 persons etc'
   ,PACK_SID                        COMMENT 'The unique identifier (surrogate key) for the package.'
   ,DELIV_PROD_QTY                  COMMENT 'Quantity of a specific product within a specific package_2'
   ,SHIP_COST_NET_EUR_VAL           COMMENT 'The shipping costs for Lidl Digital for each article included in a package_2 (Only Forward process)'
) COMMENT = 'One row for each combination order_position-package_2 for warehouse-deliveries, with information also about the time when the package_2 was sent, the amount of qty and the shipping costs per position'
AS  
      SELECT
			COALESCE(col.wshop_cd, fgm.wshop_cd ) 						AS wshop_cd
			, cad.bus_year												AS bus_year
			, cad.month_of_bus_year										AS month_of_bus_year
            , col.cust_order_dt                                         AS cust_order_dt
            , col.cust_order_perform_dt                                 AS cust_order_perform_dt
            , col.cust_order_sid                                        AS cust_order_sid
            , col.cust_order_pos_nr                                     AS cust_order_pos_nr
            , col.prod_variant_sid                                      AS prod_variant_sid
            , col.prod_variant_nr                                       AS prod_variant_nr
            , gh.bundle_header_prod_variant_sid                         AS bundle_header_prod_variant_sid
            , CASE WHEN pst.pack_size_handle_group_cd  IS NOT NULL 
                        THEN pst.pack_size_handle_group_cd 
                   WHEN cps.delivery_type_cd = 'Z4' THEN '2MH'
                   WHEN rel.delivery_src_type_cd = 'STR' THEN rel.pack_size_handle_group_cd
                        ELSE 'MF'
             END                                                        AS pack_size_handle_group_cd
            ,rop.pack_sid                                               AS pack_sid
            ,SUM(rop.deliv_prod_qty)                                        AS deliv_prod_qty --nice to have
            ,SUM(ship_cost_net_eur_val)                                 AS ship_cost_net_eur_val 
		FROM
            core.t_rel_order_packaging_2 				AS rop -- Table containing the pack_sid information needed
		
		INNER JOIN --Used for filter packages and get useful information (wh_leave_actual_tmsp) for both LAG and STR packages
			core.t_fact_goods_movement_2 				AS fgm 		ON          rop.delivery_order_nr = fgm.delivery_order_nr
																        AND rop.delivery_order_pos_nr = fgm.delivery_order_pos_nr
																	    AND fgm.goods_mov_cat_group_cd = 'WA' 
																	     AND fgm.cust_order_sid IS NOT NULL
																								
		LEFT JOIN -- Table containing the pack_size_type_cd needed to retrieve pack_size_handle_group_cd
			core.t_fact_sales_package_shipment_2 	    AS cps 		ON rop.pack_sid = cps.pack_sid 
			 
		LEFT JOIN
			core.t_dim_pack_size_type_2              	AS pst 		ON cps.pack_size_type_cd = pst.pack_size_type_cd
		
		LEFT JOIN 
			core.t_fact_customer_order_line_2         AS col 		ON      fgm.cust_order_sid = col.cust_order_sid
																    AND fgm.cust_order_pos_nr = col.cust_order_pos_nr
																	AND fgm.prod_variant_sid = col.prod_variant_sid
                                                                        
		INNER JOIN
			core.t_dim_cal_day_2                      AS cad 		ON DATE( fgm.wh_leave_actual_tmsp ) = cad.cal_dt -- This date is the cust_order_perform_dt -> event_dt of all the other tables			 
																
        LEFT JOIN	
            core.v_fact_order_line_bundle_component_2  AS gh      ON       gh.cust_order_sid = col.cust_order_sid    --get the bundle_header for components   
                                                                    AND  gh.cust_order_pos_nr = col.cust_order_pos_nr

        LEFT JOIN
            core.t_rel_product_variant_regional_2     AS rel      ON       col.prod_variant_sid = rel.prod_variant_sid
                                                                    AND  col.wshop_cd = rel.wshop_cd
                                                                    AND  rel.dwh_valid_fg
                                                                    
		WHERE                                                                                      
			    COALESCE( col.wshop_cd, fgm.wshop_cd ) NOT IN ('INT') 	-- To filter out inter-warehouse movements
            AND col.is_order_cancel_fg = 'FALSE' --Filter out any possible package_2 sent for cancelled orders
             AND rel.delivery_src_type_cd != 'STR' --Dropshipment packages are handled in a separate view 
		GROUP BY
			COALESCE( col.wshop_cd, fgm.wshop_cd )
			, cad.bus_year
			, cad.month_of_bus_year
            , col.cust_order_dt                                        
            , col.cust_order_perform_dt                                 
            , gh.bundle_header_prod_variant_sid
            , col.cust_order_sid
            , col.cust_order_pos_nr
            , col.prod_variant_sid
            , col.prod_variant_nr  
            , rop.pack_sid
            ,CASE WHEN pst.pack_size_handle_group_cd  IS NOT NULL THEN pst.pack_size_handle_group_cd 
                  WHEN cps.delivery_type_cd = 'Z4' THEN '2MH'
                  WHEN rel.delivery_src_type_cd = 'STR' THEN rel.pack_size_handle_group_cd
                    ELSE 'MF'
             END 
             ;