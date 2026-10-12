CREATE OR REPLACE VIEW transfer.v_gfk_export_artikelverkaufsdaten
(
	webshop      
	, datum
	, artikelvariante      
	, gtin               
	, artikelbezeichnung   
	, artikeluntergruppe
	, untergruppenbezeichnung
	, artikelfamilie
	, familienbezeichnung
	, lieferantenummer       
	, lieferantenname        
	, markentyp
	, marke  
	, bestellmenge
	, bestellumsatz
	, bruttoverkaufspreis      
) AS
SELECT
    wshop_cd                           AS webshop_cd
    , cal_dt                           AS datum
    , prod_variant_nr                  AS artikelvariante
    , main_ean_nr                      AS gtin
    , prod_variant_descr               AS artikelbezeichnung
    , prod_subgroup_cd                 AS src_item_subgrp_cd
    , prod_subgroup_descr              AS item_subgrp_desc
    , prod_family_cd                   AS src_item_family_cd
    , prod_family_descr                AS item_family_desc
    , supplier_nr                      AS lieferantenummer
    , supplier_name                    AS lieferatenname
    , brand_class_descr                AS markentyp
    , brand_name                       AS marke
    , sales_qty_ac_ar                  AS bestellmenge
    , gross_sales_revenue_eur_ac_ar    AS bestellumsatz
    , avg_sales_gross_unit_price_eur   AS vkp_brutto
FROM
(
    WITH 
        cte_dim AS (
            SELECT
                pvr.wshop_cd                                AS wshop_cd            
                , pv.prod_variant_sid                       AS prod_variant_sid
                , pv.prod_variant_nr 		                AS prod_variant_nr                  
                , pv.main_ean_nr 			                AS main_ean_nr                      
                , pv.prod_variant_descr                     AS prod_variant_descr                    
                , fam.prod_subgroup_cd                      AS prod_subgroup_cd
                , sgr.prod_subgroup_descr                   AS prod_subgroup_descr
                , REPLACE( pr.prod_family_cd, '.', '_' )    AS prod_family_cd 
                , fam.prod_family_descr                     AS prod_family_descr 
                , tds.supplier_nr 			                AS supplier_nr                   		
                , tds.supplier_name 		                AS supplier_name               		    	
                , bcl.brand_class_cd                        AS brand_class_descr
                , brd.brand_name 			                AS brand_name                  
            FROM
                core.t_dim_product_variant              AS pv
                
            JOIN
                core.t_dim_product                      AS pr       ON pv.prod_sid = pr.prod_sid
                                                                    AND pv.dwh_valid_fg = 1
                                                                    AND pr.dwh_valid_fg = 1
            JOIN
                core.t_rel_product_variant_regional 	AS pvr 		ON pv.prod_variant_sid = pvr.prod_variant_sid 
            														AND pvr.dwh_valid_fg = 1
                                                                    AND pr.dwh_valid_fg = 1
            LEFT JOIN
            	core.t_dim_supplier 					AS tds 		ON pv.main_supplier_sid = tds.supplier_sid
            														AND tds.dwh_valid_fg = 1
            LEFT JOIN
            	core.t_dim_brand 						AS brd 		ON pv.brand_sid = brd.brand_sid
            														AND brd.dwh_valid_fg = 1 
            LEFT JOIN
                core.t_dim_brand_classification         AS bcl      ON brd.brand_class_cd = bcl.brand_class_cd
                                                                    
            LEFT JOIN
                core.t_dim_product_family               AS fam      ON pr.prod_family_cd = fam.prod_family_cd

            LEFT JOIN
                core.t_dim_product_subgroup             AS sgr      ON fam.prod_subgroup_cd = sgr.prod_subgroup_cd

            LEFT JOIN
                core.t_dim_product_brick_code           AS pbc      ON pr.prod_brick_cd = pbc.prod_brick_cd
                                                                    AND pbc.dwh_valid_fg = 1
        	
            WHERE
                pvr.wshop_cd IN (
        			SELECT 
        				parameter_value_char
        			FROM 
        				meta.t_report_parameter
        			WHERE 
        					report = 'GFK_Export'
        				AND parameter_type = 'filter' 
        				AND parameter_name = 'wshop_cd'
        		)
            AND 
                pv.prod_food_class_cd IN (
                    SELECT 
                        parameter_value_char
                    FROM 	
                        meta.t_report_parameter
                    WHERE 
                            report = 'GFK_Export'
                        AND parameter_type = 'filter' 
                        AND parameter_name = 'prod_food_class_cd'
                )
            AND 
                pv.prod_assortment_class_cd IN (
                    SELECT 
                        parameter_value_char
                    FROM 
                        meta.t_report_parameter
                    WHERE 
                            report = 'GFK_Export'
                        AND parameter_type = 'filter' 
                        AND parameter_name = 'prod_assortment_class_cd'
                )
            AND 
                pbc.prod_gs1_lvl1_brick_cd IN (
            		SELECT 
            			parameter_value_char
            		FROM 
            			meta.t_report_parameter
            		WHERE 
            				report = 'GFK_Export'
            			AND parameter_type = 'filter' 
            			AND parameter_name = 'prod_gs1_lvl1_brick_cd'
            	)
        )
        , cte_facts_orders AS (
            SELECT
                col.cust_order_dt                                               AS cust_order_dt                    
                , col.wshop_cd                                                  AS wshop_cd                    
                , col.prod_variant_sid                                          AS prod_variant_sid                    
                , SUM( col.prod_qty )                                           AS prod_qty 
                , SUM( col.prod_price_gross_local_val / cer.exchange_rate )     AS prod_price_gross_local_val 
            FROM
                core.t_fact_customer_order_line        AS col
            LEFT JOIN 
            	core.t_fact_currency_exchange_rate     AS cer 		ON col.curr_cd = cer.from_curr_cd
            														AND col.cust_order_dt BETWEEN cer.active_from_dt AND cer.active_to_dt
            														AND cer.curr_exchange_rate_type_cd = 'F'
            														AND cer.to_curr_cd = 'EUR'
            WHERE
            		col.is_order_cancel_fg = 0 
            	AND col.is_part_of_bundle_pos_cnt_fg = 1 -- Includes Group Component and Single Item
                    
            GROUP BY
                col.cust_order_dt
                , col.wshop_cd
                , col.prod_variant_sid
        )
        , cte_facts_returns AS (
            SELECT
                cor.cust_order_return_dt                                        AS cust_order_return_dt                    
                , cor.wshop_cd                                                  AS wshop_cd                    
                , cor.prod_variant_sid                                          AS prod_variant_sid                    
                , SUM( cor.prod_qty )                                           AS prod_qty 
                , SUM( cor.prod_price_gross_local_val / cer.exchange_rate )     AS prod_price_gross_local_val 
            FROM
                core.t_fact_customer_return_line       AS cor
            LEFT JOIN 
            	core.t_fact_currency_exchange_rate     AS cer 		ON cor.curr_cd = cer.from_curr_cd
            														AND cor.cust_order_dt BETWEEN cer.active_from_dt AND cer.active_to_dt
            														AND cer.curr_exchange_rate_type_cd = 'F'
            														AND cer.to_curr_cd = 'EUR'
                    
            GROUP BY
                cor.cust_order_return_dt
                , cor.wshop_cd
                , cor.prod_variant_sid
        )
        , cte_facts AS (
            SELECT
                COALESCE( col.cust_order_dt, cor.cust_order_return_dt )                                                           AS cal_dt                          
                , COALESCE( col.wshop_cd, cor.wshop_cd )                                                                          AS wshop_cd                        	
                , COALESCE( col.prod_variant_sid, cor.prod_variant_sid )                                                          AS prod_variant_sid
                , ( ZEROIFNULL( col.prod_qty ) - ZEROIFNULL( cor.prod_qty ) )::NUMBER(38,2)                                       AS sales_qty_ac_ar
                , ( ZEROIFNULL( col.prod_price_gross_local_val ) - ZEROIFNULL( cor.prod_price_gross_local_val ) )::NUMBER(38,2)   AS gross_sales_revenue_eur_ac_ar
                , ( ZEROIFNULL( DIV0( gross_sales_revenue_eur_ac_ar, sales_qty_ac_ar ) ) )::NUMBER(38,2)                          AS avg_sales_gross_unit_price_eur  
            FROM
                cte_facts_orders    AS col
            FULL JOIN
                cte_facts_returns   AS cor       ON col.wshop_cd = cor.wshop_cd
                                                 AND col.cust_order_dt = cor.cust_order_return_dt
                                                 AND col.prod_variant_sid = cor.prod_variant_sid    
        )
    SELECT
        dim.wshop_cd                             -- webshop      
        , facts.cal_dt                           -- datum
        , dim.prod_variant_nr                    -- artikelvariante      
        , dim.main_ean_nr                        -- gtin               
        , dim.prod_variant_descr                 -- artikelbezeichnung   
        , dim.prod_subgroup_cd                   -- artikeluntergruppe
        , dim.prod_subgroup_descr                -- untergruppenbezeichnung
        , dim.prod_family_cd                     -- artikelfamilie
        , dim.prod_family_descr                  -- familienbezeichnung
        , dim.supplier_nr                        -- lieferantenummer           
        , dim.supplier_name                      -- lieferantenname            
        , dim.brand_class_descr                  -- markentyp
        , dim.brand_name                         -- marke  
        , facts.sales_qty_ac_ar                  -- bestellmenge
        , facts.gross_sales_revenue_eur_ac_ar    -- bestellumsatz
        , facts.avg_sales_gross_unit_price_eur   -- bruttoverkaufspreis  
    FROM
        cte_dim    AS dim 
    JOIN
        cte_facts  AS facts     ON dim.wshop_cd = facts.wshop_cd
                                AND dim.prod_variant_sid = facts.prod_variant_sid
)
;