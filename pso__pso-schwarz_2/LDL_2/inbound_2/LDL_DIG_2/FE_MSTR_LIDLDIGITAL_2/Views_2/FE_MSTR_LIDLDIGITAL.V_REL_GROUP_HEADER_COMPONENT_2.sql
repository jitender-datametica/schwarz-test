CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_REL_GROUP_HEADER_COMPONENT_2
(
    group_id
    , group_header_prod_sid
    , group_header_prod_nr 
    , prod_variant_sid  
    , prod_variant_nr
	, group_component_qty
) 
AS
WITH
    group_head AS (
        SELECT
            CONCAT_WS( '_', cust_order_sid, cust_order_pos_nr )         AS group_order_pos
            , prod_sid                                                  AS group_header_prod_sid
			, prod_qty													AS group_header_qty
        FROM 
            lec_share.v_fact_customer_order_line_2
        WHERE
            is_bundle_header_fg = 1
    )
    
    , group_comp AS (
        SELECT
            CONCAT_WS( '_', cust_order_sid, bundle_header_pos_nr )      AS group_order_pos
            , prod_variant_sid                                          AS prod_variant_sid
			, prod_qty													AS group_component_qty
        FROM
            lec_share.v_fact_customer_order_line_2
        WHERE
            bundle_header_pos_nr != 0
    )

SELECT
    srg_prod.prod_nr                                                    AS group_id
    , gh.group_header_prod_sid                                          AS group_header_prod_sid  
    , srg_prod.prod_nr                                                  AS group_header_prod_nr   
    , gc.prod_variant_sid                                               AS prod_variant_sid  
    , srg_var.prod_variant_nr                                           AS prod_variant_nr
	, ROUND( AVG( DIV0( group_component_qty, group_header_qty ) ), 0 )	AS group_component_qty
FROM
    group_head                      AS gh

LEFT JOIN
    group_comp                      AS gc           ON gh.group_order_pos = gc.group_order_pos

LEFT JOIN
    lec_share.v_meta_srg_prod_sid_2             AS srg_prod     ON gh.group_header_prod_sid = srg_prod.prod_sid

LEFT JOIN
    lec_share.v_meta_srg_prod_variant_sid_2     AS srg_var      ON gc.prod_variant_sid = srg_var.prod_variant_sid

GROUP BY
	group_id
	, group_header_prod_sid
    , group_header_prod_nr 
    , gc.prod_variant_sid  
    , srg_var.prod_variant_nr
;