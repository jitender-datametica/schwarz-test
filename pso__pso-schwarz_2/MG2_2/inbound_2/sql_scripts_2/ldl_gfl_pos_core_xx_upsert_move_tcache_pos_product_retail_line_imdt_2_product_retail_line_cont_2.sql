
CREATE OR REPLACE TEMPORARY TABLE ${TEMP_DB}.VT_$_2{SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_PROCESS
AS SELECT * 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
;

/* PRODUCT_VARIANT_SID Notes:

Mapping specifies that 
- A SID should be assigned from SLS_GTIN where the item_2 number and barcode has been assigned a SID already in the keyspace
        - Otherwise a SLS_UNK SID should be assigned from the country_2 and item_2 number has ben assigned already
                - Otherwise create a SLS_UNK SID and assign that number for the country_2 & Item_2 Number.

The previous process has assigned aN SLS_GTIN SID if one was present, otherwise this process will see -1
So for -1 SIDs perform the keyspace ASSIGN_WHEN_PRESENT-ELSE-INSERT-AND-ASSIGN routine here in the transform itself

*/
BEGIN TRANSACTION;

DELETE FROM meta.t_product_variant_key_2 -- Prevent any concurrent access to this keyspace
WHERE 1=2;

-- Create new SK entries for every new NK/TYPE/VALID_FROM_TMSP Combination

INSERT INTO meta.t_product_variant_key_2 
(
        prod_variant_sid,
        prod_variant_key_type_cd,
        prod_variant_nat_key_nr,
        dwh_created_tmsp,
        dwh_updated_tmsp,
        dwh_valid_from_tmsp,
        dwh_valid_to_tmsp,
        dwh_valid_fg,
        dwh_node_cd,
        dwh_load_id
)
(
SELECT  
        max_seq + row_number() over(order by 1) AS prod_variant_sid,
        'SLS_UNK',
        UPPER(t1.context_country || '|' || t1.orig_item_nr) as natural_key,
        current_timestamp,
        current_timestamp,
        current_timestamp,
        '9999-12-31 23:59:59'
        ,TRUE
        ,t1.dwh_node_cd
        ,'${LOAD_ID}'       
FROM (SELECT t1.dwh_node_cd, context_country, orig_item_nr
        FROM (SELECT 'EJR' AS dwh_node_cd, UPPER(context_country) AS context_country, orig_item_nr 
              FROM ${TEMP_DB}.VT_$_2{SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_PROCESS t1_2
              WHERE t1.PROD_VARIANT_SIDX = '-1') t1_2 -- We only want to create SIDs where not previously assigned (-1) and not present              
        GROUP BY t1.dwh_node_cd, context_country, orig_item_nr) t1_2
        
CROSS JOIN (SELECT COALESCE(MAX(prod_variant_sid),0) AS max_seq FROM meta.t_product_variant_key_2) AS max_seq

WHERE 
natural_key IS NOT NULL 
AND 
NOT EXISTS
        (
         SELECT 1 FROM meta.t_product_variant_key_2 t2 
         WHERE
         UPPER(t2.prod_variant_key_type_cd) = 'SLS_UNK' AND
         current_timestamp between t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND -- Accomodates historized SID association (full capability not implemented in initial release)
         UPPER(t2.prod_variant_nat_key_nr) = UPPER(t1.context_country|| '|' || t1.orig_item_nr) 
        )     
) ;

COMMIT;


INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        RETAIL_EVENT_SID,
        RETAIL_EVENT_LINE_SEQ,
        EVENT_START_TMSP,
        EVENT_END_TMSP,
        BUS_DT,
        RETAIL_EVENT_END_TMSP,
        STORE_SID,
        COUNTRY_ORG_SID,
        COUNTRY_ORG_CD,
        REAL_ESTATE_SID,
        CASH_REGISTER_SID,
        CASH_REGISTER_TYPE_CD,
        CASH_REGISTER_USG_TYPE_CD,
        CASHIER_NR,
        AUTH_BY_NR,
        CUST_SID,
        PROD_RETAIL_LINE_TYPE_CD,
        RETAIL_EVENT_LINE_SCENARIO_ID,
        PROD_VARIANT_SID,
  	LOCAL_PROD_NR,
        PROD_VARIANT_INPUT_NR,
        PROD_VARIANT_INPUT_NR_TYPE_CD,
        DISPLAYED_PROD_VARIANT_NAME,
        WEIGHT_BASED_FG,
        PROD_VARIANT_CNT,
        PROD_VARIANT_QTY,
        UOM_CD,
        UNIT_PRICE,
        BASE_GROSS_VAL,
        RETAIL_LINE_GROSS_VAL,
        RETAIL_LINE_NET_VAL,
        RETAIL_LINE_VAT_VAL,
        TAX_CLASS_CD,
        GEO_AREA_SID,
        TAX_PCT,
        CURR_CD,
        TURNOVER_RELEVANT_FG,
        DISCOUNT_FG,
        PROD_ENTRY_METHOD_CD,
        PRICE_ENTRY_METHOD_CD,
        PROD_RETURN_REASON_SID,
        RETURN_TXT,
        ORIG_SALES_EVENT_SID,
        PARENT_LINE_SEQ,
        CANCEL_LINE_SEQ,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID

)
SELECT
        SRC.RETAIL_EVENT_SID,
        SRC.RETAIL_EVENT_LINE_SEQ,
        SRC.EVENT_START_TMSP,
        SRC.EVENT_END_TMSP,
        SRC.BUS_DT,
        SRC.RETAIL_EVENT_END_TMSP,
        SRC.STORE_SID,
        SRC.COUNTRY_ORG_SID,
        ORG.COUNTRY_ORG_CD,
        REAL_ESTATE_SID,
        SRC.CASH_REGISTER_SID,
        SRC.CASH_REGISTER_TYPE_CD,
        SRC.CASH_REGISTER_USG_TYPE_CD,
        IFF(bus_dt < DATEADD(week,-(${RETENTION_PERIOD_CASHIER_NR}),CURRENT_DATE),-1,src.checker_id) cashier_nr,
        IFF(bus_dt < DATEADD(week,-(${RETENTION_PERIOD_CASHIER_NR}),CURRENT_DATE),-1,src.receiptline_authority_id) auth_by_nr,
        SRC.CUST_SID,
        SRC.PROD_RETAIL_LINE_TYPE_CD,
        SRC.RETAIL_EVENT_LINE_SCENARIO_ID,
        CASE
                WHEN SRC.PROD_VARIANT_SIDX = '-1'   
                THEN PVK1.PROD_VARIANT_SID -- See start of script ^^
                ELSE SRC.PROD_VARIANT_SIDX --SIDX would be populated where already present in SLS_GTIN Domain.
        END AS PROD_VARIANT_SID, 
  	SRC.LOCAL_PROD_NR,
        SRC.PROD_VARIANT_INPUT_NR,
        SRC.PROD_VARIANT_INPUT_NR_TYPE_CD,
        SRC.DISPLAYED_PROD_VARIANT_NAME,
        SRC.WEIGHT_BASED_FG,
        SRC.PROD_VARIANT_CNT,
        SRC.PROD_VARIANT_QTY,
        SRC.UOM_CD,
        SRC.UNIT_PRICE,
        SRC.BASE_GROSS_VAL,
        SRC.RETAIL_LINE_GROSS_VAL,
        SRC.RETAIL_LINE_NET_VAL,
        SRC.RETAIL_LINE_VAT_VAL,
        SRC.TAX_CLASS_CD,
        SRC.GEO_AREA_SID,
        SRC.TAX_PCT,
        ORG.CURR_CD,
        SRC.TURNOVER_RELEVANT_FG,
        CASE WHEN SRC.BASE_GROSS_VAL > SRC.RETAIL_LINE_GROSS_VAL
        THEN TRUE
        ELSE FALSE
        END AS DISCOUNT_FG,
        SRC.PROD_ENTRY_METHOD_CD,
        SRC.PRICE_ENTRY_METHOD_CD,
        SRC.PROD_RETURN_REASON_SID,
        SRC.RETURN_TXT,
        SRC.ORIG_SALES_EVENT_SID,
        SRC.PARENT_LINE_SEQ,
        SRC.CANCEL_LINE_SEQ,
        'EJR' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        current_timestamp AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'EJR' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.VT_$_2{SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_PROCESS SRC
LEFT OUTER JOIN META.T_PRODUCT_VARIANT_KEY_2 AS PVK1 -- NKC is ON, but we dont want to generate missing keys, so we access the keyspace directly here instead os fwork-based key assignment
        ON  PVK1.PROD_VARIANT_KEY_TYPE_CD = 'SLS_UNK'
        AND UPPER(SRC.CONTEXT_COUNTRY || '|' || SRC.ORIG_ITEM_NR) = UPPER(PVK1.PROD_VARIANT_NAT_KEY_NR)
        AND PVK1.DWH_VALID_FG = TRUE
LEFT OUTER JOIN ${TARGET_DB}.T_INTERNAL_ORGANIZATION_2 ORG
ON  SRC.COUNTRY_ORG_SID = ORG.INT_ORG_SID
AND SRC.BUS_DT BETWEEN ORG.DWH_VALID_FROM_TMSP AND ORG.DWH_VALID_TO_TMSP;   

-- Delete those records from source using the PK
DELETE FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
WHERE EXISTS (SELECT 1 FROM ${TEMP_DB}.VT_$_2{SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_PROCESS PROCESS
              WHERE 
                SRC.RETAIL_EVENT_SID=PROCESS.RETAIL_EVENT_SID AND 
                SRC.RETAIL_EVENT_LINE_SEQ=PROCESS.RETAIL_EVENT_LINE_SEQ);
