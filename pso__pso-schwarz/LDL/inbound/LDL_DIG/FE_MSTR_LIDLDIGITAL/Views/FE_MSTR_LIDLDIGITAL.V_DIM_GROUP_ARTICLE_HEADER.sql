CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_GROUP_ARTICLE_HEADER
(
    group_header_prod_sid
    , group_header_prod_nr
    , group_header_name
    , group_header_descr
    , gh_ian_nr
    , gh_brick_cd
    , gh_brand_class_cd
    , gh_brand_sid
    , gh_promo_class_cd
    , gh_purch_org_type_cd    
    , gh_main_supplier_sid
    , gh_prod_org_lvl_name
)
AS
WITH
    group_header_list AS (
        SELECT DISTINCT
            rel.group_header_prod_nr        AS group_header_prod_nr
            , rel.group_header_prod_sid     AS group_header_prod_sid
            , var.prod_variant_sid          AS group_header_var_sid
        FROM 
            fe_mstr_lidldigital.v_rel_group_header_component    AS rel
        LEFT JOIN
            lec_share.v_meta_srg_prod_variant_sid                         AS var      ON rel.group_header_prod_nr = var.prod_variant_nr
    )

SELECT
    gh.group_header_prod_sid                                        AS group_header_prod_sid
    , gh.group_header_prod_nr                                       AS group_header_prod_nr
    , prd.prod_name                                                 AS group_header_name
    , prd.prod_descr                                                AS group_header_descr
    , IFNULL( prd.ian_nr, ' ' )                                     AS gh_ian_nr
    , IFNULL( NULLIF( prd.prod_brick_cd, '' ), '-1' )               AS gh_brick_cd
    , IFNULL( NULLIF( prd.brand_class_cd, '' ), '-1' )              AS gh_brand_class_cd
    , IFNULL( prd.brand_sid, '-1' )                                 AS gh_brand_sid
    , IFNULL( NULLIF( prd.prod_promo_class_cd, '' ), '-1' )         AS gh_promo_class_cd
    , IFNULL( NULLIF( prd.prod_purch_org_type_cd, '' ), '-1' )      AS gh_purch_org_type_cd    
    , IFNULL( var.main_supplier_sid, '-1' )                         AS gh_main_supplier_sid
    , IFNULL( NULLIF( prd.prod_org_lvl_name, '' ), '-1' )           AS gh_prod_org_lvl_name
FROM
    group_header_list               AS gh

LEFT JOIN
    lec_share.v_dim_product              AS prd 		ON gh.group_header_prod_sid = prd.prod_sid
										        AND prd.dwh_valid_fg = 1
LEFT JOIN
    lec_share.v_dim_product_variant      AS var      ON gh.group_header_var_sid = var.prod_variant_sid
                                                AND var.dwh_valid_fg = 1

UNION ALL
SELECT
    '-1'        AS group_header_prod_sid
    , ''        AS group_header_prod_nr
    , ''        AS group_header_name
    , ''        AS group_header_descr
    , ''        AS gh_ian_nr
    , '-1'      AS gh_brick_cd
    , '-1'      AS gh_brand_class_cd
    , '-1'      AS gh_brand_sid
    , '-1'      AS gh_promo_class_cd
    , '-1'      AS gh_purch_org_type_cd    
    , '-1'      AS gh_main_supplier_sid   
    , '-1'      AS gh_prod_org_lvl_name     

;