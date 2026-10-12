--!SET exit_on_error=True;


MERGE INTO ldl_data_production_core_app_fraud_detection.t_cashier_encryption AS tgt
USING ((((((((((((((((((((SELECT bic_zmlila,
                      receipt_business_date,
                      orig_store_nr,
                      checker_hash,
                      checker_id
                     FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utca
                     WHERE checker_hash <> '@'
                      AND checker_id IS NOT NULL
                     UNION DISTINCT
                     SELECT bic_zmlila,
                      receipt_business_date,
                      orig_store_nr,
                      receipt_authority_hash AS checker_hash,
                      receipt_authority_id AS checker_id
                     FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utca
                     WHERE receipt_authority_hash <> '@'
                      AND receipt_authority_id IS NOT NULL)
                    UNION DISTINCT
                    SELECT bic_zmlila,
                     receipt_business_date,
                     orig_store_nr,
                     receiptline_authority_hash AS checker_hash,
                     receiptline_authority_id AS checker_id
                    FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utca
                    WHERE receiptline_authority_hash <> '@'
                     AND receiptline_authority_id IS NOT NULL)
                   UNION DISTINCT
                   SELECT bic_zmlila,
                    receipt_business_date,
                    orig_store_nr,
                    checker_hash,
                    checker_id
                   FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcb1
                   WHERE checker_hash <> '@'
                    AND checker_id IS NOT NULL)
                  UNION DISTINCT
                  SELECT bic_zmlila,
                   receipt_business_date,
                   orig_store_nr,
                   receipt_authority_hash AS checker_hash,
                   receipt_authority_id AS checker_id
                  FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcb1
                  WHERE receipt_authority_hash <> '@'
                   AND receipt_authority_id IS NOT NULL)
                 UNION DISTINCT
                 SELECT bic_zmlila,
                  receipt_business_date,
                  orig_store_nr,
                  receiptline_authority_hash AS checker_hash,
                  receiptline_authority_id AS checker_id
                 FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcb1
                 WHERE receiptline_authority_hash <> '@'
                  AND receiptline_authority_id IS NOT NULL)
                UNION DISTINCT
                SELECT bic_zmlila,
                 receipt_business_date,
                 orig_store_nr,
                 checker_hash,
                 checker_id
                FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcb2
                WHERE checker_hash <> '@'
                 AND checker_id IS NOT NULL)
               UNION DISTINCT
               SELECT bic_zmlila,
                receipt_business_date,
                orig_store_nr,
                receipt_authority_hash AS checker_hash,
                receipt_authority_id AS checker_id
               FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcb2
               WHERE receipt_authority_hash <> '@'
                AND receipt_authority_id IS NOT NULL)
              UNION DISTINCT
              SELECT bic_zmlila,
               receipt_business_date,
               orig_store_nr,
               receiptline_authority_hash AS checker_hash,
               receiptline_authority_id AS checker_id
              FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcb2
              WHERE receiptline_authority_hash <> '@'
               AND receiptline_authority_id IS NOT NULL)
             UNION DISTINCT
             SELECT bic_zmlila,
              receipt_business_date,
              orig_store_nr,
              checker_hash,
              checker_id
             FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcb3
             WHERE checker_hash <> '@'
              AND checker_id IS NOT NULL)
            UNION DISTINCT
            SELECT bic_zmlila,
             receipt_business_date,
             orig_store_nr,
             receipt_authority_hash AS checker_hash,
             receipt_authority_id AS checker_id
            FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcb3
            WHERE receipt_authority_hash <> '@'
             AND receipt_authority_id IS NOT NULL)
           UNION DISTINCT
           SELECT bic_zmlila,
            receipt_business_date,
            orig_store_nr,
            receiptline_authority_hash AS checker_hash,
            receiptline_authority_id AS checker_id
           FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcb3
           WHERE receiptline_authority_hash <> '@'
            AND receiptline_authority_id IS NOT NULL)
          UNION DISTINCT
          SELECT bic_zmlila,
           receipt_business_date,
           orig_store_nr,
           checker_hash,
           checker_id
          FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcc
          WHERE checker_hash <> '@'
           AND checker_id IS NOT NULL)
         UNION DISTINCT
         SELECT bic_zmlila,
          receipt_business_date,
          orig_store_nr,
          receipt_authority_hash AS checker_hash,
          receipt_authority_id AS checker_id
         FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcc
         WHERE receipt_authority_hash <> '@'
          AND receipt_authority_id IS NOT NULL)
        UNION DISTINCT
        SELECT bic_zmlila,
         receipt_business_date,
         orig_store_nr,
         receiptline_authority_hash AS checker_hash,
         receiptline_authority_id AS checker_id
        FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcc
        WHERE receiptline_authority_hash <> '@'
         AND receiptline_authority_id IS NOT NULL)
       UNION DISTINCT
       SELECT bic_zmlila,
        receipt_business_date,
        orig_store_nr,
        checker_hash,
        checker_id
       FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcd
       WHERE checker_hash <> '@'
        AND checker_id IS NOT NULL)
      UNION DISTINCT
      SELECT bic_zmlila,
       receipt_business_date,
       orig_store_nr,
       receipt_authority_hash AS checker_hash,
       receipt_authority_id AS checker_id
      FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcd
      WHERE receipt_authority_hash <> '@'
       AND receipt_authority_id IS NOT NULL)
     UNION DISTINCT
     SELECT bic_zmlila,
      receipt_business_date,
      orig_store_nr,
      receiptline_authority_hash AS checker_hash,
      receiptline_authority_id AS checker_id
     FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utcd
     WHERE receiptline_authority_hash <> '@'
      AND receiptline_authority_id IS NOT NULL)
    UNION DISTINCT
    SELECT bic_zmlila,
     receipt_business_date,
     orig_store_nr,
     checker_hash,
     checker_id
    FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utce
    WHERE checker_hash <> '@'
     AND checker_id IS NOT NULL)
   UNION DISTINCT
   SELECT bic_zmlila,
    receipt_business_date,
    orig_store_nr,
    receipt_authority_hash AS checker_hash,
    receipt_authority_id AS checker_id
   FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utce
   WHERE receipt_authority_hash <> '@'
    AND receipt_authority_id IS NOT NULL)
  UNION DISTINCT
  SELECT bic_zmlila,
   receipt_business_date,
   orig_store_nr,
   receiptline_authority_hash AS checker_hash,
   receiptline_authority_id AS checker_id
  FROM ldl_data_production_etl.t_tcache_pos_receipt_load_utce
  WHERE receiptline_authority_hash <> '@'
   AND receiptline_authority_id IS NOT NULL) AS src
ON tgt.cashier_hash = src.checker_hash
WHEN NOT MATCHED THEN INSERT VALUES(src.checker_hash, src.receipt_business_date, CAST(src.orig_store_nr AS STRING), src
 .bic_zmlila, src.checker_id, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), CAST(${LOAD_ID} AS INTEGER), 'EJR');