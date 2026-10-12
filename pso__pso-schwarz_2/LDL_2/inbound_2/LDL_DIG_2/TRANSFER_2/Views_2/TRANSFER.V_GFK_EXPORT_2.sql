CREATE OR REPLACE VIEW TRANSFER.V_GFK_EXPORT_2 (
	WEBSHOP_CD
	, ONLINE
	, JAHR
	, MONAT_2
	, KW
	, GS1_BRICK_EBENE_1
	, GS1_BRICK_EBENE_2
	, GS1_BRICK_EBENE_3
	, LIEFERANTENUMMER
	, LIEFERATENNAME
	, ARTIKELVARIANTE
	, GTIN_HE
	, ARTIKELBEZEICHNUNG
	, MARKE
	, MARK_UND_BEZ
	, BESTELLMENGE
	, VKP_BRUTTO
	, BESTELLUMSATZ
) AS 

SELECT
     col.wshop_cd 														                    		AS WEBSHOP_CD
    , 'online' 															                    		AS ONLINE
    , tcd.cy 															                    		AS JAHR 					
    , tcd.cy_month 														                    		AS MONAT_2 					
    , tcw.cy_week_short_name 										                        		AS KW 						
    , pbc.prod_gs1_lvl1_brick_descr 								                        		AS GS1_BRICK_EBENE_1 		
    , pbc.prod_gs1_lvl2_brick_descr 								                        		AS GS1_BRICK_EBENE_2 		
    , pbc.prod_gs1_lvl3_brick_descr 								                        		AS GS1_BRICK_EBENE_3 		
    , tds.supplier_nr 												                        		AS LIEFERANTENUMMER  		
    , tds.supplier_name 											                        		AS LIEFERATENNAME 			
    , tpv.prod_variant_nr 												                    		AS ARTIKELVARIANTE 			
    , tpv.main_ean_nr 													                    		AS GTIN_HE 					
    , tpv.prod_variant_name 											                    		AS ARTIKELBEZEICHNUNG 		
    , tdb.brand_name 												                        		AS MARKE 					
    , marke || ' ' || artikelbezeichnung 								                    		AS MARK_UND_BEZ
    , SUM( col.prod_qty ) 												                    		AS BESTELLMENGE 			
    , ROUND( SUM( col.prod_price_gross_local_val / cer.exchange_rate ) / SUM( col.prod_qty ), 2 ) 	AS VKP_BRUTTO 				
    , ROUND( SUM( col.prod_price_gross_local_val / cer.exchange_rate ), 2 )							AS BESTELLUMSATZ 			
	
FROM
    core.t_fact_customer_order_line_2 		AS col																    

JOIN
    core.t_rel_product_variant_regional_2 	AS pvr 		ON col.prod_variant_sid = pvr.prod_variant_sid 
														AND col.wshop_cd = pvr.wshop_cd
														AND pvr.dwh_valid_fg = 1 
JOIN
	core.t_dim_product_variant_2 				AS tpv 		ON pvr.prod_variant_sid = tpv.prod_variant_sid
														AND tpv.dwh_valid_fg = 1 
JOIN 
	core.t_fact_currency_exchange_rate_2 		AS cer 		ON col.curr_cd = cer.from_curr_cd
														AND DATE( cust_order_dt ) BETWEEN cer.active_from_dt AND cer.active_to_dt
														AND cer.curr_exchange_rate_type_cd = 'F'
														AND cer.to_curr_cd = 'EUR'
JOIN
	core.t_dim_product_brick_code_2 			AS pbc 		ON tpv.prod_brick_cd = pbc.prod_brick_cd
														AND pbc.dwh_valid_fg = 1
JOIN
	core.t_dim_supplier_2 					AS tds 		ON tpv.main_supplier_sid = tds.supplier_sid
														AND tds.dwh_valid_fg = 1
JOIN
	core.t_dim_cal_day_2 						AS tcd 		ON col.cust_order_dt = tcd.cal_dt					

JOIN
	core.t_dim_cal_week_2 					AS tcw 		ON tcd.cy_week = tcw.cy_week									

JOIN
	core.t_dim_brand_2 						AS tdb 		ON tpv.brand_sid = tdb.brand_sid
														AND tdb.dwh_valid_fg = 1
WHERE
		tcd.cy_week_offset = '-1'										
	AND col.wshop_cd IN (
			SELECT 
				parameter_value_char
			FROM 
				meta.t_report_parameter_2
			WHERE 
					report = 'GFK_Export'
				AND parameter_type = 'filter' 
				AND parameter_name = 'wshop_cd'
		)
	AND tpv.prod_food_class_cd IN (
			SELECT 
				parameter_value_char
			FROM 	
				meta.t_report_parameter_2
			WHERE 
					report = 'GFK_Export'
				AND parameter_type = 'filter' 
				AND parameter_name = 'prod_food_class_cd'
		)
	AND pbc.prod_gs1_lvl1_brick_cd IN (
			SELECT 
				parameter_value_char
			FROM 
				meta.t_report_parameter_2
			WHERE 
					report = 'GFK_Export'
				AND parameter_type = 'filter' 
				AND parameter_name = 'prod_gs1_lvl1_brick_cd'
		)
	AND tpv.prod_assortment_class_cd IN (
			SELECT 
				parameter_value_char
			FROM 
				meta.t_report_parameter_2
			WHERE 
					report = 'GFK_Export'
				AND parameter_type = 'filter' 
				AND parameter_name = 'prod_assortment_class_cd'
		)
	AND col.is_order_cancel_fg = 0 
	AND col.is_part_of_bundle_pos_cnt_fg = 1 -- Includes Group Component and Single Item_2
    
GROUP BY
	WEBSHOP_CD
	, JAHR 				
	, MONAT_2 				
	, KW 					
	, GS1_BRICK_EBENE_1 	
	, GS1_BRICK_EBENE_2 	
	, GS1_BRICK_EBENE_3 	
	, LIEFERANTENUMMER  	
	, LIEFERATENNAME 		
	, ARTIKELVARIANTE 		
	, GTIN_HE 				
	, ARTIKELBEZEICHNUNG 	
	, MARKE 					
;	