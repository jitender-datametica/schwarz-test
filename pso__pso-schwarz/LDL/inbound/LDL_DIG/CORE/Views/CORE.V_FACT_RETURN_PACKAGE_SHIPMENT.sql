CREATE OR REPLACE VIEW CORE.V_FACT_RETURN_PACKAGE_SHIPMENT(
	WSHOP_CD COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country',
	BUS_YEAR COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
	MONTH_OF_BUS_YEAR COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12',
	CUST_ORDER_RETURN_DT COMMENT 'The date when return was made',
	CUST_ORDER_SID COMMENT 'The unique identifier (surrogate key) for customer order',
	CUST_ORDER_POS_NR COMMENT 'The particular position number of an item in an order',
    FORWARD_DROPSHIPMENT_ORDER_FG COMMENT 'True if the forward order is a dropshipment order',
	CUST_ORDER_RETURN_SID COMMENT 'The unique identifier (surrogate key) for return of customer order',
	CUST_ORDER_RETURN_POS_NR COMMENT 'A number of an particular position ( product ) in an return order',
    RETURN_DROPSHIPMENT_ORDER_FG COMMENT 'True if the package is returned to the supplier (dropshipment) - FALSE if it comes back to one of our warehouses',
    RETURN_WH_SID COMMENT 'The unique identifier (surrogate key) for the warehouse handling the return.',
    HAULER_NAME COMMENT 'The name by which the transport carrier is known',
	PROD_VARIANT_SID COMMENT 'Unique identifier (surrogate key) of the ordered/returned product',
	PROD_VARIANT_NR COMMENT 'The product variant number',
	BUNDLE_HEADER_PROD_VARIANT_SID COMMENT 'Unique Identifier for the product variant of the bundle header to which this bundle item belongs',
	PACK_SIZE_HANDLE_GROUP_CD COMMENT 'A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - 1 person , 2 persons etc',
	RETURN_PACK_SID COMMENT 'The unique identifier(surrogate key) for the package of the return',
    RETURN_PACK_TRACKING_URL,
	RETURN_SHIP_COST_NET_EUR_VAL COMMENT 'the shipping costs for lidl digital for each article included in a package (only return process)'
) AS
WITH ranked_returns AS (
    SELECT
        wshop_cd,
        cust_order_sid,
        cust_order_pos_nr,
        cust_order_return_dt,
        cust_order_return_sid,
        cust_order_return_pos_nr,
        dropshipment_order_fg,
        return_wh_sid,
        prod_variant_sid,
        prod_variant_nr,
        ROW_NUMBER() OVER (PARTITION BY cust_order_sid, cust_order_pos_nr ORDER BY cust_order_return_dt) AS rn
    FROM
        core.t_fact_customer_return_line
    )
, return_grouped AS (
    SELECT
        wshop_cd,
        cust_order_sid,
        cust_order_pos_nr,
        MIN(cust_order_return_dt) AS cust_order_return_dt,
        MIN(cust_order_return_sid) AS cust_order_return_sid,
        MIN(cust_order_return_pos_nr) AS cust_order_return_pos_nr,
        MAX(dropshipment_order_fg) AS dropshipment_order_fg,
        MAX(return_wh_sid) AS return_wh_sid,
        prod_variant_sid,
        prod_variant_nr
    FROM
        ranked_returns
    WHERE
        rn = 1
    GROUP BY 
        wshop_cd,
        cust_order_sid,
        cust_order_pos_nr,
        prod_variant_sid,
        prod_variant_nr
    )
    SELECT
        crl.wshop_cd
        , cad.bus_year
        , cad.month_of_bus_year
        , crl.cust_order_return_dt                                                        
        , crl.cust_order_sid
        , crl.cust_order_pos_nr
        , col.dropshipment_order_fg     AS forward_dropshipment_order_fg
        , crl.cust_order_return_sid                                                 
		, crl.cust_order_return_pos_nr
        , crl.dropshipment_order_fg     AS return_dropshipment_order_fg
        , crl.return_wh_sid
        , hau.hauler_name
        , crl.prod_variant_sid
        , crl.prod_variant_nr
        , gh.bundle_header_prod_variant_sid                                                       AS bundle_header_prod_variant_sid
        , crps.pack_size_handle_group_cd
        , return_pack_sid                                                                         AS return_pack_sid
        , crps.return_pack_tracking_nr                                                            AS return_pack_tracking_nr
		, SUM( return_ship_cost_net_eur_val )													  AS return_ship_cost_net_eur_val
	FROM
        CORE.t_fact_sales_return_package_shipment crps  
    LEFT JOIN
        CORE.t_fact_customer_order_line AS col
        ON         crps.sale_order_sid = col.cust_order_sid 
            AND    crps.sale_order_pos_nr = col.cust_order_pos_nr
    JOIN          
        return_grouped AS crl
        ON         crl.cust_order_sid  = col.cust_order_sid 
            AND    crl.cust_order_pos_nr = col.cust_order_pos_nr
    LEFT JOIN core.t_dim_cal_day        AS cad 
                    ON       crl.cust_order_return_dt = cad.cal_dt
    LEFT JOIN core.v_fact_order_line_bundle_component     AS gh        
                    ON       gh.cust_order_sid = crl.cust_order_sid
                        AND  gh.cust_order_pos_nr = crl.cust_order_pos_nr
    LEFT JOIN
        core.t_dim_hauler AS hau
        ON hau.dwh_valid_fg
        AND hau.hauler_sid = crps.hauler_sid
    LEFT JOIN
            core.t_rel_product_variant_regional     AS rel      ON       col.prod_variant_sid = rel.prod_variant_sid
                                                                    AND  col.wshop_cd = rel.wshop_cd
                                                                    AND  rel.dwh_valid_fg
    
    WHERE    (crps.is_legacy_fg = 'FALSE' AND 
                                        (   crps.handover_to_carrier_dt IS NOT NULL
                                        OR  crps.return_hub_dt IS NOT NULL
                                        OR  crps.first_intake_scan_hub_dt IS NOT NULL
                                        )
            )
         OR (crps.is_legacy_fg = 'TRUE' AND crps.return_ship_cost_net_eur_val IS NOT NULL)

	GROUP BY
        crl.wshop_cd
        , cad.bus_year
        , cad.month_of_bus_year
        , crl.cust_order_return_dt
        , crl.cust_order_sid
        , crl.cust_order_pos_nr
        , col.dropshipment_order_fg
        , crl.cust_order_return_sid                                                 
		, crl.cust_order_return_pos_nr
        , crl.dropshipment_order_fg
        , crl.return_wh_sid
        , hau.hauler_name
        , crl.prod_variant_sid
        , crl.prod_variant_nr
        , gh.bundle_header_prod_variant_sid
        , crps.pack_size_handle_group_cd
        , return_pack_sid
        , crps.return_pack_tracking_nr
    ;