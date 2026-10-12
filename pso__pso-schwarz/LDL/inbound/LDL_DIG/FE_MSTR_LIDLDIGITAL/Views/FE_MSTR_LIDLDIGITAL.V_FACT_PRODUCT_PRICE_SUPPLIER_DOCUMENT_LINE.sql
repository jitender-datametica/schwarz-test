CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_PRODUCT_PRICE_SUPPLIER_DOCUMENT_LINE(
	SUPPLIER_SID
	,PROD_VARIANT_SID
	,BOOKING_DT
    ,MATERIAL_DOC_RECEIPT_TYPE_CD
	,CURR_CD
	,MATERIAL_DOC_MOV_TYPE_CD
	,PROD_QTY
    ,PROD_NET_LOCAL_VAL
    ,EKP_PRICE_VAL
)
AS
SELECT
 IFNULL(fsol.supplier_sid,-1)       	   AS supplier_sid
,IFNULL(fmdl.prod_variant_sid,-1)          AS prod_variant_sid
,IFNULL(fmdl.booking_dt,'1900-01-01')      AS booking_dt
,ANY_VALUE(fmdl.material_doc_receipt_type_cd)  AS material_doc_receipt_type_cd
,ANY_VALUE(fmdl.curr_cd)                   AS curr_cd
,CASE 
    WHEN fmdl.material_doc_mov_type_cd = '' 
    THEN '-1' 
    ELSE IFNULL(fmdl.material_doc_mov_type_cd, '-1') 
    END                                    AS material_doc_mov_type_cd
,SUM(fmdl.prod_qty * iff(fmdl.material_doc_debit_credit_cd = 'H', -1, 1)) AS prod_qty /* multiplication with -1/1 required for lagerbewegungen report in order to reflect returns to supplier as minus qty / val */ 
,SUM(fmdl.prod_net_local_val * iff(fmdl.material_doc_debit_credit_cd = 'H', -1, 1)) AS prod_net_local_val /* multiplication with -1/1 required for lagerbewegungen report in order to reflect returns to supplier as minus qty / val */ 
,DIV0 (
    SUM(fmdl.prod_net_local_val),SUM(fmdl.prod_qty)
    )                                      AS ekp_price_val
    
FROM
    lec_share.v_fact_material_document_line fmdl

INNER JOIN lec_share.v_fact_supplier_order_line fsol
    ON  fsol.supplier_order_nr = fmdl.supplier_order_nr
    AND fsol.supplier_order_pos_nr = fmdl.supplier_order_pos_nr

WHERE 
fsol.dwh_valid_fg

GROUP BY
 fsol.supplier_sid
,fmdl.prod_variant_sid
,fmdl.booking_dt
,fmdl.material_doc_mov_type_cd
;