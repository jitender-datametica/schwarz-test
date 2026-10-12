CREATE OR REPLACE VIEW CORE.V_FACT_DROPSHIPMENT_ORDER_PACKAGE_SHIPMENT(
	WSHOP_CD COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country',
	BUS_YEAR COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
	MONTH_OF_BUS_YEAR COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12',
	CUST_ORDER_DT COMMENT 'The date when order was made',
	CUST_ORDER_PERFORM_DT COMMENT 'The timestamp when the delivery to the customer actually started. This timestamp is relevant from a financial perspective as until then you are not allowed to charge him/her. In case of serveral performance timestamps for a single article within a single order the last date is picked.',
	CUST_ORDER_SID COMMENT 'The unique identifier (surrogate key) for customer order',
	CUST_ORDER_POS_NR COMMENT 'The particular position number of an item in an order',
	PROD_VARIANT_SID COMMENT 'Unique identifier (surrogate key) of the ordered/returned product',
	PROD_VARIANT_NR COMMENT 'The product variant number',
	BUNDLE_HEADER_PROD_VARIANT_SID COMMENT 'Unique Identifier for the product variant of the bundle header to which this bundle item belongs',
	PACK_SIZE_HANDLE_GROUP_CD COMMENT 'A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - 1 person , 2 persons etc',
    DELIVERY_ORDER_SID COMMENT 'The unique identifier (surrogate key) for delivery order',
	PACK_SID COMMENT 'The unique identifier (surrogate key) for the package.',
    IS_MISSING_PACK_INFO_FG COMMENT 'In case the package information (pack_nr/pack_url) are not present on SAP because the supplier doesn´t use standard KEP services, the flag is set on TRUE. In these cases the delivery_orde info are the maximum detailed information we have about the delivery',
    DELIV_PROD_QTY COMMENT 'Quantity of a specific product within a specific package',
	SHIP_COST_NET_EUR_VAL COMMENT 'The shipping costs for Lidl Digital for each article included in a package (Only Forward process)'
)  COMMENT = 'One row for each combination order_position-delivery-package for Dropshipment deliveries, with information also about the time when the package was sent, the amount of qty and the shipping costs per position'
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
            , rel.pack_size_handle_group_cd                             AS pack_size_handle_group_cd
            , fgm.delivery_order_sid                                    AS delivery_order_sid
            , IFNULL(rop.pack_sid,'-1')                                 AS pack_sid   -- the -1 is used to give a "SID" to the deliveries that don´t have packages information
            , CASE WHEN rop.pack_sid IS NULL
                    THEN 'TRUE'
                    ELSE 'FALSE'
              END                                                       AS is_missing_pack_info_fg --if no information about packages in SAP then flag = 0 (happens for deliveries from suppliers that don´t use standard KEP carriers)
            , SUM(COALESCE(rop.deliv_prod_qty, fgm.delivery_prod_qty))  AS deliv_prod_qty  --if there is a pack_sid take the quantities in the package (more precise) otherwise the delivery_qty
            , SUM(price_val * COALESCE(rop.deliv_prod_qty, fgm.delivery_prod_qty) * (-1))  AS ship_cost_net_eur_val  --if there is a pack_sid take the quantities in the package (more precise) otherwise the delivery_qty
        FROM 
            core.t_fact_goods_movement             AS fgm				
																		   
		
		LEFT JOIN 
			core.t_fact_customer_order_line         AS col 		ON      fgm.cust_order_sid = col.cust_order_sid
																    AND fgm.cust_order_pos_nr = col.cust_order_pos_nr
																	AND fgm.prod_variant_sid = col.prod_variant_sid

        LEFT JOIN
			core.t_rel_product_variant_regional    AS rel       ON
                                                                        rel.prod_variant_sid = col.prod_variant_sid
                                                                    AND rel.dwh_valid_fg
                                                                    AND rel.wshop_cd = col.wshop_cd

        LEFT JOIN 
			core.t_rel_order_packaging             AS rop 		ON      rop.cust_order_sid = col.cust_order_sid
																    AND rop.cust_order_pos_nr = col.cust_order_pos_nr
																	AND rop.prod_variant_sid = col.prod_variant_sid
                                                                    AND fgm.delivery_order_sid = rop.delivery_order_sid
                                                                    AND fgm.delivery_order_pos_nr = rop.delivery_order_pos_nr
                                                              
		INNER JOIN
			core.t_dim_cal_day                      AS cad 		ON DATE( fgm.wh_leave_actual_tmsp ) = cad.cal_dt -- This date is the cust_order_perform_dt -> event_dt of all the other tables			 
																
        LEFT JOIN	
            core.v_fact_order_line_bundle_component  AS gh      ON       gh.cust_order_sid = col.cust_order_sid    --get the bundle_header for components   
                                                                    AND  gh.cust_order_pos_nr = col.cust_order_pos_nr
        JOIN 
            core.t_dim_product_variant          AS var
            ON      var.dwh_valid_fg
                AND var.prod_variant_sid = rel.prod_variant_sid
        LEFT JOIN
            core.t_fact_product_price_supplier  AS pps
             ON      col.wshop_cd = pps.wshop_cd
                 AND col.prod_variant_sid = pps.prod_variant_sid
                 AND var.main_supplier_sid = pps.supplier_sid
                 AND price_type_cd = 'FKZ'                                                                      --Freight Costs (price condition fee for delivery defined by the supplier)
                 AND col.cust_order_perform_dt BETWEEN DATE(pps.active_from_tmsp) AND DATE(pps.active_to_tmsp)
                                                                    
		WHERE    
                fgm.goods_mov_cat_group_cd = 'WE'  
                AND fgm.dropshipment_order_fg = 1 --filter to get only dropshipment values
                AND rel.delivery_src_type_cd = 'STR' --filter to get only dropshipment values
                AND fgm.cust_order_sid IS NOT NULL 
			    AND COALESCE( col.wshop_cd, fgm.wshop_cd ) NOT IN ('INT') 	-- To filter out inter-warehouse movements
                AND col.is_order_cancel_fg = 'FALSE' --Filter out any possible package sent for cancelled orders
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
            , rel.pack_size_handle_group_cd
            , fgm.delivery_order_sid
            , rop.pack_sid
            , is_missing_pack_info_fg
        ;