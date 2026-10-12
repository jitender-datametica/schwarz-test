DELETE FROM ${TARGET_DB}.${TGT_TARGET_TABLE};

-- Multi-Stage transform required for prod_variant_sid assignment, but also helps for discount_fg

CREATE OR REPLACE TABLE ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_SET_A
AS
SELECT
        src.retail_event_sid as retail_event_sid,
        SRC.POSNR AS RETAIL_EVENT_LINE_SEQ,
        SRC.RECEIPTLINE_TIMESTAMP_BEGIN AS EVENT_START_TMSP,
        SRC.RECEIPTLINE_TIMESTAMP_END AS EVENT_END_TMSP,
        SRC.RECEIPT_BUSINESS_DATE AS BUS_DT,
        SRC.RECEIPT_TIMESTAMP_END AS RETAIL_EVENT_END_TMSP,
        SRC.STORE_SID AS STORE_SID,
        SRC.COUNTRY_ORG_SID AS COUNTRY_ORG_SID,
        SRC.COUNTRY_ORG_CD AS COUNTRY_ORG_CD,
        SRC.REAL_ESTATE_SID AS REAL_ESTATE_SID,
        SRC.CASH_REGISTER_SID AS CASH_REGISTER_SID,
        SRC.POS_TYPE AS CASH_REGISTER_TYPE_CD,
        NULL AS CASH_REGISTER_USG_TYPE_CD,
        checker_hash AS cashier_hash,
        receiptline_authority_hash AS auth_by_hash,
        SRC.CUST_SID AS CUST_SID,
        CASE WHEN PARENT_LINE_NR IS NULL
            THEN CASE WHEN Substring(RECEIPTLINE_TRANSACTIONTYPE_ID, 2, 1) = '2'
                           THEN 'D'  /* Deposit Return Line */
                      WHEN Substring(RECEIPT_TRANSACTIONTYPE_ID, 2, 1) = '0'
                           THEN 'S'  /* Product Sales Line */
                           ELSE 'R'  /* Product Return Line */
                 END
            ELSE CASE WHEN Substring(RECEIPT_TRANSACTIONTYPE_ID, 2, 1) = '0'
                           THEN 'SD' /* Related Deposit Sales Line */
                           ELSE 'RD' /* Related Deposit Return Line */
                 END
        END PROD_RETAIL_LINE_TYPE_CD,
        ORIG_ITEM_NR AS LOCAL_PROD_NR,
        SRC.RECEIPTLINE_TRANSACTIONTYPE_ID AS RETAIL_EVENT_LINE_SCENARIO_ID,
        --COALESCE(PVK1.PROD_VARIANT_SID, '-1') as PROD_VARIANT_SID,
        CASE WHEN PV1.PROD_SID = PV2.PROD_SID
            THEN PVK1.PROD_VARIANT_SID
            ELSE '-1'
        END AS PROD_VARIANT_SID,
        SRC.BARCODE AS PROD_VARIANT_INPUT_NR,
        NULL AS PROD_VARIANT_INPUT_NR_TYPE_CD,
        COALESCE(SRC.ITEM_DESC,' ') AS DISPLAYED_PROD_VARIANT_NAME, -- STAGER CURRENTLY NOT POPULATING ITEM_DESC FOR DEPOSITS (DEFECT)
        CASE WHEN SRC.FG_WEIGHT = '1'
        THEN TRUE
        ELSE FALSE
        END AS WEIGHT_BASED_FG,
        CASE WHEN SRC.FG_WEIGHT <> '1'
        THEN SRC.QTY_SOLD
        ELSE NULL
        END PROD_VARIANT_CNT,
        CASE WHEN SRC.FG_WEIGHT = '1'
        THEN SRC.QTY_SOLD
        ELSE NULL
        END PROD_VARIANT_QTY,
        CASE WHEN SRC.FG_WEIGHT = '1'
        THEN CASE WHEN SRC.country_org_cd = 'US'
             THEN 'LB'
             ELSE 'KG'
             END
        ELSE NULL
        END UOM_CD,
        Coalesce(SRC.PRICE_RETAIL
                , Abs(SRC.PRICE_SUM_RETAIL / NullifZero(SRC.QTY_SOLD))
                , Abs(SRC.PRICE_SUM_RETAIL)
                ) AS UNIT_PRICE,
        Coalesce(SRC.VAL_RETAIL_ORIG, 0) AS BASE_GROSS_VAL,
        Round(SRC.PRICE_SUM_RETAIL + (SRC.QTY_SOLD * (-1) *
        (CASE WHEN SRC.VAL_DISCOUNT <> 0 AND SRC.country_org_cd = 'GB'
              THEN 0
              ELSE COALESCE(Round(SRC.VAL_DISCOUNT,2),0)
              END)), 2) AS RETAIL_LINE_GROSS_VAL,
        Round(SRC.PRICE_SUM_RETAIL + (SRC.QTY_SOLD * (-1) *
        (CASE WHEN SRC.VAL_DISCOUNT <> 0 AND SRC.country_org_cd = 'GB'
              THEN 0
              ELSE COALESCE(Round(SRC.VAL_DISCOUNT,2),0)
              END)), 2) * 100
          / Coalesce(NullIfZero(SRC.PCT_VAT)+100,100) AS RETAIL_LINE_NET_VAL,
        SRC.VAL_VAT AS RETAIL_LINE_VAT_VAL,
        CASE WHEN TRY_CAST(TYPE_VAT AS NUMBER) BETWEEN 1 AND 9
                THEN CHR(64 + TYPE_VAT)
                ELSE '@'
        END AS TAX_CLASS_CD, 
        /* 1->'A', 2->'B', …, 9->'I' 
        other values -> '@' */
        'CTRY' AS GEO_AREA_KEY_TYPE_CD,
        SRC.PCT_VAT AS TAX_PCT,
        SRC.CURR_CD AS CURR_CD,
        CASE WHEN SRC.RECEIPT_TRANSACTIONTYPE_ID IN ('100', '150')
                       AND SRC.VOIDED_BY_LINE_NR IS NULL
        THEN TRUE        /* Turnover */
        ELSE FALSE       /* Non-Turnover */ 
        END TURNOVER_RELEVANT_FG,
                SRC.ITEM_ENTRY_METHOD_CD AS PROD_ENTRY_METHOD_CD,
        SRC.PRICE_ENTRY_METHOD_CD AS PRICE_ENTRY_METHOD_CD,
        'R' AS PROD_RETURN_REASON_KEY_TYPE_CD,
        SRC.RETURN_TEXT AS RETURN_TXT,
        ((((CAST(TO_CHAR(SRC.ORIGINAL_DAT_FORMDATE, 'YYYYMMDD') AS NUMBER) * 100
        + ASCII(SUBSTRING(SRC.CONTEXT_COUNTRY, 1, 1))) * 100
        + ASCII(SUBSTRING(SRC.CONTEXT_COUNTRY, 2, 1))) * 100000000
        + CASE WHEN TRY_CAST(SRC.ORIGINAL_ORIG_STORE_NR AS NUMBER) <= 99999999 THEN SRC.ORIGINAL_ORIG_STORE_NR::NUMBER ELSE 0 END) * 10000
        + CASE WHEN TRY_CAST(SRC.ORIGINAL_POS_TERMINAL_ID AS NUMBER) <= 9999 THEN SRC.ORIGINAL_POS_TERMINAL_ID::NUMBER ELSE 0 END) * 10000000000
        + CASE WHEN TRY_CAST(SRC.ORIGINAL_ORIG_RECEIPT_NR AS NUMBER) <= 9999999999 THEN SRC.ORIGINAL_ORIG_RECEIPT_NR::NUMBER ELSE 0 END
        AS ORIG_SALES_EVENT_SID,
        TRY_CAST(SRC.ORIGINAL_ORIG_RECEIPT_NR AS NUMBER) AS ORIG_SALES_EVENT_NR,
        SRC.PARENT_LINE_NR AS PARENT_LINE_SEQ,
        SRC.VOIDED_BY_LINE_NR AS CANCEL_LINE_SEQ,
        SRC.CONTEXT_COUNTRY AS CONTEXT_COUNTRY,
        SRC.LIDLPLUS_CUSTOMER_CD AS LIDLPLUS_CUSTOMER_CD,
        SRC.ORIG_RECEIPT_NR AS ORIG_RECEIPT_NR,
        SRC.ORIG_STORE_NR AS ORIG_STORE_NR,
        SRC.ORIGINAL_DAT_FORMDATE AS ORIGINAL_DAT_FORMDATE,
        SRC.ORIGINAL_ORIG_STORE_NR AS ORIGINAL_ORIG_STORE_NR,
        SRC.ORIGINAL_ORIG_RECEIPT_NR AS ORIGINAL_ORIG_RECEIPT_NR,
        SRC.ORIGINAL_POS_TERMINAL_ID AS ORIGINAL_POS_TERMINAL_ID,
        SRC.RECEIPT_BUSINESS_DATE AS RECEIPT_BUSINESS_DATE,
        SRC.RETURN_REASON_CD AS RETURN_REASON_CD,
        SRC.POS_TERMINAL_ID AS POS_TERMINAL_ID,
        SRC.ORIG_ITEM_NR,
        'EJR' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        current_timestamp AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'EJR' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM ETL.t_${SRC_INPUT_TABLE} SRC
LEFT OUTER JOIN META.T_PRODUCT_VARIANT_KEY AS PVK1 -- NKC is ON, but we dont want to generate missing keys, so we access the keyspace directly here instead os fwork-based key assignment
    ON  PVK1.PROD_VARIANT_KEY_TYPE_CD = 'SLS_GTIN'
    AND UPPER(CAST(TRY_CAST(SRC.ORIG_ITEM_NR AS NUMBER) AS STRING) || '|' || SRC.BARCODE) = UPPER(PVK1.PROD_VARIANT_NAT_KEY_NR)
    AND PVK1.DWH_VALID_FG = TRUE
LEFT OUTER JOIN CORE_REL.T_PRODUCT_VARIANT AS PV1
    ON  PVK1.PROD_VARIANT_SID = PV1.PROD_VARIANT_SID
    AND PV1.DWH_VALID_FG = TRUE
LEFT OUTER JOIN META.T_PRODUCT_VARIANT_KEY AS PVK2
    ON  PVK2.PROD_VARIANT_KEY_TYPE_CD = 'SLS_UNK'
    AND UPPER(SRC.country_org_cd || '|' || CAST(TRY_CAST(SRC.ORIG_ITEM_NR AS NUMBER) AS STRING)) = PVK2.PROD_VARIANT_NAT_KEY_NR
    AND PVK2.DWH_VALID_FG = TRUE
LEFT OUTER JOIN CORE_REL.T_PRODUCT_VARIANT AS PV2
    ON PVK2.PROD_VARIANT_SID = PV2.PROD_VARIANT_SID
    AND PV2.DWH_VALID_FG = TRUE
WHERE RECEIPTLINE_TRANSACTIONTYPE_ID in
('101','102','120','121','122','123','141','142','170','172','180','182'
,'201','202','220','221','222','223','270','272','280','282')
QUALIFY Row_Number() OVER (
PARTITION BY
        country_org_cd
      , ORIG_STORE_NR
      , POS_TERMINAL_ID
      , ORIG_RECEIPT_NR
      , RECEIPT_BUSINESS_DATE
      , POSNR
      , RECEIPTLINE_TIMESTAMP_BEGIN
ORDER BY
        RECEIPT_TIMESTAMP_END DESC
) = 1;


/* PRODUCT_VARIANT_SID Notes:

Mapping specifies that 
- A SID should be assigned from SLS_GTIN where the item number and barcode has been assigned a SID already in the keyspace
        - Otherwise a SLS_UNK SID should be assigned from the country and item number has ben assigned already
                - Otherwise create a SLS_UNK SID and assign that number for the country & Item Number.

The previous process has assigned an SLS_GTIN SID if one was present, otherwise this process will see -1
So for -1 SIDs perform the keyspace ASSIGN_WHEN_PRESENT-ELSE-INSERT-AND-ASSIGN routine here in the transform itself

*/

BEGIN TRANSACTION;

DELETE FROM meta.t_product_variant_key -- Prevent any concurrent access to this keyspace
WHERE 1=2;

-- Create new SK entries for every new NK/TYPE/VALID_FROM_TMSP Combination

INSERT INTO meta.t_product_variant_key 
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
        UPPER(t1.country_org_cd || '|' || t1.orig_item_nr) as natural_key,
        current_timestamp,
        current_timestamp,
        current_timestamp,
        '9999-12-31 23:59:59'
        ,TRUE
        ,t1.dwh_node_cd
        ,'${LOAD_ID}'       
FROM (SELECT t1.dwh_node_cd, country_org_cd, orig_item_nr
        FROM (SELECT 'EJR' AS dwh_node_cd, UPPER(country_org_cd) AS country_org_cd, orig_item_nr 
              FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_SET_A t1
              WHERE t1.PROD_VARIANT_SID = '-1') t1 -- We only want to create SIDs where not previously assigned (-1) and not present              
        GROUP BY t1.dwh_node_cd, country_org_cd, orig_item_nr) t1
        
CROSS JOIN (SELECT COALESCE(MAX(prod_variant_sid),0) AS max_seq FROM meta.t_product_variant_key) AS max_seq

WHERE 
natural_key IS NOT NULL 
AND 
NOT EXISTS
        (
         SELECT 1 FROM meta.t_product_variant_key t2 
         WHERE
         UPPER(t2.prod_variant_key_type_cd) = 'SLS_UNK' AND
         current_timestamp between t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND -- Accomodates historized SID association (full capability not implemented in initial release)
         UPPER(t2.prod_variant_nat_key_nr) = UPPER(t1.country_org_cd|| '|' || t1.orig_item_nr) 
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
        CASHIER_HASH,
        AUTH_BY_HASH,
        CUST_SID,
        PROD_RETAIL_LINE_TYPE_CD,
        RETAIL_EVENT_LINE_SCENARIO_ID,
        PROD_VARIANT_SID,
        WAWI_ITEM_SID,
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
        GEO_AREA_KEY_TYPE_CD,
        TAX_PCT,
        CURR_CD,
        TURNOVER_RELEVANT_FG,
        DISCOUNT_FG,
        PROD_ENTRY_METHOD_CD,
        PRICE_ENTRY_METHOD_CD,
        PROD_RETURN_REASON_KEY_TYPE_CD,
        RETURN_TXT,
        ORIG_SALES_EVENT_SID,
        ORIG_SALES_EVENT_NR,
        PARENT_LINE_SEQ,
        CANCEL_LINE_SEQ,
        CONTEXT_COUNTRY,    
        LIDLPLUS_CUSTOMER_CD,
        ORIG_RECEIPT_NR,
        ORIG_STORE_NR,
        ORIGINAL_DAT_FORMDATE,
        ORIGINAL_ORIG_STORE_NR,
        ORIGINAL_ORIG_RECEIPT_NR,
        ORIGINAL_POS_TERMINAL_ID,
        RECEIPT_BUSINESS_DATE,
        RETURN_REASON_CD,
        POS_TERMINAL_ID,
        ORIG_ITEM_NR,    
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
        SRC.COUNTRY_ORG_CD,
        REAL_ESTATE_SID,
        SRC.CASH_REGISTER_SID,
        SRC.CASH_REGISTER_TYPE_CD,
        SRC.CASH_REGISTER_USG_TYPE_CD,
        SRC.CASHIER_HASH,
        SRC.AUTH_BY_HASH,
        SRC.CUST_SID,
        SRC.PROD_RETAIL_LINE_TYPE_CD,
        SRC.RETAIL_EVENT_LINE_SCENARIO_ID,
        CASE
                WHEN SRC.PROD_VARIANT_SID = '-1'   
                THEN PVK1.PROD_VARIANT_SID -- See start of script ^^
                ELSE SRC.PROD_VARIANT_SID --SID would be populated where already present in SLS_GTIN Domain.
        END AS PROD_VARIANT_SID, 
        COALESCE(WIK.WAWI_ITEM_SID, -1) as WAWI_ITEM_SID,  
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
        SRC.GEO_AREA_KEY_TYPE_CD,
        SRC.TAX_PCT,
        SRC.CURR_CD,
        SRC.TURNOVER_RELEVANT_FG,
        CASE WHEN SRC.BASE_GROSS_VAL > SRC.RETAIL_LINE_GROSS_VAL
                THEN TRUE
                ELSE FALSE
        END AS DISCOUNT_FG,
        SRC.PROD_ENTRY_METHOD_CD,
        SRC.PRICE_ENTRY_METHOD_CD,
        SRC.PROD_RETURN_REASON_KEY_TYPE_CD,
        SRC.RETURN_TXT,
        SRC.ORIG_SALES_EVENT_SID,
        SRC.ORIG_SALES_EVENT_NR,
        SRC.PARENT_LINE_SEQ,
        SRC.CANCEL_LINE_SEQ,
        SRC.CONTEXT_COUNTRY,
        SRC.LIDLPLUS_CUSTOMER_CD,
        SRC.ORIG_RECEIPT_NR,
        SRC.ORIG_STORE_NR,
        SRC.ORIGINAL_DAT_FORMDATE,
        SRC.ORIGINAL_ORIG_STORE_NR,
        SRC.ORIGINAL_ORIG_RECEIPT_NR,
        SRC.ORIGINAL_POS_TERMINAL_ID,
        SRC.RECEIPT_BUSINESS_DATE,
        SRC.RETURN_REASON_CD,
        SRC.POS_TERMINAL_ID,
        SRC.ORIG_ITEM_NR,   
        'EJR' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        current_timestamp AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'EJR' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_SET_A SRC
LEFT OUTER JOIN META.T_PRODUCT_VARIANT_KEY AS PVK1 -- NKC is ON, but we dont want to generate missing keys, so we access the keyspace directly here instead os fwork-based key assignment
        ON  PVK1.PROD_VARIANT_KEY_TYPE_CD = 'SLS_UNK'
        AND UPPER(SRC.country_org_cd || '|' || SRC.ORIG_ITEM_NR) = UPPER(PVK1.PROD_VARIANT_NAT_KEY_NR)
        AND PVK1.DWH_VALID_FG = TRUE
LEFT OUTER JOIN META.T_WAWI_ITEM_KEY WIK
      ON  UPPER(CASE WHEN SRC.COUNTRY_ORG_CD ='CS' THEN 'ES' ELSE SRC.COUNTRY_ORG_CD END) 
          || '|' || cast(try_cast(SRC.ORIG_ITEM_NR AS NUMBER) AS STRING) = WIK.WAWI_ITEM_NAT_KEY_NR
      AND WIK.WAWI_ITEM_KEY_TYPE_CD = 'WAWI'
      AND SRC.BUS_DT BETWEEN WIK.DWH_VALID_FROM_TMSP::DATE AND WIK.DWH_VALID_TO_TMSP::DATE;   
;
