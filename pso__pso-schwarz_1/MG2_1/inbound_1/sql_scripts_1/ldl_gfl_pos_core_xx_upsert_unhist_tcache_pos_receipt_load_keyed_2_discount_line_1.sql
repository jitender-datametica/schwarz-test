CREATE OR REPLACE TEMPORARY TABLE ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_stage AS
SELECT
        UPPER(context_country || '|' || discount_nr) AS promo_nat_key_nr,
        retail_event_sid,
        posnr AS retail_event_line_seq,
        receiptline_timestamp_begin AS event_tmsp,
        receipt_business_date AS bus_dt,
        store_sid,
        country_org_sid,
        country_org_cd,
        real_estate_sid,
        cash_register_sid,
        pos_type AS cash_register_type_cd,
        NULL AS cash_register_usg_type_cd,
        checker_hash AS cashier_hash,
        receiptline_authority_hash AS auth_by_hash,
        cust_sid,
        receiptline_transactiontype_id AS retail_event_line_scenario_id,
        CASE WHEN fg_weight <> '1'
               THEN CASE WHEN receiptline_transactiontype_id BETWEEN 400 and 599
                           THEN qty_discount_pos    
                         WHEN  receiptline_transactiontype_id BETWEEN 600 and 799
                           THEN qty_discount_hq
                     END
             ELSE NULL
        END AS discounted_cnt,
        CASE WHEN fg_weight = '1'
               THEN CASE WHEN receiptline_transactiontype_id BETWEEN 400 and 599
                           THEN qty_discount_pos
                         WHEN  receiptline_transactiontype_id BETWEEN 600 and 799
                           THEN qty_discount_hq
                   END
               ELSE NULL
        END AS discounted_qty,
        CASE WHEN fg_weight <> '1' 
               THEN CASE WHEN context_country = 'US'
                           THEN 'LB'
                         ELSE 'KG'
                    END
             ELSE NULL
        END AS uom_cd,
        val_discount_base AS discounted_val,
        val_discount AS discount_val,
        curr_cd,
        pct_discount AS discount_pct,
        item_desc AS discount_name,
        NULL AS discount_type_cd,
        NULL AS discount_reason_cd,
        NULL AS discount_calc_rule_cd,
        parent_line_nr AS discounted_line_seq,
        voided_by_line_nr AS cancel_line_seq,
        (CASE WHEN retail_event_line_scenario_id BETWEEN 400 AND 599
              THEN 0                     /* Discount Node */
              ELSE posnr /* PriceModifier Node */ END) as discount_seq,
        'False' AS split_fg,
        context_country,
        orig_item_nr,
        barcode
FROM ${TEMP_DB}.V_${SRC_INPUT_TABLE} src
WHERE receiptline_transactiontype_id IN
     ('401','402','441','442','470','472','480','482','501','502','570','572','580','582','199',
      '601','602','641','642','670','672','680','682','299','701','702','770','772','780','782')
QUALIFY Row_Number() OVER (  PARTITION BY
        context_country
      , orig_store_nr
      , pos_terminal_id
      , orig_receipt_nr
      , receipt_business_date
      , parent_line_nr
      , posnr
      , retail_event_line_scenario_id
      , receiptline_timestamp_begin
      ORDER BY receipt_timestamp_end DESC
) = 1;


BEGIN TRANSACTION;

DELETE FROM meta.t_promotion_key_1  -- Prevent any concurrent access to this keyspace
WHERE 1=2;

INSERT INTO meta.t_promotion_key_1 
(
        promo_sid,
        promo_key_type_cd,
        promo_nat_key_nr,
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
        max_seq + row_number() over(order by 1) AS promo_sid,
        'STORE',
        promo_nat_key_nr,
        current_timestamp,
        current_timestamp,
        current_timestamp,
        '9999-12-31 23:59:59'
        ,TRUE
        ,'EJR'
        ,'${LOAD_ID}'       
FROM (SELECT DISTINCT promo_nat_key_nr AS promo_nat_key_nr
       FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_stage
      ) t1_1                            
CROSS JOIN (SELECT COALESCE(MAX(promo_sid),0) AS max_seq FROM meta.t_promotion_key_1) AS max_seq
WHERE 
promo_nat_key_nr IS NOT NULL 
AND NOT EXISTS
        (
         SELECT 1 FROM meta.t_promotion_key_1 t2 
         WHERE
         UPPER(t2.promo_key_type_cd) = 'STORE' AND
         current_timestamp between t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND
         UPPER(t2.promo_nat_key_nr) =  UPPER(t1.promo_nat_key_nr)
        ) 
)
;

COMMIT;

BEGIN TRANSACTION;

DELETE FROM meta.t_product_variant_key_1 -- Prevent any concurrent access to this keyspace
WHERE 1=2;

/* Old code 
INSERT INTO meta.t_product_variant_key_1 
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
        UPPER(t1.context_country || '|' || t1.orig_item_nr) AS natural_key,
        current_timestamp,
        current_timestamp,
        current_timestamp,
        '9999-12-31 23:59:59'
        ,TRUE
        ,t1.dwh_node_cd
        ,'${LOAD_ID}'       
FROM (SELECT t1.dwh_node_cd, context_country, orig_item_nr, barcode
        FROM (SELECT 'EJR' AS dwh_node_cd, UPPER(context_country) AS context_country, orig_item_nr, barcode 
              FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_stage t1_1
              ) t1_1              
        GROUP BY t1.dwh_node_cd, context_country, orig_item_nr, barcode) t1_1
        
CROSS JOIN (SELECT COALESCE(MAX(prod_variant_sid),0) AS max_seq FROM meta.t_product_variant_key_1) AS max_seq

WHERE 
natural_key IS NOT NULL 
AND NOT EXISTS
        (
         SELECT 1 FROM meta.t_product_variant_key_1 t2 
         WHERE
         UPPER(t2.prod_variant_key_type_cd) = 'SLS_UNK' AND
         current_timestamp between t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND -- Accomodates historized SID association (full capability not implemented in initial release)
         UPPER(t2.prod_variant_nat_key_nr) = UPPER(t1.context_country|| '|' || t1.orig_item_nr) 
        )     
AND NOT EXISTS
        (
         SELECT 1 FROM meta.t_product_variant_key_1 t2 
         WHERE
         UPPER(t2.prod_variant_key_type_cd) = 'SLS_GTIN' AND
         current_timestamp between t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND -- Accomodates historized SID association (full capability not implemented in initial release)
         UPPER(t2.prod_variant_nat_key_nr) = t1.orig_item_nr || '|' || t1.barcode 
        )     
) ;
*/

INSERT INTO meta.t_product_variant_key_1
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
SELECT  
        max_seq + row_number() OVER (ORDER BY UPPER(t1.context_country || '|' || t1.orig_item_nr)) AS prod_variant_sid,
        'SLS_UNK' as prod_variant_key_type_cd,
        UPPER(t1.context_country || '|' || t1.orig_item_nr) AS prod_variant_nat_key_nr,
        current_timestamp as dwh_created_tmsp,
        current_timestamp as dwh_updated_tmsp,
        current_timestamp as dwh_valid_from_tmsp,
        '9999-12-31 23:59:59.99999999' as dwh_valid_to_tmsp,
        TRUE as dwh_valid_fg,
        'EJR' AS dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id
FROM
(
    /* Generate the new SIDs only for distinct {country_1, orig_item_nr} sets, without the barcode column */
    SELECT DISTINCT
        context_country
      , orig_item_nr
    FROM
    (
        /* Check the GTIN and Unknown key existence using the distinct {country_1, orig_item_nr, barcode} sets */
        SELECT DISTINCT UPPER(context_country) AS context_country, orig_item_nr, barcode 
        FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_stage t1_1
    ) t1_1

    WHERE 
        NOT EXISTS
            (
             SELECT 1 FROM meta.t_product_variant_key_1 t2
             WHERE
             UPPER(t2.prod_variant_key_type_cd) = 'SLS_UNK' AND
             current_timestamp BETWEEN t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND -- Accomodates historized SID association (full capability not implemented in initial release)
             UPPER(t2.prod_variant_nat_key_nr) = UPPER(t1.context_country|| '|' || t1.orig_item_nr)
            )     
    AND NOT EXISTS
            (
             SELECT 1 FROM meta.t_product_variant_key_1 t2 
             WHERE
             UPPER(t2.prod_variant_key_type_cd) = 'SLS_GTIN' AND
             current_timestamp BETWEEN t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND -- Accomodates historized SID association (full capability not implemented in initial release)
             UPPER(t2.prod_variant_nat_key_nr) = t1.orig_item_nr || '|' || t1.barcode
            )
) AS t1_1

CROSS JOIN (SELECT COALESCE(MAX(prod_variant_sid),0) AS max_seq FROM meta.t_product_variant_key_1) AS max_seq

WHERE prod_variant_nat_key_nr IS NOT NULL
;

COMMIT;

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(       
        retail_event_sid,
        retail_event_line_seq,
        discount_seq,
        discounted_line_seq,
        event_tmsp,
        bus_dt,
        store_sid,
        country_org_sid,
        country_org_cd,
        real_estate_sid,
        cash_register_sid,
        cash_register_type_cd,
        cash_register_usg_type_cd,
        cashier_hash,
        auth_by_hash,
        cust_sid,
        retail_event_line_scenario_id,
        prod_variant_sid,
        wawi_item_sid,
        discounted_cnt,
        discounted_qty,
        uom_cd,
        discounted_val,
        discount_val,
        curr_cd,
        discount_pct,
        discount_name,
        promo_sid,
        discount_type_cd,
        discount_reason_cd,
        discount_calc_rule_cd,
        cancel_line_seq,
        split_fg,
        --****************
        source_system,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
SELECT
        retail_event_sid,
        retail_event_line_seq,
        discount_seq,
        discounted_line_seq,
        event_tmsp,
        bus_dt,
        store_sid,
        country_org_sid,
        country_org_cd,
        real_estate_sid,
        cash_register_sid,
        cash_register_type_cd,
        cash_register_usg_type_cd,
        cashier_hash,
        auth_by_hash,
        cust_sid,
        retail_event_line_scenario_id,
        IFNULL(t3.prod_variant_sid,t2.prod_variant_sid) AS prod_variant_sid,
        COALESCE(wik.wawi_item_sid, -1) as wawi_item_sid,
        discounted_cnt,
        discounted_qty,
        uom_cd,
        discounted_val,
        discount_val,
        curr_cd,
        discount_pct,
        discount_name,
        promo_sid,
        discount_type_cd,
        discount_reason_cd,
        discount_calc_rule_cd,
        cancel_line_seq,
        split_fg,
            --****************
        'EJR' AS source_system,
        CURRENT_DATE AS extraction_dt,
        current_timestamp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        'V_${SRC_INPUT_TABLE}' AS filename,
        'EJR' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id 
FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_stage t1_1
LEFT OUTER JOIN meta.t_product_variant_key_1 t2  ON
         UPPER(t2.prod_variant_key_type_cd) = 'SLS_UNK' AND
         current_timestamp BETWEEN t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND
         UPPER(t2.prod_variant_nat_key_nr) = UPPER(t1.context_country|| '|' || t1.orig_item_nr)
LEFT OUTER JOIN meta.t_product_variant_key_1 t3 ON
         UPPER(t3.prod_variant_key_type_cd) = 'SLS_GTIN' AND
         current_timestamp BETWEEN t3.dwh_valid_from_tmsp AND t3.dwh_valid_to_tmsp AND
         UPPER(t3.prod_variant_nat_key_nr) = t1.orig_item_nr || '|' || t1.barcode 
JOIN meta.t_promotion_key_1 p ON p.promo_key_type_cd = 'STORE' AND UPPER(p.promo_nat_key_nr) = UPPER(t1.promo_nat_key_nr)
LEFT OUTER JOIN META.T_WAWI_ITEM_KEY_1 WIK
      ON  UPPER(CASE WHEN t1.country_org_cd='CS' THEN 'ES' ELSE t1.country_org_cd END) 
          || '|' || cast(try_cast(t1.orig_item_nr AS NUMBER) AS STRING) = wik.wawi_item_nat_key_nr
      AND wik.wawi_item_key_type_cd = 'WAWI'
     AND t1.bus_dt BETWEEN wik.dwh_valid_from_tmsp::DATE and wik.dwh_valid_to_tmsp::DATE
;
