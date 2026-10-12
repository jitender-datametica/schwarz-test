CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_PRODUCT_VARIANT_DISPOSAL_1
(  
     wshop_cd
     ,prod_variant_sid
     ,material_doc_mov_process_type_name
     ,material_doc_mov_process_subtype_name
     ,booking_dt
     ,prod_variant_nr
     ,prod_sid
     ,prod_nr
     ,prod_loss_net_local_val
     ,prod_revenue_net_local_val
     ,prod_net_local_val
     ,curr_cd
     ,prod_qty
) AS 
SELECT
      wshop_cd
     ,prod_variant_sid
     ,material_doc_mov_process_type_name
     ,material_doc_mov_process_subtype_name
     ,booking_dt
     ,IFNULL(prod_variant_nr,'-1')              AS prod_variant_nr
     ,IFNULL(prod_sid, '-1')                    AS prod_sid
     ,IFNULL(prod_nr, '-1')                     AS prod_nr
     ,ZEROIFNULL(prod_loss_net_local_val)       AS prod_loss_net_local_val
     ,ZEROIFNULL(prod_revenue_net_local_val)    AS prod_revenue_net_local_val
     ,ZEROIFNULL(prod_net_local_val)            AS prod_net_local_val
     ,IFNULL(curr_cd, '-1')                     AS curr_cd
     ,ZEROIFNULL(prod_qty)                      AS prod_qty
FROM
    lec_share.v_agg_product_variant_disposal_1
    ;