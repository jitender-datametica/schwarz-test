/*
    SID generating for unknown combinations {context_country, orig_item_nr}.
    Substitute for the negative key capture.
*/
CREATE OR REPLACE TEMPORARY TABLE ETL.t_pos_items_tmp AS
(
    SELECT
        CASE WHEN Upper(context_country) = 'CS' THEN 'ES' ELSE Upper(context_country) END AS ctrcode
      , orig_item_nr::Number AS item_nr
      , Min(receipt_business_date) AS bus_dt
      , Coalesce(Min(item_desc), 'EJR-Dummy_1') AS item_descr
    FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
    WHERE receiptline_transactiontype_id in
         ('101','102','120','121','122','123','141','142','170','172','180','182'
         ,'201','202','220','221','222','223','270','272','280','282')
       OR receiptline_transactiontype_id in
         ('401','402','441','442','470','472','480','482','501','502','570','572','580','582','199',
          '601','602','641','642','670','672','680','682','299','701','702','770','772','780','782')
       OR receipt_transactiontype_id = '480'
    GROUP BY 1,2
);

CREATE OR REPLACE TEMPORARY TABLE ETL.t_pos_items_new_tmp (
    ctrcode VARCHAR(2) NOT NULL,
    item_nr NUMBER(38,0) NOT NULL,
    start_dt DATE NOT NULL,
    item_descr VARCHAR(40) NOT NULL
);

BEGIN TRANSACTION;

/* Lock the tables */
UPDATE meta.t_wawi_item_key_1         SET wawi_item_sid = -1         WHERE 0 = 1;
UPDATE meta.t_wawi_item_variant_key_1 SET wawi_item_variant_sid = -1 WHERE 0 = 1;
UPDATE core_rel.t_wawi_item_1         SET wawi_item_sid = -1         WHERE 0 = 1;
UPDATE core_rel.t_wawi_item_variant_1 SET wawi_item_variant_sid = -1 WHERE 0 = 1;

/* Need to generate dummy_1 item_1/variant */
INSERT INTO ETL.t_pos_items_new_tmp
(
    ctrcode
  , item_nr
  , start_dt
  , item_descr
)
SELECT
    ctrcode
  , item_nr
  , bus_dt
  , item_descr
FROM ETL.t_pos_items_tmp AS a
WHERE (ctrcode || '|' || item_nr) NOT IN
    (
        SELECT wawi_item_nat_key_nr
        FROM meta.t_wawi_item_key_1
    )
;


INSERT INTO meta.t_wawi_item_key_1
(
    wawi_item_sid
  , wawi_item_key_type_cd
  , dwh_valid_from_tmsp
  , dwh_valid_to_tmsp
  , dwh_valid_fg
  , wawi_item_nat_key_nr
  , dwh_created_tmsp
  , dwh_updated_tmsp
  , dwh_load_id
  , dwh_node_cd
)
SELECT
    max_sid.max_sid + Row_Number() OVER (ORDER BY src.ctrcode, src.item_nr)
  , 'WAWI'
  , To_Timestamp_LTZ('1900-01-01 00:00:00.000000000')
  , To_Timestamp_LTZ('9999-12-31 23:59:59.999999999')
  , True
  , src.ctrcode || '|' || src.item_nr
  , Current_Timestamp
  , Current_Timestamp
  , '${LOAD_ID}'
  , 'EJR' /* Indication that the line was created in the EJR loading */
FROM ETL.t_pos_items_new_tmp AS src
CROSS JOIN
(
    SELECT Coalesce(Max(wawi_item_sid), 0) AS max_sid
    FROM meta.t_wawi_item_key_1
) AS max_sid;

INSERT INTO meta.t_wawi_item_variant_key_1
(
    wawi_item_variant_sid
  , wawi_item_variant_key_type_cd
  , dwh_valid_from_tmsp
  , dwh_valid_to_tmsp
  , dwh_valid_fg
  , wawi_item_variant_nat_key_nr
  , dwh_created_tmsp
  , dwh_updated_tmsp
  , dwh_load_id
  , dwh_node_cd
)
SELECT
    max_sid.max_sid + Row_Number() OVER (ORDER BY src.ctrcode, src.item_nr)
  , 'WAWI'
  , To_Timestamp_LTZ('1900-01-01 00:00:00.000000000')
  , To_Timestamp_LTZ('9999-12-31 23:59:59.999999999')
  , True
  , src.ctrcode || '|' || src.item_nr || '|0'
  , Current_Timestamp
  , Current_Timestamp
  , '${LOAD_ID}'
  , 'EJR'
FROM ETL.t_pos_items_new_tmp AS src
CROSS JOIN
(
    SELECT Coalesce(Max(wawi_item_variant_sid), 0) AS max_sid
    FROM meta.t_wawi_item_variant_key_1
) AS max_sid;


INSERT INTO core_rel.t_wawi_item_1
(
    wawi_item_sid
  , dwh_valid_from_tmsp
  , dwh_valid_to_tmsp
  , dwh_valid_fg
  , country_org_sid
  , country_org_cd
  , wawi_item_nr
  , wawi_item_name
  , wawi_item_descr
  , wawi_item_creation_dt
  , dwh_created_tmsp
  , dwh_updated_tmsp
  , dwh_load_id
  , dwh_node_cd
)
SELECT
    wik.wawi_item_sid
  , CASE WHEN seq.seq_num = 0
             THEN To_Timestamp_LTZ('1900-01-01 00:00:00.000000000')
             ELSE src.start_dt
    END
  , CASE WHEN seq.seq_num = 0
             THEN TimestampAdd(ns, -1, src.start_dt)
             ELSE To_Timestamp_LTZ('9999-12-31 23:59:59.999999999')
    END
  , (seq.seq_num = 1)
  , cpk.party_sid
  , cio.country_org_cd
  , src.item_nr
  , src.item_descr
  , src.item_descr
  , DATE'1900-01-01'
  , Current_Timestamp
  , Current_Timestamp
  , '${LOAD_ID}'
  , 'EJR'
FROM ETL.t_pos_items_new_tmp AS src
INNER JOIN meta.t_wawi_item_key_1 AS wik
ON  src.ctrcode || '|' || src.item_nr = wik.wawi_item_nat_key_nr
AND wik.wawi_item_key_type_cd = 'WAWI'
AND wik.dwh_valid_fg = True
INNER JOIN meta.t_party_key_1 AS cpk
ON  src.ctrcode = cpk.party_nat_key_nr
AND cpk.party_key_type_cd = 'COUNTRY_1'
AND cpk.dwh_valid_fg = True
INNER JOIN core_rel.t_internal_organization_1 AS cio
ON  cpk.party_sid = cio.int_org_sid
AND cio.dwh_valid_fg = True
CROSS JOIN
(
    SELECT seq_num
    FROM
    (
        VALUES
        (0)
      , (1)
    ) AS a (seq_num)
) AS seq;

INSERT INTO core_rel.t_wawi_item_variant_1
(
    wawi_item_variant_sid
  , dwh_valid_from_tmsp
  , dwh_valid_to_tmsp
  , dwh_valid_fg
  , wawi_item_sid
  , country_org_sid
  , country_org_cd
  , wawi_item_variant_nr
  , wawi_item_variant_name
  , wawi_item_variant_descr
  , wawi_item_variant_creation_dt
  , case_size_cnt
  , weight_based_fg
  , dwh_created_tmsp
  , dwh_updated_tmsp
  , dwh_load_id
  , dwh_node_cd
)
SELECT
    wvk.wawi_item_variant_sid
  , CASE WHEN seq.seq_num = 0
             THEN To_Timestamp_LTZ('1900-01-01 00:00:00.000000000')
             ELSE src.start_dt
    END
  , CASE WHEN seq.seq_num = 0
             THEN TimestampAdd(ns, -1, src.start_dt)
             ELSE To_Timestamp_LTZ('9999-12-31 23:59:59.999999999')
    END
  , (seq.seq_num = 1)
  , wik.wawi_item_sid
  , cpk.party_sid
  , cio.country_org_cd
  , src.item_nr * 10000
  , src.item_descr
  , src.item_descr
  , DATE'1900-01-01'
  , 0
  , False
  , Current_Timestamp
  , Current_Timestamp
  , '${LOAD_ID}'
  , 'EJR'
FROM ETL.t_pos_items_new_tmp AS src
INNER JOIN meta.t_wawi_item_key_1 AS wik
ON  src.ctrcode || '|' || src.item_nr = wik.wawi_item_nat_key_nr
AND wik.wawi_item_key_type_cd = 'WAWI'
AND wik.dwh_valid_fg = True
INNER JOIN meta.t_wawi_item_variant_key_1 AS wvk
ON  src.ctrcode || '|' || src.item_nr || '|0' = wvk.wawi_item_variant_nat_key_nr
AND wvk.wawi_item_variant_key_type_cd = 'WAWI'
AND wvk.dwh_valid_fg = True
INNER JOIN meta.t_party_key_1 AS cpk
ON  src.ctrcode = cpk.party_nat_key_nr
AND cpk.party_key_type_cd = 'COUNTRY_1'
AND cpk.dwh_valid_fg = True
INNER JOIN core_rel.t_internal_organization_1 AS cio
ON  cpk.party_sid = cio.int_org_sid
AND cio.dwh_valid_fg = True
CROSS JOIN
(
    SELECT seq_num
    FROM
    (
        VALUES
        (0)
      , (1)
    ) AS a (seq_num)
) AS seq;

COMMIT; 




-- Clean out the tcache table.
DELETE FROM ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
 EXTRACTION_DATE,
        EXTRACTION_TS,
        BIC_ZMLILA,
        LOAD_ID,
        RECEIPT_TRANSACTIONTYPE_ID,
        CONTEXT_LOAD_ID,
        CONTEXT_COUNTRY,
        ORIG_WH_NR,
        ORIG_STORE_NR,
        POS_TERMINAL_ID,
        CHECKER_HASH,
        ORIG_RECEIPT_NR,
        ORIG_ITEM_NR,
        VAL_RETAIL,
        ORIG_CNT_SCANPOS,
        ORIG_CNT_DIRPOS,
        POS_TYPE,
        DUR_RECEIPT,
        RESUMED_TRANS_STORE_NR,
        RESUMED_TRANS_TERMINAL_ID,
        RESUMED_TRANS_DATE,
        RESUMED_TRANS_RECEIPT_NR,
        RECEIPT_BUSINESS_DATE,
        OFFLINE_FG,
        TRAINING_FG,
        DUR_SERVICE_TIME,
        DUR_PAY_CHANGE_TIME,
        VAL_RETAIL_NET,
        RECEIPTLINE_TIMESTAMP_BEGIN,
        RECEIPTLINE_TIMESTAMP_END,
        RECEIPTLINE_AUTHORITY_HASH,
        RECEIPT_AUTHORITY_HASH,
        RECEIPT_TIMESTAMP_BEGIN,
        RECEIPT_TIMESTAMP_END,
        ITEM_DESC,
        LIDLPLUS_CUSTOMER_CD,
        LIDLPLUS_IDENT_TYPE_CD,
        POSNR,
        POSART,
        ITEM_ENTRY_METHOD_CD,
        BARCODE,
        PRICE_RETAIL,
        QTY_SOLD,
        FG_WEIGHT,
        PRICE_SUM_RETAIL,
        PCT_DISCOUNT,
        VAL_DISCOUNT,
        CURRENCY_ISO_CD,
        DISCOUNT_NR,
        RECEIPTLINE_TRANSACTIONTYPE_ID,
        VAL_VAT,
        PRICE_ENTRY_METHOD_CD,
        PARENT_LINE_NR,
        PCT_VAT,
        VAL_DISCOUNT_BASE,
        QTY_DISCOUNT_POS,
        QTY_DISCOUNT_HQ,
        TENDERTYPE_CD,
        RETURN_REASON_CD,
        RETURN_TEXT,
        VOIDED_BY_LINE_NR,
        VAL_RETAIL_ORIG,
        TYPE_VAT,
        ORIGINAL_ORIG_RECEIPT_NR,
        ORIGINAL_POS_TERMINAL_ID,
        ORIGINAL_ORIG_STORE_NR,
        ORIGINAL_DAT_FORMDATE,
        CASH_REGISTER_SID,
        COUNTRY_ORG_SID,
        REAL_ESTATE_SID,
        STORE_SID,
        CUST_SID,
        RETAIL_EVENT_SID,
        COUNTRY_ORG_CD,
        CURR_CD,
        DWH_MAPPING_DT,
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
        SRC.EXTRACTION_DATE,
        SRC.EXTRACTION_TS,
        SRC.BIC_ZMLILA,
        SRC.LOAD_ID,
        SRC.RECEIPT_TRANSACTIONTYPE_ID,
        SRC.CONTEXT_LOAD_ID,
        SRC.CONTEXT_COUNTRY,
        SRC.ORIG_WH_NR,
        SRC.ORIG_STORE_NR,
        SRC.POS_TERMINAL_ID,
        SRC.CHECKER_HASH,
        SRC.ORIG_RECEIPT_NR,
        SRC.ORIG_ITEM_NR,
        SRC.VAL_RETAIL,
        SRC.ORIG_CNT_SCANPOS,
        SRC.ORIG_CNT_DIRPOS,
        REG.CASH_REGISTER_TYPE_CD AS POS_TYPE,
        SRC.DUR_RECEIPT,
        SRC.RESUMED_TRANS_STORE_NR,
        SRC.RESUMED_TRANS_TERMINAL_ID,
        SRC.RESUMED_TRANS_DATE,
        SRC.RESUMED_TRANS_RECEIPT_NR,
        SRC.RECEIPT_BUSINESS_DATE,
        SRC.OFFLINE_FG,
        SRC.TRAINING_FG,
        SRC.DUR_SERVICE_TIME,
        SRC.DUR_PAY_CHANGE_TIME,
        SRC.VAL_RETAIL_NET,
        SRC.RECEIPTLINE_TIMESTAMP_BEGIN,
        SRC.RECEIPTLINE_TIMESTAMP_END,
        SRC.RECEIPTLINE_AUTHORITY_HASH,
        SRC.RECEIPT_AUTHORITY_HASH,
        SRC.RECEIPT_TIMESTAMP_BEGIN,
        SRC.RECEIPT_TIMESTAMP_END,
        SRC.ITEM_DESC,
        SRC.LIDLPLUS_CUSTOMER_CD,
        SRC.LIDLPLUS_IDENT_TYPE_CD,
        SRC.POSNR,
        SRC.POSART,
        SRC.ITEM_ENTRY_METHOD_CD,
        SRC.BARCODE,
        SRC.PRICE_RETAIL,
        SRC.QTY_SOLD,
        SRC.FG_WEIGHT,
        SRC.PRICE_SUM_RETAIL,
        SRC.PCT_DISCOUNT,
        SRC.VAL_DISCOUNT,
        SRC.CURRENCY_ISO_CD,
        SRC.DISCOUNT_NR,
        SRC.RECEIPTLINE_TRANSACTIONTYPE_ID,
        SRC.VAL_VAT,
        SRC.PRICE_ENTRY_METHOD_CD,
        SRC.PARENT_LINE_NR,
        SRC.PCT_VAT,
        SRC.VAL_DISCOUNT_BASE,
        SRC.QTY_DISCOUNT_POS,
        SRC.QTY_DISCOUNT_HQ,
        SRC.TENDERTYPE_CD,
        SRC.RETURN_REASON_CD,
        SRC.RETURN_TEXT,
        SRC.VOIDED_BY_LINE_NR,
        SRC.VAL_RETAIL_ORIG,
        SRC.TYPE_VAT,
        SRC.ORIGINAL_ORIG_RECEIPT_NR,
        SRC.ORIGINAL_POS_TERMINAL_ID,
        SRC.ORIGINAL_ORIG_STORE_NR,
        SRC.ORIGINAL_DAT_FORMDATE,
        SRC.CASH_REGISTER_SID,
        SRC.COUNTRY_ORG_SID,
        SRC.REAL_ESTATE_SID,
        SRC.STORE_SID,
        SRC.CUST_SID,
        SRC.RETAIL_EVENT_SID,
        IO.COUNTRY_ORG_CD,
        IO.CURR_CD,
        SRC.DWH_MAPPING_DT,
        'EJR' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'EJR' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM  ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
LEFT  OUTER JOIN CORE_REL.T_INTERNAL_ORGANIZATION_1 IO
ON    SRC.COUNTRY_ORG_SID = IO.INT_ORG_SID
AND   SRC.RECEIPT_BUSINESS_DATE BETWEEN IO.DWH_VALID_FROM_TMSP AND IO.DWH_VALID_TO_TMSP
LEFT  OUTER JOIN (SELECT DISTINCT CASH_REGISTER_TYPE_CD FROM CORE_REL.T_CASH_REGISTER_TYPE_1) REG
ON    SRC.POS_TYPE = REG.CASH_REGISTER_TYPE_CD  -- Non-existent cash_register_types will be set to NULL (as per requirement).
WHERE NVL(SRC.POS_TYPE,'@')  <> 'FVS' -- Fruit & Veg Receipts are not really receipts (these will also be phased out soon), see https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64517
;
