CREATE OR REPLACE VIEW fe_mstr_lidldigital.v_dim_product_variant_1
(
  	prod_variant_sid
	, prod_variant_nr
	, prod_variant_name
	, prod_variant_descr
	, prod_sid
	, prod_nr
	, prod_name
	, ian_nr
    , ian_nr_artikelabverkauf
	, main_ean_nr
    , prod_variant_hist_nr
    , prod_variant_ian_nr
	, combined_prod_variant_ian_nr
	, volume_meas
	, volume_uom_cd
	, volume_str
	, volume_meas_standard
	, volume_meas_standard_uom_cd
	, weight_meas
    , gross_weight_meas
    , net_weight_meas
	, weight_uom_cd
	, weight_str
	, weight_meas_standard
    , gross_weight_str
    , gross_weight_meas_standard
    , net_weight_str
    , net_weight_meas_standard
	, weight_meas_standard_uom_cd
	, girth_east_meas
	, girth_west_meas
	, girth_uom_cd
	, girth_east_str
	, girth_east_meas_standard
	, girth_west_str
	, girth_west_meas_standard
	, girth_meas_standard_uom_cd
	, length_meas
	, length_uom_cd
	, length_str
	, length_meas_standard
	, length_meas_standard_uom_cd
	, mean_length_meas
	, mean_length_str
	, mean_length_meas_standard
	, shortest_length_meas
	, shortest_length_str
	, shortest_length_meas_standard
	, longest_length_meas
	, longest_length_str
	, longest_length_meas_standard
	, width_meas
	, width_uom_cd
	, width_str
	, width_meas_standard
	, width_meas_standard_uom_cd
	, height_meas
	, height_uom_cd
	, height_str
	, height_meas_standard
	, height_meas_standard_uom_cd
	, prod_size_type_cd
	, is_bulky_item_fg
	, prod_orig_country_cd
	, brand_sid
	, brand_class_cd
	, prod_assortment_class_cd
	, prod_global_status_cd
	, prod_food_class_cd
	, palette_capacity_cnt
	, package_capacity_cnt
	, container_capacity_cnt
	, main_supplier_sid
	, shop_cat_sid
	, shop_cat_name
	, shop_cat_lvl4_sid
	, shop_cat_lvl4_name
	, shop_cat_lvl3_sid
	, shop_cat_lvl3_name
	, shop_cat_lvl2_sid
	, shop_cat_lvl2_name
	, shop_cat_lvl1_sid
	, shop_cat_lvl1_name
    , prod_variant_src_insert_dt
    , prod_variant_src_update_dt
	, first_inbound_dt
    , prod_brick_cd
    , commodity_fg
    , is_bundle_header_fg
    , prod_variant_import_nr
    , einlager_kz
    , prod_org_lvl_name
    , PROD_VARIANT_PACKING_TYPE_CD
) 
AS SELECT
    pv.prod_variant_sid 																AS prod_variant_sid 
    , pv.prod_variant_nr																AS prod_variant_nr 
    , pv.prod_variant_name																AS prod_variant_name 
    , pv.prod_variant_descr																AS prod_variant_descr 
    , pv.prod_sid																		AS prod_sid 
    , pr.prod_nr																		AS prod_nr 
    , pr.prod_name																		AS prod_name 
	, COALESCE( pv.prod_variant_ian_nr, pv.ian_nr, ' ' )								AS ian_nr 
	, COALESCE( pv.prod_variant_ian_nr, pv.ian_nr, 'n/a' )								AS ian_nr_artikelabverkauf 
    , pv.main_ean_nr																	AS main_ean_nr 
    , pv.prod_variant_hist_nr															AS prod_variant_hist_nr 
    , pv.prod_variant_ian_nr															AS prod_variant_ian_nr 
	, IFNULL( pv.prod_variant_ian_nr, pv.ian_nr )										AS combined_prod_variant_ian_nr 
    , pv.volume_meas																	AS volume_meas 
    , IFNULL( uom_volume.uom_cd, '-1' ) 												AS volume_uom_cd 
    , LEFT( pv.volume_meas || ' ' || uom_volume.uom_cd, 20 )::VARCHAR(20) 				AS volume_str 
    , volume_meas * uom_volume.uom_standard_multipl_meas 								AS volume_meas_standard 
    , IFNULL( uom_volume.uom_standard_cd, '-1' ) 										AS volume_meas_standard_uom_cd 
    , pv.gross_weight_meas 																AS weight_meas 
    , pv.gross_weight_meas 																AS gross_weight_meas 
    , pv.net_weight_meas 																AS net_weight_meas 
    , IFNULL( uom_weight.uom_cd, '-1' ) 												AS weight_uom_cd 
    , LEFT( pv.gross_weight_meas || ' ' || uom_weight.uom_cd, 20 )::VARCHAR(20) 		AS weight_str 
    , pv.gross_weight_meas * uom_weight.uom_standard_multipl_meas 						AS weight_meas_standard 
    , LEFT( pv.gross_weight_meas || ' ' || uom_weight.uom_cd, 20 )::VARCHAR(20) 		AS gross_weight_str 
    , pv.gross_weight_meas * uom_weight.uom_standard_multipl_meas 						AS gross_weight_meas_standard 
    , LEFT( pv.net_weight_meas || ' ' || uom_weight.uom_cd, 20 )::VARCHAR(20) 			AS net_weight_str 
    , pv.net_weight_meas * uom_weight.uom_standard_multipl_meas                         AS net_weight_meas_standard 
    , IFNULL( uom_weight.uom_standard_cd, '-1' )                                        AS weight_meas_standard_uom_cd 
    , pv.girth_east_meas                                                                AS girth_east_meas 
    , pv.girth_west_meas                                                                AS girth_west_meas 
    , IFNULL( uom_girth.uom_cd, '-1' )                                                  AS girth_uom_cd 
    , LEFT( pv.girth_east_meas || ' ' || uom_girth.uom_cd, 20 )::VARCHAR(20)            AS girth_east_str 
    , pv.girth_east_meas * uom_girth.uom_standard_multipl_meas                          AS girth_east_meas_standard 
    , LEFT( pv.girth_west_meas || ' ' || uom_girth.uom_cd, 20 )::VARCHAR(20)            AS girth_west_str 
    , pv.girth_west_meas * uom_girth.uom_standard_multipl_meas                          AS girth_west_meas_standard 
    , IFNULL( uom_girth.uom_standard_cd, '-1' )                                         AS girth_meas_standard_uom_cd 
    , pv.length_meas                                                                    AS length_meas 
    , IFNULL( uom_length.uom_cd, '-1' )                                                 AS length_uom_cd 
    , LEFT( pv.length_meas || ' ' || uom_length.uom_cd, 20 )::VARCHAR(20)               AS length_str 
    , pv.length_meas * uom_length.uom_standard_multipl_meas                             AS length_meas_standard 
    , IFNULL( uom_length.uom_standard_cd, '-1' )                                        AS length_meas_standard_uom_cd 
    , pv.mean_length_meas                                                               AS mean_length_meas 
    , LEFT( pv.mean_length_meas || ' ' || uom_length.uom_cd, 20 )::VARCHAR(20)          AS mean_length_str 
    , pv.mean_length_meas * uom_length.uom_standard_multipl_meas                        AS mean_length_meas_standard 
    , pv.shortest_length_meas                                                           AS shortest_length_meas 
    , LEFT( pv.shortest_length_meas || ' ' || uom_length.uom_cd, 20 )::VARCHAR(20)      AS shortest_length_str 
    , pv.shortest_length_meas * uom_length.uom_standard_multipl_meas                    AS shortest_length_meas_standard 
    , pv.longest_length_meas                                                            AS longest_length_meas 
    , LEFT( pv.longest_length_meas || ' ' || uom_length.uom_cd, 20 )::VARCHAR(20)       AS longest_length_str 
    , pv.longest_length_meas * uom_length.uom_standard_multipl_meas                     AS longest_length_meas_standard 
    , pv.width_meas                                                                     AS width_meas 
    , IFNULL( uom_width.uom_cd, '-1' )                                                  AS width_uom_cd 
    , LEFT( pv.width_meas || ' ' || uom_width.uom_cd, 20 )::VARCHAR(20)                 AS width_str 
    , pv.width_meas * uom_width.uom_standard_multipl_meas                               AS width_meas_standard 
    , IFNULL( uom_width.uom_standard_cd, '-1' )                                         AS width_meas_standard_uom_cd 
    , pv.height_meas                                                                    AS height_meas 
    , IFNULL( uom_height.uom_cd, '-1' )                                                 AS height_uom_cd 
    , LEFT( pv.height_meas || ' ' || uom_height.uom_cd, 20 )::VARCHAR(20)               AS height_str 
    , pv.height_meas * uom_height.uom_standard_multipl_meas                             AS height_meas_standard 
    , IFNULL( uom_height.uom_standard_cd, '-1' )                                        AS height_meas_standard_uom_cd 
	, IFNULL( NULLIF( pv.prod_size_type_cd, '' ), '-1' )                                AS prod_size_type_cd 
    , pv.is_bulky_item_fg                                                               AS is_bulky_item_fg 
    , IFNULL( NULLIF( pv.prod_orig_country_cd, '' ), '-1' )                             AS prod_orig_country_cd 
	, IFNULL( pv.brand_sid, '-1' )                                                      AS brand_sid 
    , IFNULL( NULLIF( pv.brand_class_cd, '' ), '-1' )                                   AS brand_class_cd 
    , IFNULL( NULLIF( pv.prod_assortment_class_cd, '' ), '-1' )                         AS prod_assortment_class_cd 
    , IFNULL( NULLIF( pv.prod_global_status_cd, '' ), '-1' )                            AS prod_global_status_cd 
    , IFNULL( NULLIF( pv.prod_food_class_cd, '' ), '-1' )                               AS prod_food_class_cd 
	, pv.palette_capacity_cnt                                                           AS palette_capacity_cnt 
    , pv.package_capacity_cnt                                                           AS package_capacity_cnt 
    , pv.container_capacity_cnt                                                         AS container_capacity_cnt 
    , IFNULL( pv.main_supplier_sid, '-1' )                                              AS main_supplier_sid 
    , IFNULL( pv.shop_cat_sid, '-1' )                                                   AS shop_cat_sid 
    , pv.shop_cat_name                                                                  AS shop_cat_name 
    , IFNULL( pv.shop_cat_lvl4_sid, '-1' )                                              AS shop_cat_lvl4_sid 
    , pv.shop_cat_lvl4_name                                                             AS shop_cat_lvl4_name 
    , IFNULL( pv.shop_cat_lvl3_sid, '-1' )                                              AS shop_cat_lvl3_sid 
    , pv.shop_cat_lvl3_name                                                             AS shop_cat_lvl3_name 
    , IFNULL( pv.shop_cat_lvl2_sid, '-1' )                                              AS shop_cat_lvl2_sid 
    , pv.shop_cat_lvl2_name                                                             AS shop_cat_lvl2_name 
    , IFNULL( pv.shop_cat_lvl1_sid, '-1' )                                              AS shop_cat_lvl1_sid 
    , pv.shop_cat_lvl1_name                                                             AS shop_cat_lvl1_name 
    , pv.prod_variant_src_insert_dt                                                     AS prod_variant_src_insert_dt 
    , pv.prod_variant_src_update_dt                                                     AS prod_variant_src_update_dt 
    , NULL                                                                              AS first_inbound_dt 
	, IFNULL( NULLIF( pv.prod_brick_cd, '' ), '-1' )                                    AS prod_brick_cd 
    , IFF( LEFT( pv.prod_variant_nr ::STRING, 1 ) = '1', TRUE, FALSE )                  AS commodity_fg 
    , pv.is_bundle_header_fg                                                            AS is_bundle_header_fg 
    , pv.prod_variant_import_nr                                                         AS prod_variant_import_nr 
    , IFF(     pv.shop_cat_lvl1_name = 'Spirituosen' 
            OR ( pv.shop_cat_lvl1_name = 'Weinwelt' AND pv.shop_cat_lvl2_name != 'Rund um den Wein' )
            , 'Wein'
			    , pv.prod_size_type_cd
    )                                                                                   AS einlager_kz
	, IFNULL( NULLIF( pr.prod_org_lvl_name, '' ), '-1' ) 								AS prod_org_lvl_name
    , CASE WHEN PROD_VARIANT_PACKING_TYPE_CD = '' THEN '-1' ELSE IFNULL(PROD_VARIANT_PACKING_TYPE_CD, '-1') END AS PROD_VARIANT_PACKING_TYPE_CD
FROM
    lec_share.v_dim_product_variant_1         AS pv
LEFT JOIN
	lec_share.v_dim_product_1 		           AS pr 	      ON pv.prod_sid = pr.prod_sid
										              AND pr.dwh_valid_fg = TRUE
LEFT JOIN
    lec_share.v_dim_unit_of_measurement_1     AS uom_volume  ON uom_volume.uom_sid = pv.volume_uom_sid
LEFT JOIN
    lec_share.v_dim_unit_of_measurement_1     AS uom_weight  ON uom_weight.uom_sid = pv.weight_uom_sid
LEFT JOIN
    lec_share.v_dim_unit_of_measurement_1     AS uom_girth   ON uom_girth.uom_sid = pv.girth_uom_sid
LEFT JOIN
    lec_share.v_dim_unit_of_measurement_1     AS uom_length  ON uom_length.uom_sid = pv.length_uom_sid
LEFT JOIN
    lec_share.v_dim_unit_of_measurement_1     AS uom_width   ON uom_width.uom_sid = pv.width_uom_sid
LEFT JOIN
    lec_share.v_dim_unit_of_measurement_1     AS uom_height  ON uom_height.uom_sid = pv.height_uom_sid
WHERE
    pv.dwh_valid_fg = TRUE
UNION ALL 
    SELECT 
        '-1'                          -- prod_variant_sid 
        , ''                          -- prod_variant_nr 
        , ''                          -- prod_variant_name 
        , ''                          -- prod_variant_descr 
        , '-1'                        -- prod_sid 
        , ''                          -- prod_nr 
        , ''                          -- prod_name 
        , ''                          -- ian_nr 
        , 'n/a'                       -- ian_nr_artikelabverkauf 
        , ''                          -- main_ean_nr 
        , ''                          -- prod_variant_hist_nr 
        , ''                          -- prod_variant_ian_nr 
        , ''                          -- combined_prod_variant_ian_nr 
        , '0'                         -- volume_meas 
        , ''                          -- volume_uom_cd 
        , ''                          -- volume_str 
        , '0'                         -- volume_meas_standard 
        , ''                          -- volume_meas_standard_uom_cd 
        , '0'                         -- weight_meas 
        , '0'                         -- gross_weight_meas 
        , '0'                         -- net_weight_meas 
        , ''                          -- weight_uom_cd 
        , ''                          -- weight_str 
        , '0'                         -- weight_meas_standard 
        , ''                          -- gross_weight_str 
        , '0'                         -- gross_weight_meas_standard 
        , ''                          -- net_weight_str 
        , '0'                         -- net_weight_meas_standard 
        , ''                          -- weight_meas_standard_uom_cd 
        , '0'                         -- girth_east_meas 
        , '0'                         -- girth_west_meas 
        , ''                          -- girth_uom_cd 
        , ''                          -- girth_east_str 
        , '0'                         -- girth_east_meas_standard 
        , ''                          -- girth_west_str 
        , '0'                         -- girth_west_meas_standard 
        , ''                          -- girth_meas_standard_uom_cd 
        , '0'                         -- length_meas 
        , ''                          -- length_uom_cd 
        , ''                          -- length_str 
        , '0'                         -- length_meas_standard 
        , ''                          -- length_meas_standard_uom_cd 
        , '0'                         -- mean_length_meas 
        , ''                          -- mean_length_str 
        , '0'                         -- mean_length_meas_standard 
        , '0'                         -- shortest_length_meas 
        , ''                          -- shortest_length_str 
        , '0'                         -- shortest_length_meas_standard 
        , '0'                         -- longest_length_meas 
        , ''                          -- longest_length_str 
        , '0'                         -- longest_length_meas_standard 
        , '0'                         -- width_meas 
        , ''                          -- width_uom_cd 
        , ''                          -- width_str 
        , '0'                         -- width_meas_standard 
        , ''                          -- width_meas_standard_uom_cd 
        , '0'                         -- height_meas 
        , ''                          -- height_uom_cd 
        , ''                          -- height_str 
        , '0'                         -- height_meas_standard 
        , ''                          -- height_meas_standard_uom_cd 
        , '-1'                        -- prod_size_type_cd 
        , FALSE                       -- is_bulky_item_fg 
        , '-1'                        -- prod_orig_country_cd 
        , '-1'                        -- brand_sid 
        , '-1'                        -- brand_class_cd 
        , '-1'                        -- prod_assortment_class_cd 
        , '-1'                        -- prod_global_status_cd 
        , '-1'                        -- prod_food_class_cd 
        , '0'                         -- palette_capacity_cnt 
        , '0'                         -- package_capacity_cnt 
        , '0'                         -- container_capacity_cnt 
        , '-1'                        -- main_supplier_sid 
        , '-1'                        -- shop_cat_sid 
        , ''                          -- shop_cat_name 
        , '-1'                        -- shop_cat_lvl4_sid 
        , ''                          -- shop_cat_lvl4_name 
        , '-1'                        -- shop_cat_lvl3_sid 
        , ''                          -- shop_cat_lvl3_name 
        , '-1'                        -- shop_cat_lvl2_sid 
        , ''                          -- shop_cat_lvl2_name 
        , '-1'                        -- shop_cat_lvl1_sid 
        , ''                          -- shop_cat_lvl1_name 
        , TO_DATE( '1900-01-01' )     -- prod_variant_src_insert_dt 
        , TO_DATE( '1900-01-01' )     -- prod_variant_src_update_dt
        , TO_DATE( '1900-01-01' )     -- first_inbound_dt
        , '-1'                        -- prod_brick_cd 
        , FALSE                       -- commodity_fg
        , FALSE                       -- is_bundle_header_fg
        , ''                          -- prod_variant_import_nr 
        , '-1'                        -- einlager_kz 
		, '-1' 						  -- prod_org_lvl_name
        , '-1'                        -- PROD_VARIANT_PACKING_TYPE_CD
    ;